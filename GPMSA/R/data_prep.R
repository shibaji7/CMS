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
  d <- read.csv(paste0(simout_path, files[i]))
  sim_native[,i] <- d$euvac
  # extract input from file name
  x_native[i,1] <- as.numeric(unlist(strsplit(files[i], '_'))[2])
  x_native[i,2] <- as.numeric(unlist(strsplit(unlist(strsplit(files[i], '_'))[3], '.csv')))
}