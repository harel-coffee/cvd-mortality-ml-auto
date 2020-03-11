library('data.table')
library('givitiR')
library('ResourceSelection')
library('broom')

# read in probabilities
test <- fread("./probs.19.02.20.csv")
test$STATUS_DISCHARGE<-as.numeric(test$STATUS_DISCHARGE)

# split into two bins with approx equal mortality rate (~ 100 deaths in each)
b1 <- test[1:4308]
table(b1$STATUS_DISCHARGE)
b2 <- test[4309:8616]
table(b2$STATUS_DISCHARGE)

# run HL test for each model fit
fit <- apply(b1, 2, function(x){ tidy(hoslem.test(x, b1$STATUS_DISCHARGE)) })
b1_fit <- rbindlist(fit, idcol="model")
fit <- apply(b2, 2, function(x){ tidy(hoslem.test(x, b1$STATUS_DISCHARGE)) })
b2_fit <- rbindlist(fit, idcol="model")

# write out results
write.csv(merge(b1_fit, b2_fit, "model"), file="HL_results.csv")