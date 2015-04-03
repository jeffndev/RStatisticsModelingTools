to.single.quote.list<-function(v) 
{  return( cat(paste("'",paste(v,collapse="' ,'"),"'",sep="")) ) }