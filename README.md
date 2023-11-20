
## Workshop Hands-on Machine Learning in R, October - November 2023 edition

by Katrien Antonio, Jonas Crevecoeur and Roel Henckaerts

Course materials for the *Hands-on Machine Learning in R* course.

📆 Module 1 on October 24 & 31, Module 2 on November 7 & 14 and Module 3
on November 21 & 28, 2023 <br> 🕧 From 9.30 am to 12.30 pm <br> 📍
online, organized by Actuarieel Instituut

Course materials will be posted in the week before the workshop. You are
now on the landing page for **Module 3: neural networks**.

## Prework

The workshop requires a basic understanding of R. A good starting level
is the material covered in the
[werkt-U-al-met-R?](https://github.com/katrienantonio/werkt-U-al-met-R)
repo on Katrien’s GitHub.

Familiarity with statistical or machine learning methods is *not*
required. The workshop gradually builds up these concepts, with an
emphasis on hands-on demonstrations and exercises.

The R and RStudio software should be up and running before coming to the
workshop. Please visit the **Software requirements** posted below.

## Overview

This workshop introduces the *essential concepts of building machine
learning models with R*. Throughout the workshop you will gain insights
in the foundations of machine learning methods, including *resampling
methods*, *data preprocessing steps* and the *tuning of parameters*. You
will cover a variety of *statistical and machine learning methods*,
ranging from GLMs, over tree-based machine learning methods to neural
networks. You will acquire insights in the foundations of these methods,
learn how to set-up the model building process, and focus on building a
good understanding of the resulting model output and predictions.

Leaving this workshop, you should have a firm grasp of the working
principles of a variety of machine learning methods and be able to
explore their use in practical settings. Moreover, you should have
acquired the fundamental insights to explore some other methods on your
own.

## Schedule and Course Material

The schedule will gradually be completed over the next days. The
detailed schedule is subject to small changes.

|  Module  |  Session  | Duration                | Description                                              | Lecture material                                                                                                  | R script                                                                                                    | R solutions |
|:--------:|:---------:|-------------------------|----------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------|-------------|
| Prework  |           | your own pace           | check the Prework and Software Requirements instructions |                                                                                                                   |                                                                                                             |             |
| Prework  |           | day before the workshop | download the course material from the GitHub repo        |                                                                                                                   |                                                                                                             |             |
| Module 3 | Session 1 | 09.30 - 10.10           | Toolbox and tensors                                      | [sheets](https://katrienantonio.github.io/hands-on-machine-learning-R-module-3/sheets/ML_part3.html#start)        | [script](https://katrienantonio.github.io/hands-on-machine-learning-R-module-3/scripts/1_getting_started.R) |             |
|          |           | 10.10 - 10.30           | MNIST data                                               | [sheets](https://katrienantonio.github.io/hands-on-machine-learning-R-module-3/sheets/ML_part3.html#data-sets)    | [script](https://katrienantonio.github.io/hands-on-machine-learning-R-module-3/scripts/2_fundamentals.R)    |             |
|          |           | 10.40 - 11.10           | De-mystifying neural networks                            | [sheets](https://katrienantonio.github.io/hands-on-machine-learning-R-module-3/sheets/ML_part3.html#demystify)    | [script](https://katrienantonio.github.io/hands-on-machine-learning-R-module-3/scripts/2_fundamentals.R)    |             |
|          |           | 11.10 - 12.30           | Neural networks in {keras}                               | [sheets](https://katrienantonio.github.io/hands-on-machine-learning-R-module-3/sheets/ML_part3.html#fundamentals) | [script](https://katrienantonio.github.io/hands-on-machine-learning-R-module-3/scripts/2_fundamentals.R)    |             |
| Module 3 | Session 2 | 9.30 - 10.10            | Claim frequency with neural nets                         | [sheets](https://katrienantonio.github.io/hands-on-machine-learning-R-module-3/sheets/ML_part3.html#regression)   | [script](https://katrienantonio.github.io/hands-on-machine-learning-R-module-3/scripts/3_regression.R)      |             |
|          |           | 10.10 - 10.30           | Adding a skip connection                                 | [sheets](https://katrienantonio.github.io/hands-on-machine-learning-R-module-3/sheets/ML_part3.html#regression)   | [script](https://katrienantonio.github.io/hands-on-machine-learning-R-module-3/scripts/3_regression.R)      |             |
|          |           | 10.30 - 11.10           | CNNs                                                     | [sheets](https://katrienantonio.github.io/hands-on-machine-learning-R-module-3/sheets/ML_part3.html#cnn)          | [script](https://katrienantonio.github.io/hands-on-machine-learning-R-module-3/scripts/4_convolutional.R)   |             |
|          |           | 11.20 - 11.30           | Autoencoders                                             | [sheets](https://katrienantonio.github.io/hands-on-machine-learning-R-module-3/sheets/ML_part3.html#autoencoder)  | [script](https://katrienantonio.github.io/hands-on-machine-learning-R-module-3/scripts/5_auto_encoder.R)    |             |
|          |           | 11.30 - 12.30           | Working on case study                                    |                                                                                                                   |                                                                                                             |             |

##### Module 3: Neural networks

In two sessions we cover:

- R and Python toolbox
- tensors and operations on tensors
- basics of feed-forward artificial neural networks
- an architecture with layers in {keras}
- loss function, forward pass and backpropagation
- performance metrics
- claim frequency and severity modelling with neural networks
- auto encoders
- convolutional neural networks.

Download lecture sheets in
[pdf](https://katrienantonio.github.io/hands-on-machine-learning-R-module-3/sheets/ML_part3.pdf).

A recent working paper on the use of deep learning structures for the
analysis of claim frequency and severity data is
[https://arxiv.org/abs/2310.12671](here). The notebooks to reproduce the
illustrations in the paper are
[https://github.com/freekholvoet/NNforFreqSevPricing](here).

## Software Requirements

You have **two options** to join the coding exercises covered during the
workshop. Either you join the posit cloud workspace dedicated to the
workshop, and then you’ll run R in the cloud, from your browser. Or you
use your local installation of R, Python and RStudio.

We kindly ask participants to **join the posit cloud as default**!

### posit cloud

You will join our workspace on posit cloud. This enables a **very
accessible set-up** for working with R in the cloud for the less
experienced user!

<https://rstudio.cloud/spaces/109060/join?access_code=s3jVNlJn6J8SlZpSXmwvBsCMUC3XicxoFv5kCbCO>

Here are the steps you should take (before the workshop):

- visit the above link
- log in by creating an account for posit cloud or by using your Google
  or GitHub login credentials
- join the space
- at the top of your screen you see ‘Projects’, click ‘Projects’
- with the ‘copy’ button (on the right) you can make your own version of
  the ‘Module 3 - Neural Networks’ project (created by Roel Henckaerts);
  in this copy you can work on the exercises, add comments etc.
- you should now be able to visit the project and see the ‘scripts’ and
  ‘data’ folders on the right
- we already compiled the ‘installation-instructions.R’ script from the
  scripts folder for you; you do NOT have to run these again; instead
  open the ‘1_getting_started.R’ instructions and check if these steps
  work.

We have everything set up for you in the correct way. You only have to
login!

### Local installation

Alternatively, you can bring a laptop with a recent version of R, Python
and RStudio installed. Make sure you can connect your laptop to the
internet (or download the course material one day before the start of
the workshop). You will need:

- R, see <https://cloud.r-project.org/bin/windows/base/>
- RStudio, see
  (<https://www.rstudio.com/products/rstudio/download/#download>)

Please **run the instructions in the below script** (Part 1 and Part 2!)
to install the required packages as well as Python.

Make sure to **download the course material** (including scripts and
data sets) from the GitHub repo one day before the workshop. Use the
green button Code \> Download ZIP on the GitHub repo website. As a final
step, after downloading, unpack the ZIP folder and make sure you can
easily access the material (in particular scripts and data sets).

``` r
packages <- c("keras", "tensorflow", "reticulate", "tidyverse", "rstudioapi", "gridExtra", "rsample", "mgcv", "recipes")

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

# Download and install Python from https://www.python.org/, e.g. I have Python 3.11 (64-bit); make sure to install the 64-bit version and a version that is compatible with TensorFlow, see https://www.tensorflow.org/install
# Download Anaconda from: https://www.anaconda.com/products/individual

# Execute the following steps after installing Python
library(keras)
library(tensorflow)
library(reticulate)
path_to_python <- "C:/Users/.../AppData/Local/Programs/Python/Python311/python.exe" # replace this path with the path to your Python location
virtualenv_create("r-reticulate", python = path_to_python)
install_tensorflow(envname = "r-reticulate")
install_keras(envname = "r-reticulate")
use_virtualenv("r-reticulate")

# Alternatively, you can try the instructions posted here
# https://tensorflow.rstudio.com/install/

# Run the following set of instructions as a test
# Warning: the first time you run these instructions you may get some warnings/errors
#          then run the instructions a second time and verify if the ' ... part 2/2 completed!' message appears
if(as.array(tensorflow::tf$abs(-10)) == as.array(keras::k_abs(-10))){
  message('Installation of tensorflow and keras went well, part 2/2 completed!')
} else {
  stop('Something went wrong with installation of tensorflow and/or keras')
}
```

These instructions can also be downloaded as .R script from the
`scripts` folder. Open this script in RStudio (via File \> Open file),
select the code and press the Run button top right in the script window.

## Instructors

<img src="img/Katrien.jpg" width="110"/>

[Katrien Antonio](https://katrienantonio.github.io/) is professor in
insurance data science at KU Leuven and associate professor at
University of Amsterdam. She teaches courses on data science for
insurance, life and non-life insurance mathematics and loss models.
Research-wise Katrien puts focus on pricing, reserving and fraud
analytics, as well as mortality dynamics.

*Jonas Crevecoeur* co-designed the workshop with us, but will not teach
the October - November 2023 edition. Jonas obtained his PhD within the
insurance research group at KU Leuven and holds the degrees of MSc in
Mathematics, MSc in Insurance Studies and MSc in Financial and Actuarial
Engineering (KU Leuven). Before starting the PhD program he worked as an
intern with QBE Re (Belgium office) where he studied multiline products
and copulas. Jonas was a PhD fellow of the Research Foundation -
Flanders (FWO, PhD fellowship fundamental research).

*Roel Henckaerts* holds the degrees of MSc in Mathematical Engineering,
MSc in Insurance Studies and Financial and Actuarial Engineering (KU
Leuven) and PhD in Business Economics (KU Leuven). Before starting the
PhD program he worked as an intern with AIG (London office) and KBC.
Roel is PhD fellow of the Research Foundation - Flanders (FWO, PhD
fellowship strategic basic research). After the completion of his PhD,
Roel joined [Prophecy Labs](https://prophecylabs.com/): an AI/ML startup
with experience in building end-to-end data solutions that provide
concrete business value.

Happy learning!

------------------------------------------------------------------------
