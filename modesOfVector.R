modes.of.vector<-function(v){
  vt<-table(v)
  return( as.numeric(names(vt[vt==max(vt)])))
}