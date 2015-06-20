library(UsingR)
library(shiny)

#Imperial - Data for BMI chart - sourced from (http://sas-and-r.blogspot.ie/2010/04/example-731-contour-plot-of-bmi-by.html)
i_ht = seq(48,84, length.out=1000)
i_wt = seq(90,300, length.out=1000)
i_wtht = expand.grid(x=i_ht, y=i_wt)
i_bmi = function(h,w) {(w * 703)/(h*h)}
i_bmiwtht = matrix(i_bmi(i_wtht$x,i_wtht$y),length(i_ht),length(i_wt))

#Metric (converted) - Data for BMI chart - sourced from (http://sas-and-r.blogspot.ie/2010/04/example-731-contour-plot-of-bmi-by.html)
m_ht = seq(1.2,2.2, length.out=1000)
m_wt = seq(40,140, length.out=1000)
m_wtht = expand.grid(x=m_ht, y=m_wt)
m_bmi = function(h,w) { w /(h*h)}
m_bmiwtht = matrix(m_bmi(m_wtht$x,m_wtht$y),length(m_ht),length(m_wt))

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
  
  #Determine weight status - metric
  observe({
    if(m_bmi()>=30){
      output$m_status <- renderPrint('Obese')
    }
    else if(m_bmi()>=25){
      output$m_status <- renderPrint('Overweight')
    }
    else if(m_bmi()>=18.5){
      output$m_status <- renderPrint('Normal')
    }
    else {
      output$m_status <- renderPrint('Underweight')
    }
  })
  
  #plot - imperial. Sourced from (http://sas-and-r.blogspot.ie/2010/04/example-731-contour-plot-of-bmi-by.html)
  output$i_main_plot <- renderPlot({
  par(mar=c(4,4,0,0))
  contour(i_ht,i_wt,i_bmiwtht,levels = c(18.5,25,30), drawlabels=FALSE,
            xlab="Height (inches)",ylab="Weight (lbs)")
    
  text(55,200,"Obese",cex=2,srt=45)
  text(65,165,"Overweight",cex=2,srt=40)
  text(70,150,"Normal",cex=2,srt=35)
  text(75,120,"Underweight",cex=2,srt=18)
    
  #Plot a point for user input bmi value
  points(input$raw_Height, input$raw_Weight, pch=18, cex=3)
  })
  
  #plot - metric. Sourced from (http://sas-and-r.blogspot.ie/2010/04/example-731-contour-plot-of-bmi-by.html)
  output$m_main_plot <- renderPlot({
    par(mar=c(4,4,0,0))
    contour(m_ht,m_wt,m_bmiwtht,levels = c(18.5,25,30), drawlabels=FALSE,
            xlab="Height (meters)",ylab="Weight (kg)")
    
    text(1.4,90,"Obese",cex=2,srt=45)
    text(1.71,80,"Overweight",cex=2,srt=32)
    text(1.75,67,"Normal",cex=2,srt=28)
    text(1.95,54,"Underweight",cex=2,srt=22)
    
    #Plot a point for user input bmi value
    points(input$raw_Height*100, input$raw_Weight, pch=18, cex=3)
  })
  
  }
)