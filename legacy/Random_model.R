library(caret)
library(e1071)
library(randomForest)
library(caret)
library(e1071)
library(readxl)

new_data= read_excel(file.choose())
head(new_data)
str(new_data)
new_data$Score = as.factor(new_data$Score)
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
RFM = randomForest(Score~Q1+Q2+Q3+Q4+Q5+Q6+Q7+Q8+Q9+Q10+Q11+Q12+Q13+Q14+Q15+Q16+Q17+Q18+Q19+Q20+Q21+Q22+Q23+Q24+Q25,data = Training,ntree = 200, mtry = 4, importance = TRUE)
#SVM = svm(Result~Opposition+Toss+ Venue +Day_Night +partscore +Score,data = Training)
summary(RFM)

Category_pred = predict(RFM,Testing)
Testing$Category_pred = Category_pred
print(RFM)
print(Testing$Category_pred )
print(Testing$Score)
confusionMatrix(table(Testing$Score,Testing$Category_pred))
saveRDS(RFM,"RF_new1.rds")
