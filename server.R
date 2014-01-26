library(shiny)
require(shinysky)
# gestion des URL grâce à Alex Brown : https://gist.github.com/alexbbrown/6e77383b48a044191771

url_fields_to_sync <- c("PS","UMP","FN")

shinyServer(function(input, output, session) {
  
  
  output$resultats <- renderText({
    observe({
      if (sum(input$UMP, input$PS, input$FN) == 100) {
        return()
      }
      else {
        showshinyalert("somme","La somme des valeurs n'est pas égale à 100 !",session, styleclass="danger")
        updateNumericInput(session, "FN", value = 100 - input$PS - input$UMP) # ne fonctionne pas. Pourquoi ?
      } 
    })
    
    if (sum(input$UMP, input$PS, input$FN) == 100) return(paste("Le PS obtient", input$PS, "% des voix, l'UMP", input$UMP, "% et le FN", input$FN, "%." ))

  })
  
  firstTime <- TRUE
  
  output$hash <- renderText({
    
    newHash = paste(collapse=";",
                    Map(function(field) {
                      paste(sep="=",
                            field,
                            input[[field]])
                    },
                    url_fields_to_sync))
    
    # the VERY FIRST time we pass the input hash up.
    return(
      if (!firstTime) {
        newHash
      } else {
        if (is.null(input$hash)) {
          NULL
        } else {
          firstTime<<-F;
          isolate(input$hash)
        }
      }
    )
  })
})