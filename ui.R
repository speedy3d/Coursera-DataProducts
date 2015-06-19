shinyUI(pageWithSidebar(
  headerPanel("BMI Calculator"),
  
  #Sidebar panel with inputs from the user
  sidebarPanel(
    
    #Get inputs from the user for weight and height as well as metric vs imperial
    selectInput("measurement_type", "Please choose imperial or metric Measurements", 
      choices = c("Imperial (lb, inch)", "Metric (kg, meter)")),
    
    numericInput('raw_Weight', 'Your Weight (kg/lb)', 0),
    numericInput('raw_Height', 'Your Height (inch or meter)', 0),
    
    submitButton('Submit')
  ),
  mainPanel(
    tabsetPanel( id="tabs",
                 
                 tabPanel("Results", value="results", 
                          h3("Your Calculated BMI is:"),
                          conditionalPanel(condition = "input.measurement_type == 'Imperial'",
                                           verbatimTextOutput('bmi_Result_imperial')),
                         conditionalPanel(condition = "input.measurement_type == 'Metric'",
                                           verbatimTextOutput('bmi_Result_metric'))
                 ),
                 
                 tabPanel("Charts", value="charts", 
                          h3("Results comparison:")
                          ),
                  
                  tabPanel("Documentation", value="Table", 
                           h3("Documentation:")
                           )
                 
    )
  )
))