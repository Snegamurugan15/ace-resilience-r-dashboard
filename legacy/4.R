install.packages("readxl")
install.packages("XLS")
# Load necessary packages
library(readxl)
library(shiny)
library(ggplot2)
library(dplyr)

# Load the ACE data
ace_data <- read_excel("C:/Users/snega/OneDrive/Desktop/final_M.sc_project.xlsx")

ACE_SCORE <- ace_data$Ace_Score

# UI
ui <- fluidPage(theme = shinytheme("cerulean"),
                
                titlePanel("Adverse Childhood Experiences (ACE) Score Visualization"),
                
                sidebarLayout(
                  sidebarPanel(
                    h4("Instructions"),
                    p("Please enter the number of participants and their ACE scores below:"),
                    numericInput("n", "Number of participants:", value = 10, min = 1, max = 100),
                    br(),
                    h5("ACE Scores"),
                    numericInput("score1", "Participant 1:", value = 0, min = 0, max = 10),
                    numericInput("score2", "Participant 2:", value = 0, min = 0, max = 10),
                    numericInput("score3", "Participant 3:", value = 0, min = 0, max = 10),
                    numericInput("score4", "Participant 4:", value = 0, min = 0, max = 10),
                    numericInput("score5", "Participant 5:", value = 0, min = 0, max = 10),
                    numericInput("score6", "Participant 6:", value = 0, min = 0, max = 10),
                    numericInput("score7", "Participant 7:", value = 0, min = 0, max = 10),
                    numericInput("score8", "Participant 8:", value = 0, min = 0, max = 10),
                    numericInput("score9", "Participant 9:", value = 0, min = 0, max = 10),
                    numericInput("score10", "Participant 10:", value = 0, min = 0, max = 10),
                    br(),
                    actionButton("submit", "Submit"),
                    br(),
                    h4("Histogram of ACE Scores"),
                    plotOutput("histogram")
                  ),
                  
                  mainPanel()
                )
)

# Server
server <- function(input, output) {
  data <- reactive({
    scores <- c(input$score1, input$score2, input$score3, input$score4, input$score5, input$score6, input$score7, input$score8, input$score9, input$score10)
    scores <- scores[1:input$n]
    data.frame(Scores = scores)
  })
  
  output$histogram <- renderPlot({
    ggplot(data(), aes(x = Scores)) +
      geom_histogram(binwidth = 1, color = "black", fill = "lightblue") +
      labs(title = "Histogram of ACE Scores",
           x = "ACE Score",
           y = "Frequency")
  })
}

# Run app
shinyApp(ui = ui, server = server)
