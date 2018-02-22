## prepare sim data
## eta_n x m matrix where m is the number of unique input settings
## and eta_n is the length of each output

simout_path <- '../../out/'
files <- list.files(simout_path, pattern = "csv")
nfile <- length(files)

m <- nfile

sim_native <- matrix(NA, nrow = 90, ncol = m)
x_native <- matrix(NA, nrow = m, ncol = 2)
  
for (i in 1:nfile){
  # read data
  d <- read.csv(paste0(simout_path, files[i]), stringsAsFactors = F)
  sim_native[,i] <- d$euvac
  # extract input from file name
  x_native[i,1] <- as.numeric(unlist(strsplit(files[i], '_'))[2])
  x_native[i,2] <- as.numeric(unlist(strsplit(unlist(strsplit(files[i], '_'))[3], '.csv')))
}

pairs(x_native, labels = c(expression(eta), expression(alpha)))


## read observed data

obs <- read.csv('../../Data/20150311_ott_abs_parsed.csv', stringsAsFactors = F)
obs <- ifelse(obs[,2]<0, 0, obs[,2])

## a simple plot of obs and sim

par(mfrow=c(1,1))
plot(NA, xlim = c(0,90), ylim = c(0,5), axes = F, ylab = "euvac")
matplot(sim_native, col = 'grey', type = "l")
lines(obs, col = 'black', lty = 2, lwd = 2)

## prepare var for obsData
