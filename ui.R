library(shiny)

hashProxy <- function(inputoutputID) {
  div(id=inputoutputID,class=inputoutputID,tag("div",""));
}

shinyUI(pageWithSidebar(
    
  # Application title
  headerPanel("Test paramètres dans l'URL",
              "pour l'appli simulateur 2014"),
  
  sidebarPanel(
    tags$p("Ici on rentre les valeurs"),
    numericInput("PS", "Pourcentage des votes pour le PS :", value=35),
    numericInput("UMP", "Pourcentage des votes pour le UMP :", value=35),
    numericInput("FN", "Pourcentage des votes pour le FN :", value=30),
    submitButton("Valider")
    ),
  
  mainPanel(
    includeHTML("URL.js"),
    shinyalert(id="somme"),
    h3(textOutput("resultats")),
    hashProxy("hash")
  )
  

))