
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(shinyjs)
library(rAmCharts)
library(ggplot2)
#library(xlsx)
library(magrittr)
# library(DT)
library(RPostgreSQL)
library(rjson)
library(pool)
data("data_gbar")


data_gbar['income'] <- c(32,25,20,18,15)
data_gbar['expenses'] <- c(20,15,12,12,12)
Data <- data_gbar
names(Data)<- c("Trial", "Day", "Month", "Need", "Allocated")
Tr <- c("0078589", "0077896", "0075369", "00712596", "00786532")
Data['Trial'] <- Tr

header <- dashboardHeader(title = "RAT Tool", tags$li(img(src = "Images/Logo.png", height= "50px"), class="dropdown"))

sidebar <- dashboardSidebar(
    sidebarMenu(
        menuItem("Dashboard", tabName = "Dashboard", icon = icon('dashboard')),
        menuItem("Import Data", tabName = 'File_Upload', icon=icon('file-upload')),
        menuItem("Trial", tabName = "Trial_Section", icon= icon('broom'),
            menuItem("Resource Need", tabName = "Resource_Need", icon= NULL),
            menuItem("Resource Assigned", tabName = "Resource_Assigned", icon= NULL)),
        menuItem("Project", tabName = "Project", icon = icon('tasks', lib='glyphicon'),
            menuItem("Manage Project", tabName = "Manage_Project", icon= NULL),
            menuItem("Resource Assigned", tabName = "Proj_Resource_Assigned", icon= NULL)),
        menuItem("Resource", tabName = "Resources", icon= icon('file-alt'),
            menuItem("Resource", tabName = "Resource", icon= NULL),
            menuItem("Assignment Per Resource", tabName = "Assign_per_resource", icon= NULL)),
        menuItem("Reports", tabName = "Reports", icon = icon('file-alt'))
        # menuItem("Account Settings", tabName = "Account_Settings", icon = icon('wrench'))
    )
    
)

body   <- dashboardBody(
        useShinyjs(), 
        tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "css/style.css"),
            tags$link(rel = "stylesheet", type = "text/css", href = "https://cdn.datatables.net/1.10.19/css/dataTables.material.min.css")
            # tags$script(src='js/function.js')
            ),
        tabItems(
            source(file.path("UI", "Dashboard.r"), local = TRUE)$value,
            source(file.path("UI", "ImportData.r"), local = TRUE)$value,
            source(file.path("UI", "Trial_Resource_Need.r"), local = TRUE)$value,
            source(file.path("UI", "Resource_Assigned.r"), local = TRUE)$value
            # source(file.path("UI", "Resources.r"), local = TRUE)$value,
            # source(file.path("UI", "Reports.r"), local = TRUE)$value
        )
)

ui <- dashboardPage(
    header,
    sidebar,
    body
)

server <- function(input, output, session){
    source(file.path("Server", "Dashboard.r"), local = TRUE)$value
    source(file.path("Server", "ImportData.r"), local = TRUE)$value
    source(file.path("Server", "Trial_Resource_Need.r"), local = TRUE)$value
    source(file.path("Server", "Trial_Resource_Assigned.r"), local = TRUE)$value
     

}

shinyApp(ui = ui, server)
