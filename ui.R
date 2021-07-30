library(shiny)


# Define UI for dataset viewer application
shinyUI(pageWithSidebar(

  # Application title
  headerPanel("Interactive Regression Analysis"),


  # Sidebar with controls to select a dataset and specify the number
  # of observations to view
  sidebarPanel(
    sliderInput("range", "Choose a Range:", 
                 min=1, max=25, value=c(10,15))
  ),


  # Show a summary of the dataset and an HTML table with the requested
  # number of observations
  mainPanel(
      tabPanel("Summary", verbatimTextOutput("summary")), 
      tabPanel("Plot", plotOutput("plot"))
  )
))
