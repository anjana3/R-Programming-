churn_data_tbl=read.csv("/home/anjana/anjana/csv/Churn.csv")
library(keras)
library(tensorflow)
glimpse(churn)
library(rsample)
set.seed(100)
train_test_split <- initial_split(churn_data_tbl, prop = 0.8)
train_test_split



output$pred_values<-renderTable(
  if(input$disp == "head") {
    head(as.data.frame(test_predictions))
  }
  else {
    as.data.frame(test_predictions) 
  })