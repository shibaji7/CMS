## prepare sim data
## eta_n x m matrix where m is the number of unique input settings
## and eta_n is the length of each output

PDF=F

simout_path <- '../../out/ott_51.05/'
files <- list.files(simout_path, pattern = "csv")
nfile <- length(files)

m <- nfile
nlag <- 1
sim_native <- matrix(NA, nrow = 90*nlag, ncol = m)
# x_native <- matrix(NA, nrow = m, ncol = 2)
x_native <- matrix(NA, nrow = m, ncol = 2)
  
for (i in 1:nfile){
  # read data
  d <- read.csv(paste0(simout_path, files[i]), stringsAsFactors = F)
  sim_native[,i] <- d$euvac
  # extract input from file name
  x_native[i,1] <- as.numeric(unlist(strsplit(files[i], '_'))[2])
  x_native[i,2] <- as.numeric(unlist(strsplit(unlist(strsplit(files[i], '_'))[3], '.csv')))
  # x_native[i,2] <- as.numeric(unlist(strsplit(files[i], '_'))[3])
  # x_native[i,3] <- as.numeric(unlist(strsplit(unlist(strsplit(files[i], '_'))[4], '.csv')))
}

pairs(x_native, labels = c(expression(eta), expression(alpha), "sza"))


## read observed data

obs <- read.csv('../../Data/csv/20150311_ott_abs.csv', stringsAsFactors = F)
# obs <- ifelse(obs[,2]<0, 0, obs[,2])
obs <- obs[,2]

## a simple plot of obs and sim

if(PDF) pdf('../plots/sim-obs.pdf', width = 9, height = 6)
par(mfrow=c(1,1))
plot(NA, xlim = c(0,90), ylim = c(0,5), axes = F, ylab = "euvac", xlab = 'time (seconds)')
matplot(sim_native, col = 'grey', type = "l", add = T)
lines(obs, col = 'black', lty = 2, lwd = 2)
axis(1)
axis(2)
legend(60,4,c('sim','obs'), col=c('grey','black'),lty = c(3,2))
if(PDF) dev.off()

write.table(x_native, file="design_brd.txt", quote = F, row.names = F, col.names = F)
write.table(matrix(obs, ncol = 1), file="obs_brd.txt", quote = F, row.names = F, col.names = F)
write.table(sim_native, file="sim_brd.txt", quote = F, row.names = F, col.names = F)
