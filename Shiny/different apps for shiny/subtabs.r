library(shiny)
ui<-navbarPage("RAT_POC",
               tabPanel("DATABASE"),
               navbarMenu(h4("RAT"),
                          tabPanel(h4("Import1-Supply")),
                          tabPanel(h4("Import data from V6"))),
               navbarMenu(h4("TRAIL"),
                          tabPanel(h4("Resource Need")),
                          tabPanel(h4("Resources Assigned"))),
               navbarMenu(h4("PROJECT"),
                          tabPanel(h4("Maintain Project")),
                          tabPanel(h4("Resources Assigened"))),
               navbarMenu(h4("RESOURCE"),
                          tabPanel(h4("Resource")),
                                   tabPanel(h4("Assignments Per Resource"))))
               
server <- function(input, output) {
  
}
shinyApp(ui=ui,server=server)
