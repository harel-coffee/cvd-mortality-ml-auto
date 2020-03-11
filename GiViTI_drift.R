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

# plot
cb <- givitiCalibrationBelt(o=b1$STATUS_DISCHARGE, e=b1$es_i_logistic, devel = "external")
givitiCalibrationTest(b1$STATUS_DISCHARGE, e=b1$es_i_logistic, devel="external")
jpeg("ES1.test.b1.belt.jpg")
plot(cb, main = "EuroSCORE1 (1/2)", xlab = "Predicted probability", ylab = "Observed mortality")
dev.off()

cb <- givitiCalibrationBelt(o=b2$STATUS_DISCHARGE, e=b2$es_i_logistic, devel = "external")
givitiCalibrationTest(b2$STATUS_DISCHARGE, e=b2$es_i_logistic, devel="external")
jpeg("ES1.test.b2.belt.jpg")
plot(cb, main = "EuroSCORE1 (2/2)", xlab = "Predicted probability", ylab = "Observed mortality")
dev.off()

### missing data too high for ES2 ###

cb <- givitiCalibrationBelt(o=b1$STATUS_DISCHARGE, e=b1$LR, devel = "external")
givitiCalibrationTest(b1$STATUS_DISCHARGE, e=b1$LR, devel="external")
jpeg("LR.test.b1.belt.jpg")
plot(cb, main = "LogisticRegression (1/2)", xlab = "Predicted probability", ylab = "Observed mortality")
dev.off()

cb <- givitiCalibrationBelt(o=b2$STATUS_DISCHARGE, e=b2$LR, devel = "external")
givitiCalibrationTest(b2$STATUS_DISCHARGE, e=b2$LR, devel="external")
jpeg("LR.test.b2.belt.jpg")
plot(cb, main = "LogisticRegression (2/2)", xlab = "Predicted probability", ylab = "Observed mortality")
dev.off()

cb <- givitiCalibrationBelt(o=b1$STATUS_DISCHARGE, e=b1$RF, devel = "external")
givitiCalibrationTest(b1$STATUS_DISCHARGE, e=b1$RF, devel="external")
jpeg("RF.test.b1.belt.jpg")
plot(cb, main = "RandomForest (1/2)", xlab = "Predicted probability", ylab = "Observed mortality")
dev.off()

cb <- givitiCalibrationBelt(o=b2$STATUS_DISCHARGE, e=b2$RF, devel = "external")
givitiCalibrationTest(b2$STATUS_DISCHARGE, e=b2$RF, devel="external")
jpeg("RF.test.b2.belt.jpg")
plot(cb, main = "RandomForest (2/2)", xlab = "Predicted probability", ylab = "Observed mortality")
dev.off()

cb <- givitiCalibrationBelt(o=b1$STATUS_DISCHARGE, e=b1$NN, devel = "external")
givitiCalibrationTest(b1$STATUS_DISCHARGE, e=b1$NN, devel="external")
jpeg("NN.test.b1.belt.jpg")
plot(cb, main = "NeuralNetwork (1/2)", xlab = "Predicted probability", ylab = "Observed mortality")
dev.off()

cb <- givitiCalibrationBelt(o=b2$STATUS_DISCHARGE, e=b2$NN, devel = "external")
givitiCalibrationTest(b2$STATUS_DISCHARGE, e=b2$NN, devel="external")
jpeg("NN.test.b2.belt.jpg")
plot(cb, main = "NeuralNetwork (2/2)", xlab = "Predicted probability", ylab = "Observed mortality")
dev.off()