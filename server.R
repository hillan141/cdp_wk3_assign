
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
require(MASS)

shinyServer(function(input, output) {

  output$distPlot <- renderPlot({
    mu <- c(0,0)
    s12 <- 0
    if (input$xycorrel == 'none') {
      s12 <- 0    
    } else {
        if (input$xycorrel == 'pos') {
            s12 <- min(input$s11, input$s22) * 0.9
        } else {
            s12 <- min(input$s11, input$s22) * -0.9
        }
    }
    sigma <- matrix(as.numeric(c(input$s11, s12, s12, input$s22)), 2)
    print(sigma)
    binorm <- mvrnorm(input$nsample, mu = mu, Sigma = sigma )
    # Calculate kernel density estimate
    binorm.dens <- kde2d(binorm[,1], binorm[,2], n = 50)
    # Contour plot overlayed on heat map image of results
    image(binorm.dens) # , xlim=c(-10,10), ylim=c(-10,10))
    contour(binorm.dens, add = TRUE)
    
  })

  # txt <- renderText({"The covariance matrix:"})
  
  output$table <- renderTable({
    s12 <- 0
    if (input$xycorrel == 'none') {
      s12 <- 0    
    } else {
      if (input$xycorrel == 'pos') {
        s12 <- min(input$s11, input$s22) * 0.9
      } else {
        s12 <- min(input$s11, input$s22) * -0.9
      }
    }
    matrix(c(input$s11, s12, s12, input$s22), 2,
           dimnames=list(paste("s", c("x", "y"), sep=""), paste("s", c("x", "y"), sep="")))
  })
  
})
