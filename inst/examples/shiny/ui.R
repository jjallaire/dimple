library(dimple)

shinyUI(fluidPage(
  
  titlePanel("Shiny dimple.js"),
  
  sidebarLayout(
    sidebarPanel(),
    mainPanel(
      dimpleOutput("dimple")
    )
  )
))
