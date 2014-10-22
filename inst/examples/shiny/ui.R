library(shiny)
library(dimple)

shinyUI(fluidPage(
  
  titlePanel("Shiny dimple.js"),
  
  sidebarLayout(
    sidebarPanel(
      checkboxInput("head", label = "Head Only", value = FALSE)
    ),
    mainPanel(
      dimpleOutput("dimple")
    )
  )
))
