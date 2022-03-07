library(tidyverse)
library(shiny)


ui <- fluidPage(
  textInput("name", "What's your name?"),
  textOutput("greeting")
)

server3 <- function(input, output, server) {
  output$greeting <- paste0("Hello", input$name)
}

shinyApp(ui, server3)
