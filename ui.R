shinyUI(pageWithSidebar(
  headerPanel("BMI Calculator"),
  
  #Sidebar panel with inputs from the user
  sidebarPanel(
    
    #Get inputs from the user for weight and height as well as metric vs imperial
    selectInput("measurement_type", "Please choose imperial or metric Measurements", 
                choices = c("Imperial", "Mettric")),
    numericInput('Weight', 'Your Weight (kg/lb)', 0),
    numericInput('height', 'Your Height (inch or meter)', 0),
    
    submitButton('Submit')
  ),
  mainPanel(
    verbatimTextOutput('ExpectedValue')
  )
))