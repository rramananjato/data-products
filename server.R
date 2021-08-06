library(shiny)
data <- data.frame(read.csv("C:/Temp/um5r.csv"))
shinyServer(function(input, output) {
    output$plot1 <- renderPlot({
      dataX <- switch(input$x,
                      imcov = data$imcov,
                      contraprev = data$contraprev,
                      skilledatt = data$skilledatt,
                      stunting = data$stunting,
                      untreateddia = data$untreateddia)
      dataY <- data$u5mr
      model <- lm(dataY ~ dataX)
      modelpred <- reactive({
        predict(model, newdata = data.frame(dataX))
      })
    x <- switch(input$x,
                imcov = "Immunization coverage (%)",
                contraprev = "Contraceptive prevalence (%)",
                skilledatt = "Skilled attendance at delivery (%)",
                stunting = "Stunting rate (%)",
                untreateddia = "Untreated diarrhea (%)")
    xlab <- ifelse(input$show_xlab, x, "")
    ylab <- ifelse(input$show_ylab, "Under 5 mortality rate (per 1,000 LB)", "")
    plot(dataX, dataY, xlab = xlab, ylab = ylab, col="blue")
    abline(model, col = "red", lwd = 2)
  })
  output$intercept <- renderText({
    dataX <- switch(input$x,
                    imcov = data$imcov,
                    contraprev = data$contraprev,
                    skilledatt = data$skilledatt,
                    stunting = data$stunting,
                    untreateddia = data$untreateddia)
    dataY <- data$u5mr
    model <- lm(dataY ~ dataX)
    coef(model)[1]
  })
  output$slope <- renderText({
    dataX <- switch(input$x,
                    imcov = data$imcov,
                    contraprev = data$contraprev,
                    skilledatt = data$skilledatt,
                    stunting = data$stunting,
                    untreateddia = data$untreateddia)
    dataY <- data$u5mr
    model <- lm(dataY ~ dataX)
    coef(model)[2]
  })
  output$Rsq <- renderText({
    dataX <- switch(input$x,
                    imcov = data$imcov,
                    contraprev = data$contraprev,
                    skilledatt = data$skilledatt,
                    stunting = data$stunting,
                    untreateddia = data$untreateddia)
    dataY <- data$u5mr
    model <- lm(dataY ~ dataX)
    summary(model)[[8]]
  })
})