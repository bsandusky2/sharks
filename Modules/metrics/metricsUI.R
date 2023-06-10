#create metrics UI
metric_ui <- function(id) {
  
  frow1<- fluidRow(
    shinydashboard::valueBoxOutput(NS(id, "avgPrice")),
    shinydashboard::valueBoxOutput(NS(id, "predDiamondPrice"))
  )
  
  frow2<- fluidRow(
    box(
      plotlyOutput(NS(id, "plot"))
    ),
    box(
      plotlyOutput(NS(id, "barPlot"))
    )
  )

  frow3<- fluidRow(
    box(
      title = "Chart Filters",
      background = "aqua",
    column(2, selectInput(NS(id, "clarity"), "Clarity", choices = unique(diamonds$clarity), selected = "I1", multiple = T)),
    column(2,selectInput(NS(id, "cut"), "Cut", choices = unique(diamonds$cut), selected = "Fair", multiple = T)),
    column(2,selectInput(NS(id, "color"), "Color", choices = unique(diamonds$color), selected = "J", multiple = T)),
    column(2,sliderInput(NS(id, "carat"), "Carat", value = c(1,4), min = 0,max = 6, step = .01))
    ),
    box(
      title = "Prediction Paramters",
      background = "purple",
      column(3, selectInput(NS(id, "clarityPred"), "Clarity", choices = unique(diamonds$clarity), selected = "I1", multiple = F)),
      column(3, selectInput(NS(id, "cutPred"), "Cut", choices = unique(diamonds$cut), selected = "Fair", multiple = F)),
      column(3, selectInput(NS(id, "colorPred"), "Color", choices = unique(diamonds$color), selected = "J", multiple = F)),
      column(3,numericInput(NS(id, "caratPred"), "Carat", value = 1, min = 0,max = 6, step = .1))
    ),
    column(10,frow2)
  )
  
  #fluidPage(
  dashboardPage(
    dashboardHeader(title = "Diamond Pricing"),
    dashboardSidebar(
      sidebarMenu(
        # Setting id makes input$tabs give the tabName of currently-selected tab
        id = "tabs",
        menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard"))
    )),
    dashboardBody(
      frow1, frow3
    )
  )
  
}