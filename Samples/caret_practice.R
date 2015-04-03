
library(caret)
load(url("http://caret.r-forge.r-project.org/descr.RData"))
load(url("http://caret.r-forge.r-project.org/mutagen.RData"))

#set.seed(1)
inTrain<-createDataPartition(mutagen, p=3/4, list=F)
trainDescr<-descr[inTrain,]
testDescr<-descr[-inTrain,]

trainClass <- mutagen[inTrain]
testClass <- mutagen[-inTrain]
#some quick diagnostics
prop.table(table(mutagen))
prop.table(table(trainClass))
prop.table(table(testClass))

#removing variable that have zero sd 
nearZeroVar(trainDescr)
trainDescr<-trainDescr[, -c(155, 708, 1539)]
testDescr <-testDescr[, -c(155, 708, 1539)]
ncol(trainDescr)
descrCorr<-cor(trainDescr)
highCorr <- findCorrelation(descrCorr, 0.90)
trainDescr<-trainDescr[,-highCorr]
testDescr<-testDescr[,-highCorr]

xTrans <- preProcess(trainDescr)
summary(trainDescr[,1:10])
trainDescr<-predict(xTrans,trainDescr)
#sapply(trainDescr[,1:10],sd)
testDescr<-predict(xTrans,testDescr)
#sapply(testDescr,mean)

