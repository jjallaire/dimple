library(dimple)
library(datasets)

shinyServer(function(input, output) {
  
  output$dimple <- renderDimple({
    dimple(cars)
  })
  
})
