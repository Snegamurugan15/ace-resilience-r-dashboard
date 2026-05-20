library(shiny)
library(shinythemes)
library(ggplot2)

# Load data
data <- read.csv("ace_scores.csv")

# UI
ui <- fluidPage(theme = shinytheme("cerulean"),
                
                titlePanel("Adverse Childhood Experiences (ACE) Score Visualization"),
                
                sidebarLayout(
                  sidebarPanel(
                    h4("Instructions"),
                    p("This app visualizes the ACE scores of 300 participants."),
                    br(),
                    h5("Filter by Gender"),
                    selectInput("gender", "Select gender:", choices = c("All", unique(data$Gender))),
                    br(),
                    h5("Filter by Race/Ethnicity"),
                    selectInput("race", "Select race/ethnicity:", choices = c("All", unique(data$Race))),
                    br(),
                    h5("Filter by Education Level"),
                    selectInput("education", "Select education level:", choices = c("All", unique(data$Education))),
                    br(),
                    h5("Filter by Age Group"),
                    selectInput("age", "Select age group:", choices = c("All", "18-29", "30-39", "40-49", "50-59", "60+")),
                    br(),
                    h5("Filter by ACE Score Range"),
                    sliderInput("score", "Select ACE score range:", min = 0, max = 10, value = c(0, 10), step = 1),
                    br(),
                    h5("Number of Participants"),
                    textOutput("num_participants")
                  ),
                  
                  mainPanel(
                    plotOutput("histogram")
                  )
                )
)

# Server
server <- function(input, output) {
  filtered_data <- reactive({
    data %>%
      filter(ifelse(input$gender == "All", TRUE, Gender == input$gender)) %>%
      filter(ifelse(input$race == "All", TRUE, Race == input$race)) %>%
      filter(ifelse(input$education == "All", TRUE, Education == input$education)) %>%
      filter(ifelse(input$age == "All", TRUE, Age_Group == input$age)) %>%
      filter(Score >= input$score[1] & Score <= input$score[2])
  })
  
  output$num_participants <- renderText({
    nrow(filtered_data())
  })

  output$histogram <- renderPlot({
    ggplot(filtered_data(), aes(x = Score)) +
      geom_histogram(binwidth = 1, color = "black", fill = "lightblue") +
      labs(title = "Histogram of ACE Scores",
           subtitle = paste("Filtered by Gender:", input$gender, "Race/Ethnicity:", input$race, "Education Level:", input$education, "Age Group:", input$age),
           x = "ACE Score",
           y = "Frequency")
  })
}

# Run app
shinyApp(ui = ui, server = server)
