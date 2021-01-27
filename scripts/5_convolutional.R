##############################################
# Convolutional neural networks
##############################################



## --------------------------------------------------------------------------------------------------------------------------------------------------
setwd(dirname(rstudioapi::getActiveDocumentContext()$path)) 
load('../data/mnist.RData')
input <- mnist$train$x
output <- mnist$train$y
test_input <- mnist$test$x
test_output <- mnist$test$y

library(tidyverse)
plot_image <- function(data, legend = TRUE) {
  dimension <- sqrt(length(data))
  df <- data.frame(col = rep(1:dimension, dimension), row = rep(dimension:1, each = dimension), value = data);
  figure <- ggplot(df) +
    theme_void() +
    xlab('') + ylab('') +
    geom_raster(aes(x = col, y = row, fill = value))
  
  if(all(data >= 0)) {
    figure <- figure + scale_fill_gradient(high = 'white', low = 'black')
  } else {
    figure <- figure + scale_fill_gradient2(low = 'red', mid = 'white', high = 'green', midpoint = 0)
  }
  
  if(!legend) {
    figure <- figure + theme(legend.position = 'none')
  }
  
  return(figure)
}


## --------------------------------------------------------------------------------------------------------------------------------------------------
library(keras)
model <- keras_model_sequential() %>%
  layer_conv_2d(filters = 8,
                kernel_size = c(3, 3),
                strides = c(1, 1),
                input_shape = c(28, 28, 1))
summary(model)


## --------------------------------------------------------------------------------------------------------------------------------------------------
model <- model %>% 
  layer_max_pooling_2d(pool_size = c(2, 2),
                       strides = c(2, 2))
summary(model)


## --------------------------------------------------------------------------------------------------------------------------------------------------
model <- model %>% 
  layer_flatten()
summary(model)


## Your Turn!
## --------------------------------------------------------------------------------------------------------------------------------------------------

input_conv <- input / 255
dim(input_conv)

input_conv <- k_expand_dims(input_conv, axis = 4)
dim(input_conv)

output <- keras::to_categorical(output, 10)

model <- keras_model_sequential() %>%
  layer_conv_2d(filters = ..., 
                kernel_size = ..., 
                input_shape = c(28, 28, 1)) %>%
  layer_max_pooling_2d(pool_size = ...) %>%
  layer_flatten() %>%
  layer_dense(units = ..., 
              activation = ...) %>%
  compile(loss = ...,
          optimize = ...,
          metrics = ...) 

model %>% fit(...,
              ..., 
              epochs = ..., 
              batch_size = ..., 
              validation_split = ...)


test_input_conv <- k_expand_dims(test_input / 255, axis = 4)
test_output <- keras::to_categorical(test_output, 10)

model %>%  evaluate(..., 
                    ...,verbose = 0)




## --------------------------------------------------------------------------------------------------------------------------------------------------
prediction <- model %>% predict(test_input_conv)
category <- apply(prediction, 1, which.max) - 1
actual_category <- apply(test_output, 1, which.max) - 1
head(which(actual_category != category))


## --------------------------------------------------------------------------------------------------------------------------------------------------
index <- 9
test_input <- tensorflow::array_reshape(test_input,
                                        c(nrow(test_input), 28*28)) / 255
plot_image(test_input[index, ]) +
  ggtitle(paste('actual: ', actual_category[index], 
                ' predicted: ', category[index], sep='')) +
  theme(legend.position = 'none', 
        plot.title = element_text(hjust = 0.5))


## --------------------------------------------------------------------------------------------------------------------------------------------------
set.seed(1)
random <- runif(28*28)
random_conv <- matrix(random, nrow = 28, ncol = 28)
random_conv <- k_expand_dims(random_conv, axis = 1)
random_conv <- k_expand_dims(random_conv, axis = 4)

plot_image(random)


## --------------------------------------------------------------------------------------------------------------------------------------------------
predict(model, random_conv)


## --------------------------------------------------------------------------------------------------------------------------------------------------
weights <- purrr::map(1:8,
                      function(x) {plot_image(as.numeric(model$weights[[1]][,,,x]), FALSE)})
weights[['nrow']] <- 2
do.call(gridExtra::grid.arrange, weights)




