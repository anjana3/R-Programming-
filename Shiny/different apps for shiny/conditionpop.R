rm(list = ls())
library(shiny)
library(shinyBS)

name <- "myname"

ui = fluidPage(
  uiOutput("curName"),
  br(),
  actionButton("BUTnew", "Change"),
  bsModal("modalnew", "Change name", "BUTnew", size = "small",
          textOutput("textnew"),
          radioButtons("change_name", "", choices = list("Yes" = 1, "No" = 2, "I dont know" = 3),selected = 2),
          conditionalPanel(condition = "input.change_name == '1'",textInput("new_name", "Enter New Name:", ""))    
  )
)


server = function(input, output, session) {
  
  output$curName <- renderUI({textInput("my_name", "Current name: ", name)})
  
  observeEvent(input$BUTnew, {
    output$textnew <- renderText({paste0("Do you want to change the name?")})
  })
  
  observe({
    input$BUTnew
    if(input$change_name == '1'){
      if(input$new_name != ""){
        output$curName <- renderUI({textInput("my_name", "Current name: ", input$new_name)})
      }
      else{
        output$curName <- renderUI({textInput("my_name", "Current name: ", name)})
      }
    }
  })
}

runApp(list(ui = ui, server = server))
