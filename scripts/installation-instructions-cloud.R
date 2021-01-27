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


# Part 2: install keras
keras::install_keras(tensorflow = '1.13.1') # say Y to miniconda
