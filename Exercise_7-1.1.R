#Exercises 7: Complete Section 10.1. 

#Given this UI:
  
library(tidyverse)
library(shiny)

ui <- fluidPage(
  textInput("name", "What's your name?"),
  textOutput("greeting")
)

server1 <- function(input, output, server) {
  renderText(paste0("Hello ", name))
}

shinyApp(ui, server1)

