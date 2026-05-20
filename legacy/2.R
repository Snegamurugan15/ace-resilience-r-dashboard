install.packages("shiny")
install.packages("shinythemes")
install.packages("readxl")
install.packages("XLS")
# Load necessary packages
library(readxl)
library(shiny)
library(shinythemes)
library(ggplot2)
library(dplyr)

# Load the ACE data
ace_data <- read_excel("C:/Users/snega/OneDrive/Desktop/final_M.sc_project.xlsx")

# UI
ui <- fluidPage(theme = shinytheme("cerulean"),
                
                titlePanel("Adverse Childhood Experiences (ACE) Score Visualization"),
                
                sidebarLayout(
                  sidebarPanel(
                    h4("Instructions"),
                    p("This dashboard visualizes the ACE scores of n participants."),
                    br(),
                    h5("Filter by Gender"),
                    selectInput("gender", "Select gender:", choices = c("All", unique(ace_data$Gender))),
                    br(),
                    h5("Filter by Class"),
                    selectInput("Class", "Select Class:", choices = c("All", unique(ace_data$Class))),
                    br(),
                    h5("Filter by Urbanity"),
                    selectInput("Urbanity", "Select Urbanity:", choices = c("All", unique(ace_data$Urbanity))),
                    br(),
                    h5("Filter by Annual Income"),
                    selectInput(" Annual Income", "Select  Annual Income category", choices = c("All", unique(ace_data$AnnualIncomeoftheFamily))),
                    br(),
                    h5("Filter by ACE_Score"),
                    sliderInput("Score", "Select ACE score range:", min = 0, max = 10, value = c(0, 10), step = 1),
                
                    h5("Number of Participants"),
                    numericInput("n", "Enter number of participants:", value = 100, min = 1, max = nrow(ace_data))
                  ),
                  
                  mainPanel(
                    plotOutput("histogram")
                  )
                )
)

# Server
server <- function(input, output) {
  filtered_data <- reactive({
    ace_data %>%
      filter(ifelse(input$gender == "All", TRUE, Gender == inputgender)) %>%
      filter(ifelse(input$class == "All", TRUE, Class == input$class)) %>%
      filter(ifelse(input$urbanity == "All", TRUE, Urbanity == input$urbanity)) %>%
      filter(ifelse(input$annualincome == "All", TRUE, AnnualIncomeoftheFamily == input$annualincome)) %>%
      filter(Score >= input$score[1] & Score <= input$score[2]) %>%
      sample_n(input$n)
  })
  
  output$histogram <- renderPlot({
    ggplot(filtered_data(), aes(x = Score)) +
      geom_histogram(binwidth = 1, color = "black", fill = "lightblue") +
      labs(title = "Histogram of ACE Scores",
           subtitle = paste("Filtered by Gender:", input$gender, "class:", input$class, "Urbanity:", input$urbanity, "Anunualincome:", input$annualincome, "ACE Score Range:", input$score[1], "-", input$score[2]),
           x = "ACE Score",
           y = "Frequency")
  })
}

# Run app
shinyApp(ui = ui, server = server)
