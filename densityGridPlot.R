#want a function to show a grid of the density estimates plots of each variable passed
#sort of like a Pairs
densities.grid<-function(var.frame){
  classes = sapply(var.frame, is.numeric) #class)
  var.frame<-data.frame(var.frame[,classes])   #data.frame(var.frame[,classes!="factor"])
  N<-ncol(var.frame)
  rc<-ceiling(sqrt(N))
  old.par<-par(mfrow=c(rc,rc))
  par(mar = rep(2, 4))
  for( v in 1:N)  
    plot(density( var.frame[,v] ,na.rm=T),main=names(var.frame)[v]) 
  
  par(old.par)
}