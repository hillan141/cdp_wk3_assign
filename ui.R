
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Bivariate Normal Explorer"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("nsample",
                  "Number of samples:",
                  min = 100,
                  max = 10000,
                  value = 100),
      
      numericInput("s11", label="X standard deviation", value=1, min=1, max=10, step=0.1),
      numericInput("s22", label="Y standard deviation", value=1, min=1, max=10, step=0.1),    
      radioButtons("xycorrel", "XY correlation", 
                 choices=c("None" = "none", "Positive" = "pos", "Negative" = "neg"), 
                 selected = NULL, inline = FALSE, width = NULL)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      h3(a("Click here for help", href="Bivariate_Explorer_Help.html")),
      h3("Contour plot of distribution"),
      plotOutput("distPlot"),
      h3("The covariance matrix"),
      tableOutput("table")
    )
  )
))
