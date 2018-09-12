library(magrittr)  # to use piping %>%
library(ggplot2)   # for ploting
library(MASS)      # to calculate the pseudo-inverse of a matrix
library(caret)     # to center our data by subtracting its mean
library(reshape2)  # for data manipulation
load("data1.RData")
#All the variables below are matrices

X=data1$X
Xval=data1$Xval   # This is cross-validation data
yval =data1$yval  # This shows which rows in Xval are anomalous
table(yval)
table(Xval)
X=as.data.frame(X)
names(X)=c("Latency (ms)", "Throughput (mb/s)")
XX=melt(X)
XX%>%ggplot(aes(x=value,fill=variable, color=variable))+
geom_density(alpha = 0.3)+ggtitle('Distibution of X')
#As we can see, normal distribution is a good approximation for our dataset and hence we do not need to perform any transformations.

#Next, let's see the distribution of the cross-validation data (Xval).
Xval=as.data.frame(Xval)
names(Xval)=c("Latency (ms)", "Throughput (mb/s)")
XXval = melt(Xval)

XXval%>%ggplot(aes(x=value,fill=variable, color=variable))+
geom_density(alpha = 0.3)+ggtitle('Distibution of Xval')
#The variables in Xval are also close to gaussian distribution. So, we do not need any transformation.

#Now, let's create a 2D plot and see the distribution of Latency and Throughput.

X%>%ggplot(aes(x=`Latency (ms)`,y=`Throughput (mb/s)`))+
  geom_point(color='blue')

