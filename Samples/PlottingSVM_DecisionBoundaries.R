require(e1071)
## a simple example
data(cats, package = "MASS")
m <- svm(Sex~., data = cats)
plot(m, cats)

## more than two variables: fix 2 dimensions
data(iris)
m2 <- svm(Species~., data = iris)
plot(m2, iris, Petal.Width ~ Petal.Length,
     slice = list(Sepal.Width = 3, Sepal.Length = 4))

## plot with custom symbols and colors
plot(m, cats, svSymbol = 1, dataSymbol = 2, symbolPalette = rainbow(4),
     color.palette = terrain.colors)



require(e1071) # for svm()                                                                                                                                                          
require(rgl) # for 3d graphics.                                                                                                                                                                                    
set.seed(12345)                                                                                                                                                                     
seed <- .Random.seed                                                                                                                                                                
t <- data.frame(x=runif(100), y=runif(100), z=runif(100), cl=NA)
t$cl <- 2 * t$x + 3 * t$y - 5 * t$z                                                                                                                                                 
t$cl <- as.factor(ifelse(t$cl>0,1,-1))
t[1:4,]
nrow(t)
svm_model<-svm(cl ~., t, type='C-classification', kernel='linear',scale=FALSE)
svm_model

w <- t(svm_model$coefs) %*% svm_model$SV
detalization <- 100                                                                                                                                                                 
grid <- expand.grid(seq(from=min(t$x),to=max(t$x),length.out=detalization),                                                                                                         
                    seq(from=min(t$y),to=max(t$y),length.out=detalization))                                                                                                         
z <- (svm_model$rho- w[1,1]*grid[,1] - w[1,2]*grid[,2]) / w[1,3]

plot3d(grid[,1],grid[,2],z)  # this will draw plane.
# adding of points to the graphics.
points3d(t$x[which(t$cl==-1)], t$y[which(t$cl==-1)], t$z[which(t$cl==-1)], col='red')
points3d(t$x[which(t$cl==1)], t$y[which(t$cl==1)], t$z[which(t$cl==1)], col='blue')
