library(tidyverse)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path)) 
mtpl <- read.table('../data/PC_data.txt',
                   header = TRUE, stringsAsFactors = TRUE) %>% 
  as_tibble() %>% rename_all(tolower) %>% rename(expo = exp)

require(rsample)
set.seed(1)
data_split <- initial_split(mtpl)
mtpl_train <- training(data_split)
mtpl_test  <- testing(data_split)

mtpl_train <- mtpl_train[sample(nrow(mtpl_train)), ]


library(mgcv)
gam_age <- gam(nclaims ~ s(ageph), 
               data = mtpl_train, 
               family = poisson, 
               offset = log(expo))


library(keras)

input_expo <- layer_input(shape = 1, name = 'exposure')
input_gam <- layer_input(shape = 1, name = 'gam')
input_nn <- layer_input(shape = 1, name = 'nn')

network <- input_nn %>% 
  layer_batch_normalization() %>% 
  layer_dense(units = 5,
              activation = 'tanh') %>%
  layer_dense(units = 1, 
              activation = 'linear')

output <- list(network, input_expo, input_gam) %>% 
  layer_add() %>% 
  layer_dense(units = 1, activation = 'exponential', trainable = FALSE, name = 'output',
              weights = list(array(1, dim = c(1,1)), array(0, dim = c(1))))

model <- keras_model(inputs = list(input_expo, input_gam, input_nn),
                     outputs = output)

model %>% compile(loss = 'poisson',
                  optimize = optimizer_rmsprop(),
                  metrics = c('mse'))
summary(model)

#devtools::install_github("andrie/deepviz")
model %>% deepviz::plot_model()

data_input <- list('exposure' = log(mtpl_train$expo),
                   'gam' = log(predict(gam_age, newdata = mtpl_train, type = 'response')),
                   'nn' = mtpl_train$ageph)
model %>% fit(x = data_input, 
              y = mtpl_train$nclaims,
              epochs = 10, 
              batch_size = 1024, 
              validation_split = 0.2)

# NN adjustments
df <- tibble::tibble(age = 18:100,
                     expo = 0,
                     gam = 0)
df <- df %>% dplyr::mutate(effect = model %>% predict(list(df$expo, df$gam, df$age)))
ggplot(df) + theme_bw() + geom_point(aes(age, effect))

# NN + GAM effect
df <- tibble::tibble(ageph = 18:100,
                     expo = 0,
                     gam = log(predict(gam_age, newdata = as.data.frame(ageph), type = 'response')))
df <- df %>% dplyr::mutate(effect = model %>% predict(list(df$expo, df$gam, df$ageph)))
ggplot(df) + theme_bw() + geom_point(aes(ageph, effect)) + geom_line(aes(ageph, exp(gam)))
