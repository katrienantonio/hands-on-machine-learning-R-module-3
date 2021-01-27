##############################################
# Regression with neural networks
##############################################



## --------------------------------------------------------------------------------------------------------------------------------------------------
library(tidyverse)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path)) 
mtpl <- read.table('../data/PC_data.txt',
                   header = TRUE, stringsAsFactors = TRUE) %>% 
  as_tibble() %>% rename_all(tolower) %>% rename(expo = exp)



## --------------------------------------------------------------------------------------------------------------------------------------------------
library(rsample)
set.seed(54321)
data_split <- initial_split(mtpl)
mtpl_train <- training(data_split)
mtpl_test  <- testing(data_split)
# Reshuffling of the training observations
mtpl_train <- mtpl_train[sample(nrow(mtpl_train)), ]


## --------------------------------------------------------------------------------------------------------------------------------------------------
library(keras)
nn_freq_intercept <- 
  keras_model_sequential() %>%
  layer_dense(units = 1, 
              activation = 'exponential', 
              input_shape = c(1), 
              use_bias = FALSE) %>%
  compile(loss = 'poisson',
          optimize = optimizer_rmsprop())


## --------------------------------------------------------------------------------------------------------------------------------------------------
nn_freq_intercept$count_params()
summary(nn_freq_intercept)


## --------------------------------------------------------------------------------------------------------------------------------------------------
intercept <- rep(1, nrow(mtpl_train))

counts <- mtpl_train$nclaims

## --------------------------------------------------------------------------------------------------------------------------------------------------
nn_freq_intercept %>% fit(x = intercept,
                          y = counts,
                          epochs = 30,
                          batch_size = 1024,
                          validation_split = 0)


## --------------------------------------------------------------------------------------------------------------------------------------------------
glm_freq_intercept <- glm(nclaims ~ 1,
                          data = mtpl_train,
                          family = poisson(link = 'log'))

# GLM coefficients
glm_freq_intercept$coefficients

## NN weights
nn_freq_intercept$get_weights()


## Your Turn!
## --------------------------------------------------------------------------------------------------------------------------------------------------

nn_binary <- 
  keras_model_sequential() %>%
  layer_dense(units = 1, 
              activation = ..., 
              input_shape = c(1), 
              use_bias = FALSE) %>%
  compile(loss = ...,
          optimize = optimizer_rmsprop(),
          metrics = ...)

nn_binary %>% fit(x = intercept,
                  y = ...,
                  epochs = ...,
                  batch_size = ...,
                  validation_split = 0)


glm_binary <- glm(... ~ 1, 
                  data = mtpl_train, 
                  family = ...)












## --------------------------------------------------------------------------------------------------------------------------------------------------
glm_offset <- glm(nclaims ~ ageph,
                  family = poisson(link = 'log'),
                  data = mtpl_train,
                  offset = log(expo))
glm_offset$coefficients

glm_weights <- glm(nclaims / expo ~ ageph,
                   family = poisson(link = 'log'),
                   data = mtpl_train,
                   weights = expo)
glm_weights$coefficients


## --------------------------------------------------------------------------------------------------------------------------------------------------
nn_freq_exposure <- 
  keras_model_sequential() %>%
  layer_dense(units = 1, 
              activation = 'exponential', 
              input_shape = c(1), 
              use_bias = FALSE) %>%
  compile(loss = 'poisson',
          optimize = optimizer_rmsprop())


## --------------------------------------------------------------------------------------------------------------------------------------------------
exposure <- mtpl_train$expo


## --------------------------------------------------------------------------------------------------------------------------------------------------
nn_freq_exposure %>%
  fit(x = intercept,
      y = counts / exposure,
      sample_weight = exposure,
      epochs = 20,
      batch_size = 1024,
      validation_split = 0)


## --------------------------------------------------------------------------------------------------------------------------------------------------
ageph <- mtpl_train$ageph

## --------------------------------------------------------------------------------------------------------------------------------------------------
nn_freq_ageph <- 
  keras_model_sequential() %>%
  layer_batch_normalization(input_shape = c(1)) %>%
  layer_dense(units = 5,
              activation = 'tanh') %>%
  layer_dense(units = 1, 
              activation = 'exponential', 
              use_bias = TRUE) %>%
  compile(loss = 'poisson',
          optimize = optimizer_rmsprop())


## --------------------------------------------------------------------------------------------------------------------------------------------------
nn_freq_ageph %>%
  fit(x = ageph,
      y = counts / exposure,
      sample_weight = exposure,
      epochs = 20,
      batch_size = 1024,
      validation_split = 0)


## --------------------------------------------------------------------------------------------------------------------------------------------------
library(mgcv)
gam_ageph <- gam(nclaims ~ s(ageph),
                 data = mtpl_train, 
                 family = poisson(link = 'log'), 
                 offset = log(expo))


## --------------------------------------------------------------------------------------------------------------------------------------------------
df_age <- tibble::tibble(
  age = 18:95,
  NN = as.numeric(predict(nn_freq_ageph, age)),
  GAM = predict(gam_ageph, type = 'response',
                newdata = data.frame(ageph = age))
)
ggplot(df_age, aes(x = age)) + geom_line(aes(y = GAM)) + geom_point(aes(y = NN)) +
  theme_bw() + labs(y = 'Fitted effect') + ggtitle('NN (dots) vs. GAM (line)')



## --------------------------------------------------------------------------------------------------------------------------------------------------
input_skip <- layer_input(shape = c(1), name = 'skip')
input_nn <- layer_input(shape = c(1), name = 'nn')

network <- input_nn %>% layer_batch_normalization() %>% layer_dense(units = 5, activation = 'tanh') %>%
  layer_dense(units = 1, activation = 'linear')

output <- list(network, input_skip) %>% layer_add() %>% 
  layer_dense(units = 1, activation = 'exponential', trainable = FALSE, name = 'output',
              weights = list(array(1, dim = c(1,1)), array(0, dim = c(1))))

cann <- keras_model(inputs = list(input_nn, input_skip), outputs = output)

cann %>% compile(loss = 'poisson', optimize = optimizer_rmsprop())


## --------------------------------------------------------------------------------------------------------------------------------------------------
gam_expo <- predict(gam_ageph) + log(mtpl_train$expo)


## --------------------------------------------------------------------------------------------------------------------------------------------------
cann_input <- list('nn' = mtpl_train$ageph,
                   'skip' = gam_expo)


## --------------------------------------------------------------------------------------------------------------------------------------------------
cann %>% fit(x = cann_input,
             y = counts,
             epochs = 20,
             batch_size = 1024,
             validation_split = 0)


## --------------------------------------------------------------------------------------------------------------------------------------------------
df <- tibble::tibble(ageph = 18:95,
                     skip = 0)
df <- df %>% dplyr::mutate(effect = cann %>% predict(list(df$ageph, df$skip)))
ggplot(df) + theme_bw() + geom_point(aes(ageph, effect)) + ggtitle('NN adjustments')


## --------------------------------------------------------------------------------------------------------------------------------------------------
df <- tibble::tibble(ageph = 18:95,
                     skip = predict(gam_ageph, newdata = as.data.frame(ageph)))
df <- df %>% dplyr::mutate(effect = cann %>% predict(list(df$ageph, df$skip)))
ggplot(df, aes(x = ageph)) + geom_point(aes(y = effect)) + geom_line(aes(y = exp(skip))) + 
  theme_bw() + ggtitle('CANN (dots) vs. GAM (line)')


## --------------------------------------------------------------------------------------------------------------------------------------------------
nn_sev_log <- keras_model_sequential() %>%
  layer_dense(units = 1, activation = 'linear', 
              input_shape = c(1), use_bias = FALSE) %>%
  compile(loss = 'mse',
          optimize = optimizer_rmsprop())

## --------------------------------------------------------------------------------------------------------------------------------------------------
claims <- mtpl_train %>% dplyr::filter(nclaims > 0)


## --------------------------------------------------------------------------------------------------------------------------------------------------
nn_sev_log %>% 
  fit(x = rep(1, nrow(claims)),
      y = log(claims$avg),
      epochs = 100, batch_size = 128, 
      validation_split = 0)

## --------------------------------------------------------------------------------------------------------------------------------------------------
predict(nn_sev_log, 1) %>% exp() %>% as.numeric()
claims$avg %>% summary()



## Your Turn!
## --------------------------------------------------------------------------------------------------------------------------------------------------




