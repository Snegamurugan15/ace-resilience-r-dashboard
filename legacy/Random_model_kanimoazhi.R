library(caret)
library(e1071)
library(randomForest)
library(caret)
library(e1071)
library(readxl)

new_data= read_excel(file.choose())
head(new_data)
str(new_data)
new_data$WEMWBS = as.factor(new_data$WEMWBS)
#new_data$Opposition =as.factor(new_data$Opposition)
#new_data$Toss = as.factor(new_data$Toss)
#new_data$Venue = as.factor(new_data$Venue)
summary(new_data)

set.seed(3033)
index = sample(2,nrow(new_data),replace = T,prob = c(0.7,0.3))
Training = new_data[index==1,]
Testing = new_data[index==2,]
dim(Training)
dim(Testing)
colnames(new_data)
RFM = randomForest(WEMWBS~III_Q1+III_Q2+III_Q3+III_Q4+III_Q5+III_Q6+III_Q7+III_Q8+III_Q9+III_Q10+III_Q11, data = Training,ntree = 200, mtry = 4, importance = TRUE)
#SVM = svm(Result~Opposition+Toss+ Venue +Day_Night +partscore +Score,data = Training)
summary(RFM)

Category_pred = predict(RFM,Testing)
Testing$Category_pred = Category_pred
print(RFM)
print(Testing$Category_pred )
print(Testing$WEMWBS)
confusionMatrix(table(Testing$WEMWBS, Testing$Category_pred))
saveRDS(RFM,"RF_new2.rds")
