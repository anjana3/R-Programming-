library(shiny)
library(shinyalert)

ui <- fluidPage(
  useShinyalert(),  # Set up shinyalert
  actionButton("preview", "Preview")
)

server <- function(input, output, session) {
  observeEvent(input$preview, {
    # Show a modal when the button is pressed
    shinyalert("Oops!", "Something went wrong.", type = "error")
  })
}

shinyApp(ui, server)
