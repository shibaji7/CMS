# scrip to vizualize simulation output

args <- commandArgs(TRUE)
var_ <- args[1]
path <- args[2]

cat("Plotting", var_, '\n')
cat("output path", path, '\n')

PDF <- TRUE
# path <- "../../out/"
files <- list.files(path, pattern="csv")
nfiles <- length(files)

alpha_vec <- vector()
eta_vec <- vector()

l <- list()
for (file in files){
	d <- read.csv(paste0(path, file))	
	alpha <- substr(file, 10, 12)
	eta <- substr(file, 6, 8)
	eta <- unlist(strsplit(file, "_"))[2]
	if(var_ == "alpha") alpha_vec <- c(alpha_vec, alpha)
	if(var_ == "eta") eta_vec <- c(eta_vec, eta)

	l[[paste0(eta,"_",alpha)]] <- d
}

## varying alpha plot
if (var_ == "alpha"){
  if(PDF) pdf('../out/all_run_alpha.pdf', height = 7, width = 10)
  par(oma = c(3,3,1,1))
  plot(NA, xlim=c(0,90), ylim=c(0,5), axes=F, xlab = "Time", ylab = "euvac", main = "Varying alpha")
  for (i in 1:nfiles){
  	lines(1:90, l[[i]]$euvac, col = gray(0.2+((i-1)*0.6/(nfiles-1))), type = "b", pch = 20)
  }
  axis(1, labels = c("15:50:00", "16:20:00", "16:50:00", "17:20:00"), at = seq(1, 90, length.out = 4))
  axis(2, labels = seq(0,5,by=1), at = seq(0,5,by=1))
  legend("topright", legend=alpha_vec, col = gray(0.2+(((1:nfiles)-1)*0.6/(nfiles-1))), lty = 1)
  dev.off()
}

# varying eta plot
if (var_ == "eta"){
  if(PDF) pdf('../out/all_run_eta.pdf', height = 7, width = 10)
  par(oma = c(3,3,1,1))
  plot(NA, xlim=c(0,90), ylim=c(0,5), axes=F, xlab = "Time", ylab = "euvac", main = "Varying eta")
  for (i in 1:nfiles){
    lines(1:90, l[[i]]$euvac, col = gray(0.2+((i-1)*0.6/(nfiles-1))), type = "b", pch = 20)
  }
  axis(1, labels = c("15:50:00", "16:20:00", "16:50:00", "17:20:00"), at = seq(1, 90, length.out = 4))
  axis(2, labels = seq(0,5,by=1), at = seq(0,5,by=1))
  legend("topright", legend=eta_vec, col = gray(0.1+(((1:nfiles)-1)*0.5/(nfiles-1))), lty = 1)
  dev.off()
}


## plot observed data

files <- list.files('../../Data/csv/', pattern = '.csv')
files <- c('../../Data/csv/20150311_brd_abs.csv',
           '../../Data/csv/20150311_gill_abs.csv',
           '../../Data/csv/20150311_mea_abs.csv',
           '../../Data/csv/20150311_ott_abs.csv')
nfile <- length(files)

obs_mat <- matrix(NA, ncol = nfile, nrow = 90)
for (i in 1:nfile){
  d <- read.csv(paste0('../../Data/csv/', files[i]), stringsAsFactors = F)
  obs_mat[,i] <- d[,2]
}

matplot(obs_mat, type="l")
