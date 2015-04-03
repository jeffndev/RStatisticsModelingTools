
GENDER.M<-rbind( c(199911,356965),c(183818,321620))
dimnames(GENDER.M)<-list(dbs=c("AIDB","AA"),gender=c("F","M"))
GENDER.M
prop.table(GENDER.M,1)
chisq.test(GENDER.M)

AGE.M<-rbind(c(11828,278925,272797),c(8515, 221638,251888))
dimnames(AGE.M)<-list(dbs=c("AIDB","AA"),age.bins=c("<25","25-54","55+"))
AGE.M
prop.table(AGE.M,1)
chisq.test(AGE.M)

EDU.M<-rbind( c(35482, 103505, 100999, 79689, 59901), c(51153, 125630, 118777,85758,66053))
dimnames(EDU.M)<-list(dbs=c("AIDB","AA"), edu=c("Less than HS","High School","Some College", "Bachelors D","Graduate D"))
prop.table(EDU.M,1)
EDU.M
chisq.test(EDU.M)

EDU.M.Perc<-round(prop.table(EDU.M,1)*100)
chisq.test(EDU.M.Perc)
