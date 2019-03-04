#it has basic functionalities of the rat tool i need to implement this with out ui components
require(RPostgreSQL)
library(shiny)
library(shinydashboard)
example<-readxl::read_xlsx("C:/Users/FL_LPT-195/Desktop/example.xlsx")

ui<-fluidPage(
  dashboardPage(
    dashboardHeader(title="Janssen",tags$li(actionLink("openModal", label = "", icon = icon("bell"),width=1500),class = "dropdown"),
                    tags$li(actionLink("openModal", label = "Johnny Doe", icon = icon("user-circle")),class = "dropdown",width=2000)),
    dashboardSidebar(
      sidebarMenu(
        menuItem("Home",icon = icon("home"),tabName = "home"),
        menuItem("Import Data",icon = icon("file-import"),tabName = "import"),
        menuItem("Trails",icon = icon("dashboard"),tabName = "trails",
                 menuSubItem("RESOURCE ASSIGNED",tabName = "resourceass"),
                 menuSubItem("ASSIGNED NEEDED",tabName = "assigned")),
        menuItem("Projects",icon = icon("dashboard")),
        menuItem("Resources",icon = icon("user")),
        menuItem("Reports",icon = icon("chart-bar"))
      )
    ),
    dashboardBody(
      tags$head(tags$style(HTML('
            /* logo */
                                .skin-blue .main-header .logo {
                                background-color: blue-light;
                                }
                                       /* main sidebar */
                                .skin-blue .main-sidebar {
                                height: 762px;
                                box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.16);
                                background-color: blue-light;
                                
                                }
                                       /* main sidebar */
                                .skin-blue .content-wrapper {
                                  background-color: #ffffff;
                                }                 
        
      '))),
      
      tabItems(tabItem(tabName = "resourceass",
                       fluidRow(
                       box(title = h4("Resource Assigned",style = "font-size:25px"),width = 4,height = 70),
                       box(title = h4("Select Project :",style = "font-size:25px"),width = 2,height = 70),
                       box(width =2,height = 70 ,selectInput("project_name",label = "Project Name",choices = factor(example$Projectname),selected = "factor(example$Projectname")),
                       box(width = 2,height = 70,selectInput("date_range",label = "Date Range",c("Jan-Dec","2")))),
                       fluidRow(box(title = h4("Project Info",style = "font-size:25px"),width = 10,height = 200,column(4,
                                                                                 p(h4("PFI: 07/28/2017",style = "font-size:15px"))),
                                    column(4,p(h4("DEL: 07/13/2022",style = "font-size:15px"))),
                                    column(4,p(h4("Comment:",style = "font-size:15px"))),
                                    column(5,p(h4("DD Executed by:LD",style = "font-size:15px"))),
                                    column(5,p(h4("TA:Cardiovascular and Metabolism",style = "font-size:15px"))),
                                    column(6,p(h4("IDBL:",style = "font-size:15px"))),
                                    column(6,p(h4("DELEXT:",style = "font-size:15px")))
                                    )),
                       
                       fluidRow(box(width = 10,column(4, p(h4("Data Section",style = "font-size:25px"))),column(4,
                                                                                                                selectInput("select_role",label = "Select Role",choices = factor(example$Role))),tableOutput("data_sec"))),
                       fluidRow(box(title = h4("Modify Resource Section",style = "font-size:25px"),width = 10))),
               tabItem(tabName = "import",
                       fluidRow(
                             box(width=10,title = "File Upload",tags$hr(),column(4,
                                  selectInput("select_input",label = h4("1.Select File Type"),c("1-Supply","V6-Demand"))),
                                 column(4,fileInput("file", h4("2.Choose CSV File",style = "font-size:15px"),
                                                    multiple = TRUE,
                                                    accept = c("text/csv/xlsx",
                                                               "text/comma-separated-values,text/plain",
                                                               ".csv",".xlsx"))),
                                 column(4,actionButton("save",label = h4("3.Save to Database",style = "font-size:15px"),style="color: #fff; background-color: green;border-color: #2e6da4"))
                                 )
                       ),DT::dataTableOutput("table")),
               tabItem(tabName = "home",
                       fluidRow(
                         box(title = h4("Trail Graph"),width = 4,height = 70),
                         box(title = h4("Project Graph"),width = 4,height = 70)
                       ))
               
                       )
        
            
    )
  )
)


server = function(input, output) {
  table_data <- reactive ({
    req(input$file)
    dfd<-readxl::read_xlsx(input$file$datapath)
    
  })

  output$data_sec<-renderTable({
    example[3:16]
  })

output$table<-DT::renderDataTable(
    
    table_data(),
    options = list(scrollX = TRUE)
  )
  observe({
    observeEvent(input$save,{
      conn <- dbConnect(RPostgres::Postgres(), dbname="first", host="localhost", port=5432, user="postgres", password="lemon")
      dbWriteTable(conn, name='New_Dataset',value=table_data(),overwrite = TRUE )
      
      
    })
  })
  }
shinyApp(ui=ui,server = server)






