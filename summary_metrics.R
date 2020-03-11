library('data.table')
library('broom')

percent <- function(x, digits = 2, format = "f", ...) {
  paste0(formatC(100 * x, format = format, digits = digits, ...), "%")
}

# read in file
d <- fread("esi.features.17.02.20.csv", drop=c("Test", "Train"))

# chi square test for metric dead vs alive
total_alive <- 27934
total_dead <- 786
d$P <- apply(d, 1, function(row){
    if (row[['Field']] == "Age (continuous)"){
        # Two tailed T-test assuming unequal variance (Excel)
        return(1.59797e-20)
    }
    if (row[['Field']] == "N"){
        return(NA)
    }
    p = tryCatch({

        # define params
        alive_true <- as.numeric(row[['Alive']])
        alive_false <- total_alive - alive_true
        dead_true <- as.numeric(row[['Dead']])
        dead_false <- total_dead - dead_true

        # create 2x2 table
        x <- matrix(c(alive_true, alive_false, dead_true, dead_false), nrow = 2, dimnames = list(c(paste(row[['Field']], "true", sep="_"), paste(row[['Field']], "false", sep="_")), c("alive", "dead")))

        # chi2 test
        p <- tidy(chisq.test(x))$p.value

        # return P
        return(p)

    }, error = function(error_condition) {
        message(paste("Could not determine P for:", row[['Field']]))
        return(NA)
    })
})

# convert raw counts to PCT
d$Alive_PCT <- percent(d$Alive / 27934.00)
d$Dead_PCT <- percent(d$Dead / 786.00)

# Age is not a PCT
d[1]$Alive_PCT <- NA
d[1]$Dead_PCT <- NA

# write out
write.csv(d[,c("Field", "Alive", "Alive_PCT", "Dead", "Dead_PCT", "P")], file="esi.features.17.02.20.processed.csv")