
######################################################################
# source => 
# https://r4ds.had.co.nz/introduction.html
# Hadley Wickham R for Data Science
# https://statsandr.com/blog/descriptive-statistics-in-r/
# https://statsandr.com/blog/data-types-in-r/
#
# Author: George Campanis
# Date: 15-Nov-2023
# Purpose: Teaching Summary Stats to DA Group 
###################################################################


#*----------------------------------------------------------------
# Notes: 
# Execute script block -      then Ctrl + Enter
# ctrl l clears screen
# ctrl shift C will comment all selected code
#-----------------------------------------------------------------


install.packages("tidyverse")
install.packages("pastecs")# more stats


library(tidyverse)

# install some data packages 
install.packages(c("nycflights13", "gapminder", "Lahman")) # used 

#--------------------
# coding basics
#--------------------
# Math
1 / 200 * 30
(59 + 73 + 2) / 3
sin(pi / 2)

# var assignment
x <- 3 * 4
x = 3 * 4

# display var
x

# calling functions
# e.g seq()  makes regular sequences of number
seq(1, 10)

# enclose in parentheses to display automatically after assignment
(y <- seq(1, 10, length.out = 5))

?seq()
?sd()

# press  Alt + Shift + K and see what happens

library(nycflights13)
library(tidyverse)

?dplyr::filter() 
?stats::filter()

?filter() 





# show flights data
flights # data type is a tibble ---more on this later

# view flights and Iris dataset in RStudio Viewer
View(flights)
View(iris)

# R var types
#  int stands for integers.
#  dbl stands for doubles, or real numbers.
#  chr stands for character vectors, or strings.
#  dttm stands for date-times (a date + a time).
#  lgl stands for logical, vectors that contain only TRUE or FALSE.
#  fctr stands for factors, which R uses to represent categorical variables with fixed possible values.
#  date stands for dates.




# https://statsandr.com/blog/data-types-in-r/
# c is used in R to concatenate 
num_data <- c(3, 7, 2)# numeric series without decimals
# Combine Values Into A Vector Or List
# Try run it....https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/c


class(num_data) # identifies class of data

typeof(num_data) # to get data type

num_data_dec <- c(3.4, 7.1, 2.9)
class(num_data_dec)
# also possible to check the class thanks to str()
str(num_data_dec)

int_nums = as.integer(num_data_dec)# convert data types

###################################
# Chars
#################################
char <- "some text" # strings
char
class(char)

numAsChar= as.character(int_nums)

# case and space sensitivity 
char_space <- "text "
char_nospace <- "text"
# is char_space equal to char_nospace?
char_space == char_nospace


char_space <- "Text"
char_nospace <- "text"
# is char_space equal to char_nospace?
char_space == char_nospace


##############################################
# Factors
# factors are categorical
#############################################
gender <- factor(c("female", "female", "male", "female", "male"))
gender

levels(gender)


fruit = factor(c("apple", "pear", "banana", "apple", "grape"))
levels(fruit)

#By default, the levels are sorted alphabetically
text <- c("test1", "test2", "test1", "test1") # create a character vector
class(text) # to know the class

text_factor <- as.factor(text) # transform to factor
class(text_factor) # recheck the class

##############################################
# Logical
# are boolean true or false
#############################################
value1 <- 7
value2 <- 9

# is value1 greater than value2?
(greater <- value1 > value2)

class(greater)

# is value1 less than or equal to value2?
less <- value1 <= value2
less


greater_num <- as.numeric(greater)# FALSE values equal to 0 and TRUE values equal to 1:
greater_num

# also we can take an int and get a logical
x <- 0
typeof(x)
as.logical(x)

##############################################
#  Vectors, Lists, Matrix, Array, DataTable
# https://resbaz.github.io/2014-r-materials/lessons/01-intro_r/data-structures.html
##############################################
typeof() # what is it?
class() # what is it? 
length() # how long is it? What about two dimensional objects?
attributes() # does it have any metadata?

##############################################
#  Vectors
##############################################

# A vector is the most common and basic data structure in R and is pretty much the workhorse of R. Vectors can be of two types:
# 1. atomic vectors
# 2. lists

# Atomic Vectors A vector can be a vector of characters, logical, integers or numeric.
x <- c(1, 2, 3)
(2 * x)

typeof(x)
length(x)
class(x)
str(x)

# add elements
z <- c(x, 4)

#Vectors may only have one type
xx <- c(1.7, "a")

#list vs vector
(av= vector(1,2,TRUE))
(al=list(1,2,TRUE))
#We can use unlist() to convert the list into a vector.
(alf=list("apples","pears","strawberry"))

# check if it is a vector
is.atomic(alf)

# check if it is a list
is.list(al)

##############################################
#  Matrices (A Matrix)
#  Matrices are a special vector in R. They are not a separate class of object but simply a vector but now with dimensions added on to it. Matrices have rows and columns.
##############################################

(m <- matrix(nrow = 2, ncol = 2))
dim(m)
same as
attributes(m)

# Matrices are constructed columnwise
(m <- matrix(1:6, nrow=2, ncol =3))

# other ways to construct matrix
m <- 1:10
dim(m) <- c(2,5)


# combinning rows and/or cols
x <- 1:3
y <- 10:12
cbind(x,y)
# or
rbind(x,y)


############################################
# apply(), lapply(), sapply(), tapply()
# https://www.guru99.com/r-apply-sapply-tapply.html





# apply(X, MARGIN, FUN)
# Here:
#  -x: an array or matrix
#  -MARGIN:  take a value or range between 1 and 2 to define where to apply the function:
#  -MARGIN=1`: the manipulation is performed on rows
#  -MARGIN=2`: the manipulation is performed on columns
#  -MARGIN=c(1,2)` the manipulation is performed on rows and columns
#  -FUN: tells which function to apply. Built functions like mean, median, sum, min, max and even user-defined functions can be applied>

m1 <- matrix(C<-(1:10),nrow=5, ncol=6)
m1
a_m1 <- apply(m1, 2, sum)
a_m1

######################################
# List Apply
#####################################
#   lapply(X, FUN)
#   Arguments:
#   -X: A vector or an object
#   -FUN: Function applied to each element of x

movies <- c("SPYDERMAN","BATMAN","VERTIGO","CHINATOWN")
movies_lower <-lapply(movies, tolower)
str(movies_lower)

######################################
# S Apply
#####################################
# same job as lapply() function but returns a vector.
#   sapply(X, FUN)
#   Arguments:
#   -X: A vector or an object
#   -FUN: Function applied to each element of x

# We can measure the minimum speed and stopping distances of cars from the cars dataset.
dt <- cars
lmn_cars <- lapply(dt, min)
smn_cars <- sapply(dt, min)
lmn_cars


smn_cars

######################################
# T Apply
#####################################
# tapply() computes a measure (mean, median, min, max, etc..) or a function for each factor variable in a vector.

# tapply(X, INDEX, FUN = NULL)
# Arguments:
# -X: An object, usually a vector
# -INDEX: A list containing factor
# -FUN: Function applied to each element of x

data(iris)
tapply(iris$Sepal.Width, iris$Species, median)

# => https://statsandr.com/blog/descriptive-statistics-in-r/
# stats summary 

dat <- iris # load the iris dataset and renamed it dat

View(iris)

head(dat,25) # first 6 observations
str(dat) # structure of dataset

levels(iris$Species) # note $ refers to col


#############
# min, max
#############
min(dat$Sepal.Length)
max(dat$Sepal.Length)

#############
# RANGE
#############
range(dat$Sepal.Length)

# note: we can get array num starting  @ 1,2,...n
arr=range(dat$Sepal.Length)
arr[1]
# or like this
range(dat$Sepal.Length)[2]


# The range is the difference between the maximum and the minimum value
rng= max(dat$Sepal.Length) - min(dat$Sepal.Length)
rng

# create a func
fnRange = function(x) {
  range <- max(x) - min(x)
  return(range)
}

fnRange(dat$Sepal.Length)
fnRange(dat$Petal.Length)

##################################
#  Standard deviation and variance
##################################
sd(dat$Sepal.Length) # standard deviation
var(dat$Sepal.Length) # variance

variance= (sd(dat$Sepal.Length))^2
stdDev = sqrt(variance)
# computed using sample formulae i.e. n-1

o=lapply(dat[, 1:4], sd)
o[4]

head(dat)
summary(dat)
