# Interactive Regression Analysis 
# The code performs linear regression between these vectors 
# plot the relationship
# 
#
library(shiny)
library(datasets)



###############################################################################
# Working dataset used to create the Interactive Regression Site 
###############################################################################
x1 = 1
x2 = 25
y1 = 1
y2 = 25
x = seq(x1, x2, by=1)
y = c(3,2,3,4,1,3,5,8,9,11,14,13,12,11,10,12,12,17,20,21,22,23,22,24,22)
###############################################################################


###############################################################################
#shinyServer() Function  
###############################################################################
# Define server logic required to summarize and view 
# the selected dataset
shinyServer(function(input, output) {


  # Plot the first "n" observations
  output$plot <- renderPlot({
    
    #Connect local data vectors (xx, yy) with the global data vectors (x, y) 
    xx = x
    yy = y


    #Get the requested plot range 
    r <- input$range
    x0 = xx[ r[1]:r[2] ]
    y0 = yy[ r[1]:r[2] ]


    #Make aegression analysis for the given range     
    fit <- lm(y0 ~ x0)           #fit the segment  
    b = fit$coefficients[1]      #y intercept of the line
    a = fit$coefficients[2]      #slope of the line
   

    #Fit a linear model in the given range 
    y0 = b + a*x0


   # Generate a summary of the dataset
    output$summary <- renderPrint({
     #summary(fit)
     b = format(as.numeric(b), digit=4)
     a = format(as.numeric(a), digit=4)
     print(c('Slope    :', a), quote=FALSE)
     print(c('Intercept:', b), quote=FALSE)
    })


    #Plot the line connecting the selected points  
    plot(x0, y0, type='n', xlab='X', ylab='Y',
         xlim=c(x1,x2), ylim=c(y1,y2), cex=1.2)
    lines(x0, y0, lwd=4, col='red')

    #overplot parameter needed to make two 'plot' in the same frame 
    par(new=TRUE)  


    #Plot all data points in the background 
    plot(x, y, type='p', xlab='X', ylab='Y', 
         xlim=c(x1,x2), ylim=c(y1,y2), pch=16, 
         cex=1.5, col='blue')	

    #Plot the y=x line in the background
    x_1 = seq(1,25,by=1)
    y_1 = x_1
    lines(x_1, y_1)

  })
})
###############################################################################
