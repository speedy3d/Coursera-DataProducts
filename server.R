library(UsingR)

EV <- function(ev1, ev2, pr1, pr2) ev1*pr1 + ev2*pr2

shinyServer(
  function(input, output){
  output$ExpectedValue <- renderPrint({EV(input$ev1, input$ev2, input$pr1, input$pt2)})
    }
  )

