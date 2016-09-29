# I used these codes for R programming week 3 quiz! 
#This quis requires us to load the library(datasets)
# and type data(iris)

#question 1 asked us to compute the mean of sepal.length for the virginica
#species. Investigating the lapply and split functions, I wrote the following 
#line, which computes the means of all four variables across all three 
#species

lapply(X=split(iris,iris$Species), FUN=function(x){colMeans(x[,1:4])})

