p <- 0.6
N <- 30
H <- 0.2
set.seed(12)
y <- rep(NA, 4)
png('bayes_example_11.png', width = 700, height = 1000)
par(mfrow=c(5,1), oma=c(0,2,2,2), mar = c(0,2,0,2))
for(i in 1:4){
  y[i] <- rbinom(1, N, p)/N
  plot(y[i],0.1, xlim = c(0.2,1), ylim = c(0,6), xlab = ' ', ylab = ' ', axes = F, cex = 4)
  points(p, 0.1, cex=4, pch = 19)
  lines(c((y[i]-H),(y[i]+H)), c(5,5))
  lines(c((y[i]-H),(y[i]-H)), c(0,5))
  lines(c((y[i]+H),(y[i]+H)), c(0,5))
  lines(c(0,y[i]-H),c(0,0))
  lines(c(y[i]+H,1),c(0,0))
  box()
}
axis(1)
dev.off()

set.seed(12)
y <- rep(NA, 4)
png('bayes_example_12.png', width = 700, height = 1000)
par(mfrow=c(5,1), oma=c(0,2,2,2), mar = c(4,2,0,2))
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
#plot(y,0.1, xlim = c(0.2,1), ylim = c(0,6), xlab = ' ', ylab = ' ', axes = F, cex = 4)
axis(1)
dev.off()