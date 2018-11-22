library(shiny)
library(DT)

ui =basicPage(
tags$head(
tags$style(type = "text/css",
           HTML("th { text-align: center; }"))),

selectInput(inputId = "Species", 
          label = "Species:",
          choices = c("All",
                      unique(as.character(iris$Species)))),

checkboxGroupInput(inputId = "columns", label = "Select Variable:",
                        choices =c("All",names(iris)),selected = "All"),

h2('Iris Table'),
DT::dataTableOutput('mytable'))

server = function(input, output) {
output$mytable = DT::renderDataTable({

  # a custom table container
  sketch = htmltools::withTags(table(
    class = 'display',
    thead(
      tr(
        th(rowspan = 2, 'Species'),
        th(colspan = 2, 'Sepal'),
        th(colspan = 2, 'Petal')
      ),
      tr(
        lapply(rep(c('Length', 'Width'), 2), th))) ))

  DT::datatable(filter = "top", container = sketch, rownames = FALSE, 
extensions = 'Buttons', options = list(dom = 'Bfrtip', buttons =  c('copy', 
'csv', 'excel', 'pdf', 'print')),
                      {   
                   data<-iris[,c(5,1:4)]

                   if(input$Species != 'All'){
                     data<-data[data$Species == input$Species,]
                   }

                   if(input$Species[1]=="setosa"){
                     data<-data[data$species==input$species,]
                   }

                   if(input$columns=='All'){
                     data
                   }
                   else{
                     data[,c(input$columns),drop=FALSE]
                   }

                   data

                 })})}

shinyApp(ui = ui, server = server)
