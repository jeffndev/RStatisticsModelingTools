require(gbm)
require(caret)
require(e1071)
require(randomForest)
require(nnet)

ten.fold<-function(data){
  setIndexes<-list()
  sampleSize<-round(0.1*nrow(data))
  remainingIdxs<-1:nrow(data)
  for(i in 1:9){
    curSet<-sample(remainingIdxs,sampleSize)
    setIndexes[[i]]<-curSet
    remainingIdxs<-setdiff(remainingIdxs,curSet)
  }
  setIndexes[[10]]<-remainingIdxs
  return(setIndexes)
}

cross.validate<-function(data){
  leave.out.sets<-ten.fold(data)
  N<-nrow(data)
  numFeatures<-ncol(data)-1
  responseIdx<-ncol(data)
  accuracies<-vector()
  for(i in 1:10){
    test <-data[leave.out.sets[[i]],]
    train<-data[ setdiff(1:N,leave.out.sets[[i]]),]   
    print(paste('train iteration',i))
    #mdl<-multinom(R~.,data=train,maxit=300)
    #mdl<-multinom(Party~RecentVoter + Education + MaritalStatus, data=train, maxit=300)
    #mdl<-multinom(Party~RecentVoter+generations+Education+IncomeEstEnhanced+Ethnicity+
    #                MaritalStatus+AEN+AMC+BRVO+CMDY+
    #                CNBC+CNN+ESPN+FOOD+FX+FXNC+HGTV+HIST+MNBC+MTV+SPK+TBS+
    #                TLC+TNT+TVL+USA, data=train, maxit=300)
    #add Gender...no better, maybe touch worse
    #mdl<-multinom(Party~RecentVoter+Gender+generations+Education+IncomeEstEnhanced+Ethnicity+
    #                MaritalStatus+AEN+AMC+BRVO+CMDY+
    #                CNBC+CNN+ESPN+FOOD+FX+FXNC+HGTV+HIST+MNBC+MTV+SPK+TBS+
    #                TLC+TNT+TVL+USA, data=train, maxit=300)
    #mdl<-multinom(Repub~., data=train)
    #
    ntrees<-600
    #mdl<-gbm.fit(x=train[,1:numFeatures],y=train[,responseIdx],n.trees=ntrees, verbose=F, shrinkage=0.005, interaction.depth=20, n.minobsinnode=5, distribution="multinomial")
    #mdl<-naiveBayes(Party~Gender+generations+Education+IncomeEstEnhanced+Ethnicity+HomeOwnership+MaritalStatus+Children,data=train)
    #mdl<-naiveBayes(Repub ~ .,data=train)
    #mdl<-randomForest(Party~Gender+generations+Education+IncomeEstEnhanced+Ethnicity+HomeOwnership+MaritalStatus+Children, data=train)
    #mdl<-randomForest(R ~ ., data=train)
    #mdl<-svm(Party~Gender+generations+Education+IncomeEstEnhanced+Ethnicity+HomeOwnership+MaritalStatus+Children, data=train, kernel="radial", cost=10)
    mdl<-svm(Repub ~ ., data=train, kernel="radial", cost=15)
    print('train complete:begin predict')
    mtx<-confusionMatrix(predict(mdl,newdata=test[ ,1:numFeatures]),test[ ,responseIdx])$table
    #mtx<-confusionMatrix(transformed.gbm.predictions(mdl,test[ ,1:numFeatures],levels(test[ ,responseIdx]),ntrees),test[ ,responseIdx])$table
    print(mtx)
    numCorrect<-sum(diag(mtx))
    accuracy<-numCorrect/nrow(test)
    print(paste('iteration',i,': ', accuracy, 'accurate'))
    accuracies[length(accuracies)+1]<-accuracy
  }
  return(mean(accuracies))
}

transformed.gbm.predictions<-function(mdl, testdata, targetLevels, ntrees){
  n.targets<-length(targetLevels)
  #prepare the factor structure WITH ALL THE LEVELS in it
  predictions<-factor(targetLevels)
  predictions<-predictions[-c(1:n.targets)] #clear it out, ready to be refilled below
  levelIdxsPredicted<-max.col(matrix(predict.gbm(mdl,newdata=testdata,n.trees=ntrees),ncol=n.targets))
  predictionsChr<-sapply(levelIdxsPredicted, function(i) targetLevels[i])
  predictions[1:length(predictionsChr)]<-predictionsChr #otherwise the factor structure gets blown away..
  return(predictions)
}

mdl.check<-function(model, test){
  yIdx<-ncol(test)
  lastxIdx<-yIdx-1
  confusionMatrix(predict(model,newdata=test[,1:lastxIdx]),test[,yIdx])
}
  
  