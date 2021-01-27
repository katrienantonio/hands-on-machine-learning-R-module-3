packages <- c("keras", "tensorflow", "tidyverse", "rstudioapi", "gridExtra", "rsample", "mgcv", "recipes")

# Part 1: install all the needed R packages
new_packages <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new_packages)) install.packages(new_packages)

if(sum(!(packages %in% installed.packages()[, "Package"]))) {
  stop(paste('The following required packages are not installed:\n', 
             paste(packages[which(!(packages %in% installed.packages()[, "Package"]))], collapse = ', ')));
} else {
  message("All R packages are installed, part 1/2 completed!")
}


# Part 2: install tensorflow and keras

# Download Anaconda from: https://www.anaconda.com/products/individual

# Perform installation AFTER downloading Anaconda
tensorflow::install_tensorflow(method = 'conda')
keras::install_keras(method = 'conda')

# Run the following set of instructions as a test
# Warning: the first time you run these instructions you may get some warnings/errors
#          then run the instructions a second time and verify if the ' ... part 2/2 completed!' message appears
if(as.array(tensorflow::tf$abs(-10)) == as.array(keras::k_abs(-10))){
  message('Installation of tensorflow and keras went well, part 2/2 completed!')
} else {
  stop('Something went wrong with installation of tensorflow and/or keras')
}



