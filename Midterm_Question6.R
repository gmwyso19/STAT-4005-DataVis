Question 5 (25 points). Construct a shiny app using the alcohol.csv data set 
that has a scatterplot of the number of wine servings vs. the number of beer 
servings. In the app, the user should be able to select a country and have a 
label for that country appear on the app.

In addition, create an input that lets the user choose a variable 
(either beer_servings, spirit_servings, and wine_servings) and create an output 
that is a histogram based on that variable.

So you can focus your time on shiny as much as possible, a static graph or wine 
servings vs. beer servings, with Australia labeled, is given below (you may copy
this code to use in your app if you would like).

You must complete this task using shiny (even though you could do something 
                                         similar using plotly).

library(shiny)
library(tidyverse)
library(ggrepel)
library(here)
alcohol_df <- read_csv(here("data/alcohol.csv"))
view(alcohol_df)
onecountry_df <- alcohol_df %>% filter(country == "Australia")

ggplot(alcohol_df, aes(x = beer_servings, y = wine_servings)) +
  geom_point() +
  geom_label_repel(data = onecountry_df, aes(label = country)) +
  geom_point(data = onecountry_df, size = 3, shape = 1)

library(shiny)
ui <- fluidPage(
  sidebarLayout(sidebarPanel(
    selectizeInput("countrychoice",
                   label = "Choose a Country",
                   choices = levels(factor(alcohol_df$)),
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
