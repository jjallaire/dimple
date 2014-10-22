library(dimple)
library(datasets)

shinyServer(function(input, output) {
  
  dataset <- reactive({
    if (input$head)
      head(cars)
    else
      cars
  })
  
  
  output$dimple <- renderDimple({
    dimple(dataset())
  })
  
})
