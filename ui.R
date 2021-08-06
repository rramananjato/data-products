library(shiny)
shinyUI(fluidPage(
  titlePanel("Modelling Under 5 mortality rate"),
  sidebarLayout(
    sidebarPanel(
      h3("Instructions:"),
      h5("The purpose of this app is to explain Under 5 mortality rate (U5MR)
         in Madagascar by some child key indicators. Data are taken from 
         Madagascar MICS 2018 (mics.unicef.org/surveys) 
         Choose the indicator you want to use as independent variable and 
         you will get summary of related linear model (coefficients and R square). 
         You can also choose to show X and Y axis label or not"),
      radioButtons("x", "Independant variable:",
                   c("Immunization"="imcov",
                     "Contraception"="contraprev",
                     "Skilled attendance"="skilledatt",
                     "Stunting"= "stunting",
                     "Untreated diarrhea"="untreateddia")
                  ),
      checkboxInput("show_xlab", "Show/Hide X Axis Label", value = TRUE),
      checkboxInput("show_ylab", "Show/Hide Y Axis Label", value = TRUE),
    ),
    mainPanel(
      h3("Under 5 mortality rate by chosen independant variable"),
      plotOutput("plot1"),
      h3("Estimated intercept:"),
      textOutput("intercept"),
      h3("Estimated slope:"),
      textOutput("slope"),
      h3("Estimated R square:"),
      textOutput("Rsq"),
    )
  )
))