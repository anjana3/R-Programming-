#importing the dataset
dataset=read.csv("/home/anjana/anjana/PYTHON/tensor/boston.csv")

#dataset=read.csv("/home/anjana/Downloads/retinopathy.csv")
#test_demo=read.csv("/home/anjana/Desktop/test_demo.csv")
head(dataset)
is.na(dataset)
library(caret)
library(rpart.plot)
intrain=createDataPartition(y=dataset$MV,p=0.7,list=FALSE)
training=dataset[intrain,]
testing=dataset[-intrain,]
ml_rpart<-rpart(training$MV~.,method='class',data=training,control=rpart.control(minsplit=8,cp=0))
model_pred<-predict(ml_rpart, testing, type="class")
prp(ml_rpart,box.palette = "green",tweak = 0.99,cex=.7, main="Eye cancer early risk diagnosis")
#predict the targetvariable
confusionMatrix(model_pred, testing$MV )
x_test<-testing[,1:10]
y_test<-testing[,11]
predictions<-predict(ml_rpart,x_test)
corrplot(head(predictions))
dataset1=read.csv("/home/anjana/anjana/PYTHON/tensor/boston.csv")
intrain=createDataPartition(y=dataset$risk,p=0.7,list=FALSE)
x<-c(train_data,train_labels)
