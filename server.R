library(UsingR)
library(ggplot2)


shinyServer(
  function(input, output){
    
  #Imperial BMI calculation
  output$bmi_Result_imperial <- renderPrint({(input$raw_Weight/input$raw_Height^2) * 703})
  
  #Metric BMI calculation
  output$bmi_Result_metric <- renderPrint({(input$raw_Weight/input$raw_Height^2)})
    }
  )

