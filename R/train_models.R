library(caret)
library(randomForest)
library(e1071)
library(readr)

set.seed(42)

data <- read_csv("data/sample_ace_cer_responses.csv", show_col_types = FALSE)
data$ACE_Level <- as.factor(data$ACE_Level)

control <- trainControl(method = "cv", number = 3)

rf_model <- train(
  ACE_Level ~ .,
  data = data,
  method = "rf",
  trControl = control,
  tuneLength = 2
)

svm_model <- train(
  ACE_Level ~ .,
  data = data,
  method = "svmRadial",
  trControl = control,
  tuneLength = 2
)

dir.create("models", showWarnings = FALSE)
saveRDS(rf_model, "models/rf_ace_cer_model_retrained.rds")
saveRDS(svm_model, "models/svm_ace_cer_model_retrained.rds")

print(rf_model)
print(svm_model)

