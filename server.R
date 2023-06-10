shinyServer(function(input, output, session){
  metricServer("metric", session)  
}
)