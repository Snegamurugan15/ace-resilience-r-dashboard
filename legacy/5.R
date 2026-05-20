install.packages("readxl")
install.packages("XLS")
# Load necessary packages
library(readxl)
library(shiny)
library(ggplot2)
library(dplyr)

# Load the ACE data
ace_data <- read_excel("C:/Users/snega/OneDrive/Desktop/final_M.sc_project.xlsx")

Ace_Score <- ace_data$Ace_Score
# Define UI
ui <- fluidPage(
  
  # Set page title
  titlePanel("ACE_DASHBOARD"),
  
  # Set sidebar layout
  sidebarLayout(
    
    # Set sidebar panel
    sidebarPanel(
      
      # Select input for choosing the ACE score
      selectInput("Ace_Score", label = "SELECT YOUR Ace Score:", 
                  choices = c("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"),
                  selected = "0")
    ),
    
    # Set main panel
    mainPanel(
      h4("Histogram of ACE Scores"),
      plotOutput("histogram")
    )
  )


# Define server
server <- function(input, output) {
  data <- reactive({
    scores <- Ace_Score[1:297]
    data.frame(Scores = scores)
  })
  
  output$histogram <- renderPlot({
    ggplot(ace_data, aes(x = Scores)) +
      geom_histogram(binwidth = 1, color = "black", fill = "lightblue") +
      labs(title = "Histogram of ACE Scores",
           x = "ACE Score",
           y = "Frequency")
  })
  })
}

# Run the app
shinyApp(ui = ui, server = server)






