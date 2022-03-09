Mini-Tutorial 4: shiny (20 points)

Topics to Cover:
  
  -An Introduction to shiny
-An Introduction to Reactivity

R allows users to create vast data visualizations, including the ability to 
create apps from data sets. These apps allow for coders to create interactive 
data visualizations that the user can control. We can create questions that 
create corresponding results including graphs, tables, maps, you name it. This 
package is called Shiny.

Shiny, is an R package used to make interactive web apps of data sets. 
Shiny combines the computational power of R with the interactivity of the 
modern web. Shiny applications have two components, a user interface object (UI) and
a server function (server), that are passed as arguments to the shinyApp function that
creates a Shiny app object from this UI/server pair. In Shiny, the ui contains 
the imput values, while the server contains the output values.

In .Rmd files and in .R scripts, code is run from beginning to end. This makes 
finding errors in our coding relatively simple because we can run code line by 
line until we find an error. But in the case of the shiny app, code does not run
line by line unless done manually. Instead, code is run through a process called
reactive execution.Reactive programming creates software that responds to events
rather than solicits inputs from users.  An event is simply a signal that 
something has happened. So, reactive programming therefore runs based upon order
in whic it is called, rather than from beginning to end.

For the data set I will be using the stat113 data set which contains data from a 
survey data from STAT 113 in the 2018-2019 academic year. This survey is given 
out each semester to STAT 113 students. In particular with this graph I will be 
using the variables; Year- FirstYear, Sophomore, Junior, or Senior, Hgt, height-
in inches, Wgt- weight, in pounds., GPA, and Exercise- amount of hours of 
exercise in a typical week.

library(readr)
library(tidyverse)

stat113 <- read_csv("data/stat113.csv") #load in data
view(stat113)
library(shiny)

#making an app that shows a histogram of Stat113 students height, weight, GPA, 
#and exercise. The user picks a student class year and statistic and then a 
#histogram is produced to show that relationship.

stat113_year <- stat113 %>% filter(Year == "Junior")
ggplot(data = df_onetype, aes_string(x = "Hgt")) + geom_histogram(bins = 4)

#Here I sorted the data and created the histogram that the app will draw from

ui <- fluidPage(
  sidebarLayout(sidebarPanel(
    selectizeInput("typechoice",
                   label = "Choose a Class Year",
                   choices = levels(factor(stat113$Year)),
                   selected = "Junior"),
    
    radioButtons("statchoice",
                 label = "Choose a Statistic",
                 choices = names(stat113)[c(3, 4, 6, 7)])),
    mainPanel(plotOutput("histplot"))
  )
)
#Here we laid out the factors of the app including what is being asked, what 
#options the user has, and connecting those questions and inputs a histogram
server <- function(input, output, session) {
  
  stat113_edit <- reactive({
    stat113 %>% filter(Year == input$typechoice)
  })
  
  
  output$histplot <- renderPlot({
    ggplot(data = stat113_edit(), aes(x = .data[[input$statchoice]])) +
      geom_histogram(bins = 12, fill = "lightblue", color = "darkblue") 
  })
}
#Here we made the app reactive, note that in the ggplot the stat113_edit has a 
#"()" after it. This makes that data set reactive in the ggplot.
shinyApp(ui, server)
