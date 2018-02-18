# scrip to vizualize simulation output

PDF <- TRUE
path <- "../../out/"
files <- list.files(path, pattern="csv")
nfiles <- length(files)

alpha_vec <- vector()

l <- list()
for (file in files){
	d <- read.csv(paste0(path, file))	
	alpha <- substr(file, 10, 12)
	eta <- substr(file, 6, 8)
	alpha_vec <- c(alpha_vec, alpha)

	l[[paste0(eta,"_",alpha)]] <- d
}

## plot
if(PDF) pdf('../out/all_run.pdf', height = 7, width = 10)
par(oma = c(3,3,1,1))
plot(NA, xlim=c(0,90), ylim=c(0,5), axes=F, xlab = "Time", ylab = "euvac", main = "Varying alpha")
for (i in 1:nfiles){
	lines(1:90, l[[i]]$euvac, col = gray(0.2+((i-1)*0.6/(nfiles-1))), type = "b", pch = 20)
}
axis(1, labels = c("15:50:00", "16:20:00", "16:50:00", "17:20:00"), at = seq(1, 90, length.out = 4))
axis(2, labels = seq(0,5,by=1), at = seq(0,5,by=1))
legend("topright", legend=alpha_vec, col = gray(0.2+(((1:nfiles)-1)*0.6/(nfiles-1))), lty = 1)
dev.off()
