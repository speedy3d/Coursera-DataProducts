shinyUI(pageWithSidebar(
  headerPanel("BMI Calculator"),
  
  #Sidebar panel with inputs from the user
  sidebarPanel(
    
    #Get inputs from the user for weight and height as well as metric vs imperial
    selectInput("measurement_type", "Please choose imperial (lb/inch) or metric Measurements (kg/cm)", 
      choices = c("Imperial", "Metric")),
    
    sliderInput('raw_Weight', 'Your Weight (kg/lb)', min = 35, max = 300, value=170, step=1),
    sliderInput('raw_Height', 'Your Height (inch or centimeter)', min = 48, max = 275, value=70, step=1),
    
    #old numeric input code
    #numericInput('raw_Weight', 'Your Weight (kg/lb)', 0),
    #numericInput('raw_Height', 'Your Height (inch or meter)', 0),
    
    submitButton('Submit')
  ),
  mainPanel(
    tabsetPanel( id="tabs",
                 
                 tabPanel("Results", value="results", 
                          h3("Your Calculated BMI is:"),
                          conditionalPanel(condition = "input.measurement_type == 'Imperial'",
                                           verbatimTextOutput('bmi_Result_imperial')),
                          conditionalPanel(condition = "input.measurement_type == 'Metric'",
                                           verbatimTextOutput('bmi_Result_metric')),
                          
                          h3("Your Weight Status is:"),
                          conditionalPanel(condition = "input.measurement_type == 'Imperial'",
                                           verbatimTextOutput('i_status')),
                          conditionalPanel(condition = "input.measurement_type == 'Metric'",
                                           verbatimTextOutput('m_status'))
                 ),
                 
                 tabPanel("Charts", value="charts", 
                          h3("Results comparison:"),
                          h2("Your status is shown as a point on the chart"),
                          conditionalPanel(condition = "input.measurement_type == 'Imperial'",
                                           plotOutput(outputId = "i_main_plot", height = "400px")),
                          conditionalPanel(condition = "input.measurement_type == 'Metric'",
                                           plotOutput(outputId = "m_main_plot", height = "400px"))
                          ),
                  
                tabPanel("Documentation", value="Table", 
                          h3("Documentation:")
                          )
                 
    )
  )
))