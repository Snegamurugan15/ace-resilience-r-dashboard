library(shiny)
library(bslib)
library(dplyr)
library(ggplot2)

source("R/score_ace.R")

question_ids <- paste0("Q", 1:25)
choice_labels <- c(
  "Strongly disagree" = 0,
  "Disagree" = 1,
  "Neutral" = 2,
  "Agree" = 3,
  "Strongly agree" = 4
)

load_model <- function() {
  model_path <- "models/rf_ace_cer_model.rds"
  if (file.exists(model_path)) {
    readRDS(model_path)
  } else {
    NULL
  }
}

ui <- page_sidebar(
  title = "ACE and Resilience Dashboard",
  theme = bs_theme(version = 5, bootswatch = "flatly"),
  sidebar = sidebar(
    width = 360,
    h5("Response Inputs"),
    lapply(question_ids, function(id) {
      selectInput(id, id, choices = choice_labels, selected = 0)
    }),
    actionButton("predict", "Calculate", class = "btn-primary")
  ),
  layout_columns(
    card(
      card_header("ACE/CER Score"),
      h2(textOutput("score_text")),
      p(textOutput("level_text"))
    ),
    card(
      card_header("Model Prediction"),
      h2(textOutput("prediction_text")),
      p("Uses the saved Random Forest model when available; otherwise falls back to rule-based scoring.")
    )
  ),
  card(
    card_header("Response Profile"),
    plotOutput("profile_plot", height = 280)
  )
)

server <- function(input, output, session) {
  model <- load_model()

  responses <- eventReactive(input$predict, {
    as.integer(sapply(question_ids, function(id) input[[id]]))
  }, ignoreNULL = FALSE)

  output$score_text <- renderText({
    result <- score_ace_level(responses())
    paste(result$total, "points")
  })

  output$level_text <- renderText({
    result <- score_ace_level(responses())
    paste("Rule-based level:", result$level)
  })

  output$prediction_text <- renderText({
    values <- responses()
    result <- score_ace_level(values)
    if (is.null(model)) {
      return(result$level)
    }

    input_frame <- as.data.frame(as.list(values))
    names(input_frame) <- question_ids
    tryCatch(as.character(predict(model, input_frame)[1]), error = function(e) result$level)
  })

  output$profile_plot <- renderPlot({
    data.frame(question = factor(question_ids, levels = question_ids), value = responses()) |>
      ggplot(aes(question, value)) +
      geom_col(fill = "#2c7fb8") +
      coord_cartesian(ylim = c(0, 4)) +
      labs(x = NULL, y = "Response value") +
      theme_minimal(base_size = 13)
  })
}

shinyApp(ui, server)

