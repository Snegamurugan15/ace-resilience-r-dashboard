install.packages("shiny")
install.packages("shinythemes")
library(shiny)
library(shinythemes)

# UI

ui <- fluidPage(
                titlePanel("Adverse Childhood Experiences (ACE) Score"),
                
                sidebarLayout(
                  sidebarPanel(
                                h4("Consent Form"),
                                p("The information regarding this study, has been read by me. Having understood the same,
                                  I hereby give my consent and willingness to participate in this survey:"),
                                selectInput("q2", "Select:", choices = c("Yes", "No")),
                                ), 
                      
                   mainPanel(
                     
                            h4("Instructions"),
                            p("Please answer the following questions to calculate your ACE score:"),
                            br(),
                            p("1. Did a parent or other adult in the household often or very often..."),
                            p("Swear at you, insult you, put you down, or humiliate you?"),
                            checkboxInput("qa","1-Yes"),
                            checkboxInput("qa","0-No"),
                            p("Push, grab, slap, or throw something at you?"),
                            checkboxInput("qb","1-Yes"),
                            checkboxInput("qb","0-No"),
                            br(),
                            p("2.  Did an adult or person at least 5 years older than you ever..."),
                            p( "Touch or fondle you or have you touched their body in a sexual way?"),
                            checkboxInput("qc","1-Yes"),
                            checkboxInput("qc","0-No"),
                            p("No one in your family loved you or thought you were important or special?"),
                            checkboxInput("qd","1-Yes"),
                            checkboxInput("qd","0-No"),
                            br(),
                            p("3. Did you..."),
                            p("often feel that: You didn’t have enough to eat, had to wear dirty clothes, and had no one to protect you?"),
                            checkboxInput("qe","1-Yes"),
                            checkboxInput("qe","0-No"),
                            p("have parents ever separated or divorced?"),
                            checkboxInput("qf","1-Yes"),
                            checkboxInput("qf","0-No"),
                            br(),
                            p("4.Did you..."),
                            p( " have an absentee father/mother due to their job abroad?"),
                            checkboxInput("qg","1-Yes"),
                            checkboxInput("qg","0-No"),
                            p(" live with anyone who was a problem drinker or alcoholic, or who used drugs? "),
                            checkboxInput("qh","1-Yes"),
                            checkboxInput("qh","0-No"),
                            br(),
                            p("5. Did a household member..."),
                            p( "depressed or mentally ill, or did a household member attempt suicide? ") ,
                            checkboxInput("qi","1-Yes"),
                            checkboxInput("qi","0-No"),
                            p("Did a household member go to prison? (Or) Did a household member have been involved in any legal enquiries or undergone public humiliation (social shamming)?"),
                            checkboxInput("qj","1-Yes"),
                            checkboxInput("qj","0-No"),
                            br(),
                            actionButton("submit", "Submit"),
                            br(),
                            h4("Your ACE Observation is:"),
                            verbatimTextOutput("score")
                )
              )
)

# Server
server <- function(input, output, session) {
  output$score <- renderText({
    score <- input$qa + input$qb + input$qc + input$qd + input$qe + input$qf + input$qg + input$qh + input$qi + input$qj
    paste(score, " out of 10")
    


# Prediction based on Scores
if(score == 0){
  print("No exposure to Adverse Childhood Experiences")
}
    else if(score == 1 | score == 2 | score == 3){
      print ("Low exposure to Adverse Childhood Experiences")
    }
    else if(score == 4 | score == 5 | score == 6){
      print ("Moderate exposure to Adverse Childhood")
    }
    else if(score == 7 | score == 8 | score == 9){
      print ("High exposure to Adverse Childhood Experiences")
    }
    else
    {
      print("Extremely High Exposure to Adverse Childhood Experiences")
    }
  }) 
}

# Run app
shinyApp(ui = ui, server = server)


                    



