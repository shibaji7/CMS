# generate design for GPMSA

eta_range <- c(0.05, 0.8)
alpha_range <- c(0.8, 3)

set.seed(123)
nsample <- 100
d <- data.frame(eta = runif(nsample, eta_range[1], eta_range[2]),
                alpha = runif(nsample, alpha_range[1], alpha_range[2]))

write.csv(d, "../out/design.csv", row.names = F, quote = F)
