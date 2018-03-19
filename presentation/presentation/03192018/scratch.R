PNG=TRUE
p <- 0.6
N <- 30
H <- 0.2
set.seed(12)
y <- rep(NA, 4)
if(PNG) png('bayes_example_11.png', width = 700, height = 1000)
par(mfrow=c(5,1), oma=c(0,2,2,2), mar = c(0,2,0,2))
for(i in 1:4){
  y[i] <- rbinom(1, N, p)/N
  plot(y[i],0.1, xlim = c(0.2,1), ylim = c(0,6), xlab = ' ', ylab = ' ', axes = F, cex = 4)
  points(p, 0.1, cex=4, pch = 19, col = 'black')
  lines(c((y[i]-H),(y[i]+H)), c(5,5))
  lines(c((y[i]-H),(y[i]-H)), c(0,5))
  lines(c((y[i]+H),(y[i]+H)), c(0,5))
  lines(c(0,y[i]-H),c(0,0))
  lines(c(y[i]+H,1),c(0,0))
  box()
}
axis(1)
if(PNG) dev.off()

set.seed(12)
y <- rep(NA, 4)
if(PNG) png('bayes_example_12.png', width = 700, height = 1000)
par(mfrow=c(5,1), oma=c(0,2,2,2), mar = c(0,2,0,2))
for(i in 1:4){
  y[i] <- rbinom(1, N, p)/N
  plot(y[i],0.1, xlim = c(0.2,1), ylim = c(0,6), xlab = ' ', ylab = ' ', axes = F, cex = 4)
  # points(p, 0.1, cex=4, pch = 19)
  lines(c((y[i]-H),(y[i]+H)), c(5,5))
  lines(c((y[i]-H),(y[i]-H)), c(0,5))
  lines(c((y[i]+H),(y[i]+H)), c(0,5))
  lines(c(0,y[i]-H),c(0,0))
  lines(c(y[i]+H,1),c(0,0))
  box()
}
axis(1)
if(PNG) dev.off()

set.seed(12)
y <- rep(NA, 4)
if(PNG) png('bayes_example_13.png', width = 700, height = 1000)
par(mfrow=c(5,1), oma=c(2,2,2,2), mar = c(0,2,0,2))
for(i in 1:4){
  y[i] <- rbinom(1, N, p)/N
  plot(y[i],0.1, xlim = c(0.2,1), ylim = c(0,6), xlab = ' ', ylab = ' ', axes = F, cex = 4)
  # points(p, 0.1, cex=4, pch = 19)
  lines(c((y[i]-H),(y[i]+H)), c(5,5))
  lines(c((y[i]-H),(y[i]-H)), c(0,5))
  lines(c((y[i]+H),(y[i]+H)), c(0,5))
  lines(c(0,y[i]-H),c(0,0))
  lines(c(y[i]+H,1),c(0,0))
  box()
}
plot(NA,0.1, xlim = c(0.2,1), ylim = c(0,6), xlab = ' ', ylab = ' ', axes = F, cex = 4)
lines(rep(max(y-H),2), c(0,5))
lines(rep(min(y+H),2), c(0,5))
lines(c(max(y-H), min(y+H)), c(5,5))
lines(c(0,max(y-H)),c(0,0))
lines(c(min(y+H),1),c(0,0))
points(p, 0.1, cex=4, pch = 19)
points((max(y-H) + min(y+H))/2, 0.1, cex=3, col = "green", pch=19)
box()
axis(1)
if(PNG) dev.off()

set.seed(12)
y <- rep(NA, 4)
if(PNG) png('bayes_example_14.png', width = 700, height = 1000)
par(mfrow=c(5,1), oma=c(2,2,2,2), mar = c(0,2,0,2))
for(i in 1:4){
  y[i] <- rbinom(1, N, p)/N
  plot(y[i],0.1, xlim = c(0.2,1), ylim = c(0,10), xlab = ' ', ylab = ' ', axes = F, cex = 4)
  # points(p, 0.1, cex=4, pch = 19)
  lines(seq(0,1,by=0.01), dnorm(seq(0,1,by=0.01), mean = y[i], sd = 0.05))
  box()
}
plot(NA,0.1, xlim = c(0.2,1), ylim = c(0,12), xlab = ' ', ylab = ' ', axes = F, cex = 4)
lines(seq(0,1,by=0.01), dnorm(seq(0,1,by=0.01), mean = mean(y), sd = 0.05/sqrt(2)))
points(p, 0.1, cex=4, pch = 19)
points(mean(y), 0.1, cex=3, col = "green", pch=19)
box()
axis(1)
if(PNG) dev.off()
