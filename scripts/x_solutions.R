##############################################
# Getting started
##############################################

library(keras)
x <- k_constant(1:8, shape = c(2,2, 2))
k_log(x)
k_mean(x, axis = 3)

library(tensorflow)
tf$`function`(k_log)(x)
tf$`function`(log)(x)


##############################################
# Auto encoder
##############################################

library(keras)
encoder <- keras_model_sequential() %>%
  layer_dense(units = 128, activation = 'sigmoid', 
              input_shape = c(784)) %>%
  layer_dense(units = 32, activation = 'sigmoid')
model <- encoder %>%
  layer_batch_normalization() %>%
  layer_dense(units = 128, activation = 'sigmoid') %>%
  layer_dense(units = 784, activation = 'sigmoid') %>%
  compile(loss = 'binary_crossentropy',
          optimize = optimizer_rmsprop(),
          metrics = c('mse'))

model %>% fit(input, 
              input, 
              epochs = 10, 
              batch_size = 256, 
              shuffle = TRUE, 
              validation_split = 0.2)



##############################################
# Convolutional NNs
##############################################


model <- keras_model_sequential() %>%
  layer_conv_2d(filters = 8, 
                kernel_size = 3, 
                input_shape = c(28, 28, 1)) %>%
  layer_max_pooling_2d(pool_size = 2) %>%
  layer_flatten() %>%
  layer_dense(units = 10, 
              activation = 'softmax') %>%
  compile(loss = 'categorical_crossentropy',
          optimize = optimizer_rmsprop(),
          metrics = c('accuracy')) 

model %>% fit(input_conv, output, 
              epochs = 10, 
              batch_size = 128, 
              validation_split = 0.2)

model %>%  evaluate(test_input_conv, 
                    test_output, verbose = 0)



##############################################
# Regression NNs
##############################################

nn_binary <- 
  keras_model_sequential() %>%
  layer_dense(units = 1, 
              activation = 'sigmoid', 
              input_shape = c(1), 
              use_bias = FALSE) %>%
  compile(loss = 'binary_crossentropy',
          optimize = optimizer_rmsprop(),
          metrics = c('accuracy'))

nn_binary %>% fit(x = intercept,
                  y = counts > 0,
                  epochs = 30,
                  batch_size = 1024,
                  validation_split = 0)

#nn_binary <- keras::load_model_tf('nn_binary')

glm_binary <- glm((nclaims > 0) ~ 1, 
                  data = mtpl_train, 
                  family = binomial(link = 'logit'))

glm_binary$coefficients
nn_binary$get_weights()[[1]] %>% as.numeric()

unique(predict(glm_binary, type = 'response'))
unique(predict(nn_binary, x = intercept))



##############################################
# Case study
##############################################


library(recipes)

# Create and prepare the recipe
mtpl_recipe <- recipe(nclaims ~ ., data = mtpl_train) %>%
  step_rm(id, amount, avg, town, pc) %>%
  step_nzv(all_predictors(), -expo) %>%
  step_normalize(all_numeric(), -c(nclaims, expo)) %>%
  step_dummy(all_nominal(), one_hot = TRUE) %>%
  prep(mtpl_train)

# Bake the training and test data
mtpl_train_b <- mtpl_recipe %>% juice()
mtpl_test_b <- mtpl_recipe %>% bake(new_data = mtpl_test)

# Make the data NN proof
train_x <- mtpl_train_b %>% 
  dplyr::select(-c(nclaims, expo)) %>% as.matrix()
test_x <- mtpl_test_b %>% 
  dplyr::select(-c(nclaims, expo)) %>% as.matrix()

train_y <- mtpl_train_b$nclaims
test_y <- mtpl_test_b$nclaims

train_expo <- mtpl_train_b$expo
test_expo <- mtpl_test_b$expo



nn_case <- keras_model_sequential() %>%
  layer_dense(units = 20,
              activation = 'relu',
              input_shape = ncol(train_x)) %>%
  layer_dense(units = 10,
              activation = 'relu') %>%
  layer_dense(units = 1,
              activation = 'exponential') %>%
  compile(loss = 'poisson',
          optimize = optimizer_nadam())

nn_case %>%
  fit(x = train_x,
      y = train_y / train_expo,
      sample_weight = train_expo,
      epochs = 20,
      batch_size = 1024,
      validation_split = 0)




nn_case %>%
  evaluate(x = test_x,
           y = test_y)

# If you want to check the results
poisson_loss <- function(pred, actual) {
  mean(pred - actual * log(pred))
}
poisson_loss(predict(nn_case, test_x),
             test_y)

# Use as.matrix when using weights in evaluate
nn_case %>% 
  evaluate(x = test_x,
           y = test_y,
           sample_weight = array(test_expo))



gam_case <- gam(
  nclaims ~ coverage + fuel + sex +
    s(ageph) + s(bm) + s(power) + s(agec),
  data = mtpl_train,
  offset = log(expo),
  family = poisson(link = 'log')
)

poisson_loss(predict(gam_case, mtpl_test,
                     type = 'response'),
             test_y)

