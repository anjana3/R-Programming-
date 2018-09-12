library(randomForest)
bc=read.csv("/home/anjana/anjana/csv/breast-cancer-wisconsin.csv")
head(bc)
fstr(bc)
is.na.data.frame(bc)
table(bc$CancerType)/nrow(bc)
mm=cor(bc)
round(mm)
corrplot(mm, method = "number")
library(rpart.plot)
library(caret)
library(ggplot2)
library(corrplot)
library(xlsx)



#http://dni-institute.in/blogs/random-forest-using-r-step-by-step-tutorial/

