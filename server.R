library(UsingR)
library(ggplot2)


shinyServer(
  function(input, output){
    
  #Imperial and metric BMI calculation
  i_bmi <- reactive({input$raw_Weight/(input$raw_Height^2)*703})
  m_bmi <- reactive({input$raw_Weight/((input$raw_Height/100)^2)})

  #Imperial and metric BMI output
  output$bmi_Result_imperial <- renderPrint({i_bmi()})
  output$bmi_Result_metric <- renderPrint({m_bmi()})
  
  #Determine weight status - imperial
  observe({
  if(i_bmi()>=30){
      output$i_status <- renderPrint('Obese')
  }
  else if(i_bmi()>=25){
    output$i_status <- renderPrint('Overweight')
  }
  else if(i_bmi()>=18.5){
    output$i_status <- renderPrint('Normal')
  }
  else {
    output$i_status <- renderPrint('Underweight')
  }
  })
  
  
  
  }
)