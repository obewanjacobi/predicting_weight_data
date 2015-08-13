#-----------------------------------------
# Jacob Townson
# Machine Learning Project Script
# John Hopkins Machine Learning Course
#-----------------------------------------

library(caret)

# This function writes the text files containing the answers I have for the project.

pml_write_files = function(x){
  n = length(x)
  for(i in 1:n){
    filename = paste0("problem_id_",i,".txt")
    write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
  }
}

# Read in the data

if(exists('train') == FALSE){
  train <- read.csv('https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv')
}
if(exists('test') == FALSE){
  test <- read.csv('https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv')
}

# Clean the Data

goodNames <- sapply(test, function(x)!all(is.na(x)))
df <- train[,goodNames]
namesdf <- names(df)
wanted <- namesdf[-c(1,3,4,5,6,7)]
df <- df[,wanted]


# Make Data Partition

set.seed(2200)
separate <- createDataPartition(y = df$classe, p = .6, list = FALSE)
trainData <- df[separate,]
testData <- df[-separate,]


# Make the Trees

mod <- train(x = trainData[, -54], y = trainData$classe,
             method = 'rf', trControl = trainControl(method = 'oob'),
             importance = TRUE, ntree = 100, tuneLength = 3, do.trace = 50)
mypredicts <- predict(mod, newdata = testData[,1:53])
confusionMatrix(mypredicts, testData$classe)
myImp <- varImp(mod, scale = FALSE, type = 1)
plot(myImp, top = 10, main = 'Variable Importance')


# Predict the Examination Data

lastTest <- test[,goodNames]
namesdf <- names(lastTest)
wanted <- namesdf[-c(1,3,4,5,6,7)]
lastTest <- lastTest[,wanted]
myAnswer <- predict(mod, newdata = lastTest[,1:53])
pml_write_files(myAnswer)





