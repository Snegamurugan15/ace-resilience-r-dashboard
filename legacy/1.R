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
      
      # Display the selected ACE category
      h3(textOutput("selected_category")),
      
      # Display the ACE score distribution plot
      plotOutput("ace_distribution"),
      
      # Display the ACE score by age scatterplot
      plotOutput("ace_gender_scatterplot")
    )
  )
)

# Define server
server <- function(input, output) {
  
  # Create reactive subset of ACE data based on selected category
  ace_subset <- reactive({
    if (input$Ace_Scores == "0") 
      {
      ace_data
    } else {
      subset(ace_data, ace_data[, "Ace_Score"] == 1)
    }
  })
  
  # Output selected category
  output$selected_category <- renderText({
    paste("Selected ACE Category:", input$Ace_Score)
  })
  
  # Create ACE score distribution plot
  output$ace_distribution <- renderPlot({
    ace_subset() %>%
      ggplot(aes(x = Ace_Score)) +
      geom_histogram(binwidth = 1) +
      labs(title = "ACE Score Distribution Plot",
           x = "ACE Score", y = "Frequency")
  })
  
  # Create ACE score by age scatterplot
  output$ace_age_scatterplot <- renderPlot({
    ace_subset() %>%
      ggplot(aes(x = ace_data$Gender, y = Ace_Score)) +
      geom_point() +
      labs(title = "ACE Score by Age Scatterplot",
           x = "Gender", y = "ACE Score")
  })
}

# Run the app
shinyApp(ui = ui, server = server)






