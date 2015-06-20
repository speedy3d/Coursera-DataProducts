shinyUI(pageWithSidebar(
  headerPanel("BMI Calculator"),
  
  #Sidebar panel with inputs from the user
  sidebarPanel(
    
    #Get inputs from the user for weight and height as well as metric vs imperial
    selectInput("measurement_type", "Please choose imperial (lb/inch) or metric Measurements (kg/cm)", 
      choices = c("Imperial", "Metric")),
    
    sliderInput('raw_Weight', 'Your Weight (lb or kg)', min = 35, max = 300, value=170, step=1),
    sliderInput('raw_Height', 'Your Height (inch or centimeter)', min = 48, max = 275, value=70, step=1),
    
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
                 
                 tabPanel("Comparison Chart", value="charts", 
                          h3("BMI chart plotting your input with typical height and weight:"),
                          conditionalPanel(condition = "input.measurement_type == 'Imperial'",
                                           plotOutput(outputId = "i_main_plot", height = "400px")),
                          conditionalPanel(condition = "input.measurement_type == 'Metric'",
                                           plotOutput(outputId = "m_main_plot", height = "400px")),
                          p(""),
                          p("Chart sourced from:", a("SAS and RC, Contour plot of BMI by weight and height", href="http://sas-and-r.blogspot.ie/2010/04/example-731-contour-plot-of-bmi-by.html"))
                          ),
                  
                tabPanel("Documentation", value="Table", 
                          h3('Formula used in imperial calculations'),
                          p('BMI = Weight (in lb)/Height^2 (in inches) * 703'),
                          code('w/h^2 * 703'),
                          h3('Formula used in metric calculations'),
                          p('BMI = Weight (in kg)/Height/100^2 (in cm)'),
                          code('w/(h/100)^2'),
                          h3('BMI Categories'),
                          p('Underweight = <18.5'),
                          p('Normal weight = 18.5-24.9'),    
                          p('Overweight = 25-29.9'),
                          p('Obesity = BMI of 30 or greater'),
                          p(''),
                          h5("Reference:", a("CDC", href="http://www.cdc.gov/healthyweight/assessing/bmi/adult_bmi/index.html?s_cid=tw_ob064"))
                          )
                 
    )
  )
))