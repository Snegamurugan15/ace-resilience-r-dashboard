library(shiny)
library(data.table)
library(readr)
library(dplyr)
library(randomForest)
library(caret)
library(shinythemes)

ui =fluidPage(theme = shinytheme("superhero"), 
              pageWithSidebar(
                titlePanel(span(tagList(icon("clipboard"), "ACE SCORE"))),
                
                
                #input values
                
                sidebarPanel(
                  HTML("<h3>ACE SCORE</h3>"),
                  selectInput("Q1",label = " q1",
                              c("Sd" = "0", "D" = "1", "N" = "2", "A" = "3", "SA" = "4")),
                  selectInput("Q2",label = " q2",
                              c("Sd" = "0", "D" = "1", "N" = "2", "A" = "3", "SA" = "4")),
                  selectInput("Q3",label = " q1",
                              c("Sd" = "0", "D" = "1", "N" = "2", "A" = "3", "SA" = "4")),
                  selectInput("Q4",label = " q1",
                              c("Sd" = "0", "D" = "1", "N" = "2", "A" = "3", "SA" = "4")),
                  selectInput("Q5",label = " q1",
                              c("Sd" = "0", "D" = "1", "N" = "2", "A" = "3", "SA" = "4")),
                  selectInput("Q6",label = " q1",
                              c("Sd" = "0", "D" = "1", "N" = "2", "A" = "3", "SA" = "4")),
                  selectInput("Q7",label = " q1",
                              c("Sd" = "0", "D" = "1", "N" = "2", "A" = "3", "SA" = "4")),
                  selectInput("Q8",label = " q1",
                              c("Sd" = "0", "D" = "1", "N" = "2", "A" = "3", "SA" = "4")),
                  selectInput("Q9",label = " q1",
                              c("Sd" = "0", "D" = "1", "N" = "2", "A" = "3", "SA" = "4")),
                  selectInput("Q10",label = " q1",
                              c("Sd" = "0", "D" = "1", "N" = "2", "A" = "3", "SA" = "4")),
                  selectInput("Q11",label = " q1",
                              c("Sd" = "0", "D" = "1", "N" = "2", "A" = "3", "SA" = "4")),
                  selectInput("Q12",label = " q1",
                              c("Sd" = "0", "D" = "1", "N" = "2", "A" = "3", "SA" = "4")),
                  selectInput("Q13",label = " q1",
                              c("Sd" = "0", "D" = "1", "N" = "2", "A" = "3", "SA" = "4")),
                  selectInput("Q14",label = " q1",
                              c("Sd" = "0", "D" = "1", "N" = "2", "A" = "3", "SA" = "4")),
                  selectInput("Q15",label = " q1",
                              c("Sd" = "0", "D" = "1", "N" = "2", "A" = "3", "SA" = "4")),
                  selectInput("Q16",label = " q1",
                              c("Sd" = "0", "D" = "1", "N" = "2", "A" = "3", "SA" = "4")),
                  selectInput("Q17",label = " q1",
                              c("Sd" = "0", "D" = "1", "N" = "2", "A" = "3", "SA" = "4")),
                  selectInput("Q18",label = " q1",
                              c("Sd" = "0", "D" = "1", "N" = "2", "A" = "3", "SA" = "4")),
                  selectInput("Q19",label = " q1",
                              c("Sd" = "0", "D" = "1", "N" = "2", "A" = "3", "SA" = "4")),
                  selectInput("Q20",label = " q1",
                              c("Sd" = "0", "D" = "1", "N" = "2", "A" = "3", "SA" = "4")),
                  selectInput("Q21",label = " q1",
                              c("Sd" = "0", "D" = "1", "N" = "2", "A" = "3", "SA" = "4")),
                  selectInput("Q22",label = " q1",
                              c("Sd" = "0", "D" = "1", "N" = "2", "A" = "3", "SA" = "4")),
                  selectInput("Q23",label = " q1",
                              c("Sd" = "0", "D" = "1", "N" = "2", "A" = "3", "SA" = "4")),
                  selectInput("Q24",label = " q1",
                              c("Sd" = "0", "D" = "1", "N" = "2", "A" = "3", "SA" = "4")),
                  selectInput("Q25",label = " q1",
                              c("Sd" = "0", "D" = "1", "N" = "2", "A" = "3", "SA" = "4")),
                  
                  actionButton("submitbutton","Predict",
                               class = "btn btn-primary")
                ),
                
                mainPanel(
                  #header of main content
                  tags$label(h3("Predicted out come")),
                  verbatimTextOutput("contents"),
                  tableOutput('tabledata') #prediction result table
                )   
              )
)
model = readRDS("RF_new1.rds")

Server = (function(input, output, session) {
  
  
  # Input Data
  datasetInput <- reactive({
    
    df <- data.frame(
      Name = c("Q1",
               "Q2",
               "Q3",
               "Q4",
               "Q5","Q6",
               "Q7",
               "Q8",
               "Q9",
               "Q10",
               "Q11",
               "Q12",
               "Q13",
               "Q14",
               "Q15",
               "Q16",
               "Q17",
               "Q18",
               "Q19",
               "Q20",
               "Q21",
               "Q22",
               "Q23",
               "Q24",
               "Q25"
      ),
      
      Value = as.integer(c(input$Q1,
                           input$Q2,
                           input$Q3,
                           input$Q4,
                           input$Q5,
                           input$Q6,
                           input$Q7,
                           input$Q8,
                           input$Q9,
                           input$Q10,
                           input$Q11,
                           input$Q12,
                           input$Q13,
                           input$Q14,
                           input$Q15,
                           input$Q16,
                           input$Q17,
                           input$Q18,
                           input$Q19,
                           input$Q20,
                           input$Q21,
                           input$Q22,
                           input$Q23,
                           input$Q24,
                           input$Q25
                           )),
      stringsAsFactors = FALSE)
    Result <- 0
    df <- rbind(df, Result)
    input <- transpose(df)
    input= data.frame(input)
    #write.table(input,"input.csv", sep=",", quote = FALSE, row.names = FALSE, col.names = FALSE)
    write.table(input, file = "foo.csv", sep = ",", col.names = NA,qmethod = "double")
    View(input)
    test <- read.csv(paste("input", ".csv", sep=""), header = TRUE)
    
    Output <- data.frame(Prediction=predict(model,test),round(predict(model,test,type="prob"), 3))
    print(Output)
  })
  output$displaydf=renderDataTable(input)
  
  # Output Text Box
  output$contents = renderPrint({
    if (input$submitbutton>0) {
      isolate("Prediction for Random Forest")
    } else {
      return("Random Forest Method")
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

