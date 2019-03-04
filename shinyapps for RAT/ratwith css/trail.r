#the app.r has changed with the name of trail.r to give the css to the shiny application
library(shiny)
library(shinydashboard)
ui <- fluidPage(
  includeCSS("D:/FL/R/trail_resource/www/main.css"),
  
  dashboardPage(
    dashboardHeader(title = "Jansson"),
    dashboardSidebar(
      menuItem(h4("Trails", class="Trials"),icon = icon("dashboard"),tabName = "trails",
               menuSubItem("RESOURCE ASSIGNED",tabName = "resourceass"),
               menuSubItem("ASSIGNED NEEDED",tabName = "assigned")),
      menuItem(h4("Dashboard",class="db"),tabName = "dashb")
      
    ),
    dashboardBody(
                  
                  
                    tabItems(tabItem(tabName = "resourceass",
                                     fluidRow(box(title = "Resource Assigned"),
                                              box(title = "Project Name",selectInput("project_name",label = "Project Name",choices = c("project_A","project_B"),selected = "project_A"))),
                                     fluidRow(box(title = "Project Info")),
                                     fluidRow(box(title = "Data Section")),
                                     fluidRow(box(title = "Modify Resource Section"))
                                       
                                     ))
                     
                )
  )
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)
