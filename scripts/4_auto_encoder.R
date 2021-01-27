##############################################
# Auto encoder
##############################################



## --------------------------------------------------------------------------------------------------------------------------------------------------
setwd(dirname(rstudioapi::getActiveDocumentContext()$path)) 
load('../data/mnist.RData')

input <- mnist$train$x
test_input <- mnist$test$x

input <- tensorflow::array_reshape(input,
                                   c(nrow(input), 28*28)) / 255
test_input <- tensorflow::array_reshape(test_input,
                                        c(nrow(test_input), 28*28)) / 255

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


## Your Turn!
## --------------------------------------------------------------------------------------------------------------------------------------------------
library(keras)
encoder <- keras_model_sequential() %>%
  layer_dense(units = 128, 
              activation = ..., 
              input_shape = c(784)) %>%
  layer_dense(units = 32,
              activation = ...)

model <- encoder %>%
  layer_batch_normalization() %>%
  layer_dense(units = 128,
              activation = ...) %>%
  layer_dense(units = 784,
              activation = ...) %>%
  compile(loss = ...,
          optimize = ...,
          metrics = ...)

model %>% fit(..., 
              ..., 
              epochs = 10, 
              batch_size = ..., 
              shuffle = TRUE, 
              validation_split = ...)


## --------------------------------------------------------------------------------------------------------------------------------------------------
result <- predict(model, input[1, , drop = FALSE])
plot_image(input[1, ]) # the original image
plot_image(result[1, ]) # the reconstruction of the model


## --------------------------------------------------------------------------------------------------------------------------------------------------
random <- matrix(runif(28^2), nrow = 1)

gridExtra::grid.arrange(
  plot_image(random[1, ]) + theme(legend.position = 'none'),
  plot_image(predict(model, random)[1, ]) + theme(legend.position = 'none'),
  nrow = 1)

