#Create metrics server
metricServer <- function(id, globalSession) {
  moduleServer(id, function(input, output, session) {
    
    #diamondsFiltered <- reactive({diamondFiltered(diamonds)})
    #plot <- diamondViz(diamondsFiltered(), input$cut, input$color, input$clarity, input$carat)
    output$avgPrice <- shinydashboard::renderValueBox({
      avgP<- calcAveragePrice(diamonds, input$cut, input$color, input$clarity, input$carat)
      valueBox(
        value = tags$p("Average Diamond Price", style = "font-size: 75%;"),
        paste0("$", formatC(as.numeric(avgP), format="f", digits=2, big.mark=",")),
      )
    })
    
    output$predDiamondPrice <- shinydashboard::renderValueBox({
      pred<-  getPrediction(model, input$cutPred, input$colorPred, input$clarityPred, input$caratPred)
      valueBox(
        value = tags$p("Predicted Diamond Price", style = "font-size: 75%;"),
        paste0("$", formatC(as.numeric(pred), format="f", digits=2, big.mark=",")),
        color = "purple") 
    })
    
    output$plot <- renderPlotly({
     # diamondsFil <- reactive({diamondFiltered(diamonds, input$cut, input$color, input$clarity)})
      diamondViz(diamonds, input$cut, input$color, input$clarity, input$carat)
      })
    
    output$barPlot <- renderPlotly({
     # diamondsFiltered <- reactive({diamondFiltered(diamonds, input$cut, input$color, input$clarity)})
      diamondBars(diamonds, input$cut, input$color, input$clarity, input$carat)
    })
    
  })
}