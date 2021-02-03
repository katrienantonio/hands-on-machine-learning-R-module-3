##############################################
# Convolutional neural networks
##############################################



## --------------------------------------------------------------------------------------------------------------------------------------------------
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
setwd(dirname(rstudioapi::getActiveDocumentContext()$path)) 
load("../data/mnist.RData")
input_train <- mnist$train$x / 255
input_test <- mnist$test$x / 255


## --------------------------------------------------------------------------------------------------------------------------------------------------
library(keras)
dim(input_train)

# Expand dimension to fourth axis. Choose one of the statements below:
# 1) Keras on your local machine
input_train <- k_expand_dims(input_train)
# 2) Keras on the cloud
dim(input_train) <- c(dim(input_train), 1)

dim(input_train) # should return: 60000    28    28     1


## --------------------------------------------------------------------------------------------------------------------------------------------------
# 1) Keras on your local machine
input_test <- k_expand_dims(input_test)
# 2) Keras on the cloud
dim(input_test) <- c(dim(input_test), 1)

dim(input_test) # should return: 10000    28    28     1


## --------------------------------------------------------------------------------------------------------------------------------------------------
output_train <- keras::to_categorical(mnist$train$y, 10)
output_test <- keras::to_categorical(mnist$test$y, 10)


## --------------------------------------------------------------------------------------------------------------------------------------------------
model <- keras_model_sequential() %>%
  layer_conv_2d(filters = 8, 
                kernel_size = 3, 
                input_shape = c(28, 28, 1)) %>%
  layer_max_pooling_2d(pool_size = 2,
                       strides = 2) %>%
  layer_flatten() %>%
  layer_dense(units = 10, 
              activation = 'softmax') %>%
  compile(loss = 'categorical_crossentropy',
          optimize = optimizer_rmsprop(),
          metrics = c('accuracy')) 

summary(model)



## --------------------------------------------------------------------------------------------------------------------------------------------------
model %>% fit(x = input_train,
              y = output_train, 
              epochs = 10, 
              batch_size = 128, 
              validation_split = 0.2)


## --------------------------------------------------------------------------------------------------------------------------------------------------
model %>% evaluate(input_test,
                   output_test)


## --------------------------------------------------------------------------------------------------------------------------------------------------
prediction <- model %>% predict(input_test)
category <- apply(prediction, 1, which.max) - 1
actual_category <- apply(output_test, 1, which.max) - 1
head(which(actual_category != category))


## --------------------------------------------------------------------------------------------------------------------------------------------------
cbind(category, actual_category)[93,]

# 1) Keras on your local machine
plot_image(as.vector(t(as.array(input_test[93, , ,])[,,1])))
# 2) Keras on the cloud
plot_image(as.vector(t(as.array(input_test[93, , ,]))))


## --------------------------------------------------------------------------------------------------------------------------------------------------
filters <- model$get_weights()[[1]]
str(filters)


## --------------------------------------------------------------------------------------------------------------------------------------------------
maps <- purrr::map(1:8, function(x) {plot_image(as.numeric(filters[,,,x]), FALSE)})
maps[['nrow']] <- 2
do.call(gridExtra::grid.arrange, maps)



## Your Turn!
## --------------------------------------------------------------------------------------------------------------------------------------------------










