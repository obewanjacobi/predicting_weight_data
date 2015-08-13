#-----------------------------------------
# Jacob Townson
# Machine Learning Project Script
# John Hopkins Machine Learning Course
#-----------------------------------------

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






