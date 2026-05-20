packages <- c(
  "shiny",
  "bslib",
  "dplyr",
  "ggplot2",
  "readr",
  "randomForest",
  "e1071",
  "caret"
)

missing <- packages[!packages %in% rownames(installed.packages())]
if (length(missing) > 0) {
  install.packages(missing)
}

