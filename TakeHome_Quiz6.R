Complete this Quiz in a .Rmd file. Submit a .Rmd and a knitted .html file to GitHub by the due date and time.

Statement of Integrity: Copy and paste the following statement and then sign your name (by typing it) on the line below.

“All work presented is my own, and I have followed all rules for collaboration.” 

Grace Wysocki

Collaboration Reminder: You may work with other students who are in our class on the take-home quiz, but you must list who you worked with at the top of your quiz. Write the name of any student(s) that you collaborated with in the space below this (ignore this if you did not collaborate with any students).

Clara Mugnai

Construct a Shiny app for any data set that we have worked with so far (besides SLU Majors and Tennis) or for any data set you used in STAT/DATA 234. Thirteen points will be given for Shiny apps that:
  
  run,
have at least 2 different inputs,
have at least 1 plot output that looks presentable (e.g. appropriate labels, colour scale, and makes sense to construct).
Then, write a 2 sentence description about the purpose of your app (2 points).



library(readr)
library(tidyverse)

pokemon_df <- read_csv("data/pokemon_full.csv")
library(shiny)

df_onetype <- pokemon_df %>% filter(Type == "Water")
ggplot(data = df_onetype, aes_string(x = "height")) + geom_histogram(bins = 12)

ui <- fluidPage(
  sidebarLayout(sidebarPanel(
      selectizeInput("typechoice",
                    label = "Choose a Type of Pokemon",
                    choices = levels(factor(pokemon_df$Type)),
                    selected = "Water"),
      
      radioButtons("statchoice",
                             label = "Choose a Statistic",
                             choices = names(pokemon_df)[c(12, 13, 14)])),
    mainPanel(plotOutput("histplot"))
  )
)
server <- function(input, output, session) {
  
  pokemon_edit <- reactive({
    pokemon_df %>% filter(Type == input$typechoice)
  })
  
  
  output$histplot <- renderPlot({
    ggplot(data = pokemon_edit(), aes(x = .data[[input$statchoice]])) +
      geom_histogram(bins = 12, fill = "lightblue", color = "darkblue") 
  })
}

shinyApp(ui, server)

## The app allows for users to select different types of Pokemon and choose a 
## certain feature about the Pokemon type like height. The output is then a 
## histogram graph that displays the counts of the certain feature of the 
##chosen pokemon type.
