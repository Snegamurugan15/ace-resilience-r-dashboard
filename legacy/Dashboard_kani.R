library(shiny)
library(data.table)
library(readr)
library(dplyr)
library(randomForest)
library(caret)
library(shinythemes)

ui =fluidPage(theme = shinytheme("superhero"), 
              pageWithSidebar(
                titlePanel(span(tagList(icon("clipboard"), "IMPACT OF SOCIAL MEDIA ON MENTAL HEALTH"))),
                
                #input values
                
                sidebarPanel(
                  HTML("<h3>Time Spending with Social Media</h3>"),
                  selectInput("Q1",label = "How often do you find that you stay online longer than you intended?",
                              c("Never" = "1", "Seldom" = "2", "Occasionally" = "3", "Often" = "4", "Always" = "5")),
                  selectInput("Q2",label = "How often do you neglect chores to spend more time online? ",
                              c("Never" = "1", "Seldom" = "2", "Occasionally" = "3", "Often" = "4", "Always" = "5")),
                  selectInput("Q3",label = "How often do your grades or schoolwork suffer because of the amount of time you spend online?",
                              c("Never" = "1", "Seldom" = "2", "Occasionally" = "3", "Often" = "4", "Always" = "5")),
                  selectInput("Q4",label = "How often do you check your email/WhatsApp/Facebook/ YouTube, etc., before something else that you need to do?",
                              c("Never" = "1", "Seldom" = "2", "Occasionally" = "3", "Often" = "4", "Always" = "5")),
                  selectInput("Q5",label = "How often do you become defensive or secretive when anyone asks you what you do online?",
                              c("Never" = "1", "Seldom" = "2", "Occasionally" = "3", "Often" = "4", "Always" = "5")),
                  selectInput("Q6",label = "How often do you block out disturbing thoughts about your life with soothing/calming thoughts of the internet?",
                              c("Never" = "1", "Seldom" = "2", "Occasionally" = "3", "Often" = "4", "Always" = "5")),
                  selectInput("Q7",label = "How often do you snap, yell, or act annoyed if someone bothers you while you are online?",
                              c("Never" = "1", "Seldom" = "2", "Occasionally" = "3", "Often" = "4", "Always" = "5")),
                  selectInput("Q8",label = "How often do you lose sleep due to late-night logins?",
                              c("Never" = "1", "Seldom" = "2", "Occasionally" = "3", "Often" = "4", "Always" = "5")),
                  selectInput("Q9",label = "How often do you feel preoccupied with the internet when off-line, or fantasize about being online?",
                              c("Never" = "1", "Seldom" = "2", "Occasionally" = "3", "Often" = "4", "Always" = "5")),
                  selectInput("Q10",label = "How often do you find yourself saying, just a few more minutes?",
                              c("Never" = "1", "Seldom" = "2", "Occasionally" = "3", "Often" = "4", "Always" = "5")),
                  selectInput("Q11",label = "How often do you choose to spend more time online over going out with others?",
                              c("Never" = "1", "Seldom" = "2", "Occasionally" = "3", "Often" = "4", "Always" = "5")),
        
                  
                  actionButton("submitbutton","Predict",
                               class = "btn btn-primary")
                ),
                
                mainPanel(
                  #header of main content
                  tags$label(h3("Predicted outcome")),
                  verbatimTextOutput("contents"),
                  tableOutput('tabledata') #prediction result table
                )   
              )
)
model = readRDS("RF_new2.rds")

Server = (function(input, output, session) {
  
  
  # Input Data
  datasetInput <- reactive({
    
    df <- data.frame(
      Name = c("III_Q1",
               "III_Q2",
               "III_Q3",
               "III_Q4",
               "III_Q5",
               "III_Q6",
               "III_Q7",
               "III_Q8",
               "III_Q9", 
               "III_Q10",
               "III_Q11"
               
      ),
      
      Value = as.integer(c(input$III_Q1,
                           input$III_Q2,
                           input$III_Q3,
                           input$III_Q4,
                           input$III_Q5,
                           input$III_Q6,
                           input$III_Q7,
                           input$III_Q8,
                           input$III_Q9,
                           input$III_Q10,
                           input$III_Q11
      )),
      stringsAsFactors = FALSE)
    Result <- 0
    df <- rbind(df, Result)
    input <- transpose(df)
    input= data.frame(input)
    write.table(input,"input.csv", sep=",", quote = FALSE, row.names = FALSE, col.names = FALSE)
    #write.table(input, file = "foo.csv", sep = ",", col.names = NA, qmethod = "double")
    View(input)
    test <- read.csv(paste("input", ".csv", sep=""), header = TRUE)
    
    Output <- data.frame(Prediction=predict(model,test),round(predict(model,test,type="prob"), 3))
    print(Output)
  })
  output$displaydf=renderDataTable(input)
  
  # Output Text Box
  output$contents = renderPrint({
    if (input$submitbutton>0) {
      isolate("Predicted Result")
    } else {
      return("Result")
    }
  })
  
  # Prediction results table
  output$tabledata <- renderTable({
    if (input$submitbutton>0) {
      isolate(datasetInput())
    }
  })
  
})
shinyApp(ui,Server)

