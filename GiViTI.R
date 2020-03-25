library('data.table')
library('givitiR')
library('ResourceSelection')
library('broom')
setEPS()

# read in probabilities
test <- fread("./probs.19.02.20.csv")
test$STATUS_DISCHARGE<-as.numeric(test$STATUS_DISCHARGE)

# plot
cb <- givitiCalibrationBelt(o=test$STATUS_DISCHARGE, e=test$es_i_logistic, devel = "external")
givitiCalibrationTest(test$STATUS_DISCHARGE, e=test$es_i_logistic, devel="external")
postscript("ES1.test.belt.eps")
plot(cb, main = "EuroSCORE1", xlab = "Predicted probability", ylab = "Observed mortality")
dev.off()

cb <- givitiCalibrationBelt(o=test$STATUS_DISCHARGE, e=test$es_ii_logistic, devel = "external")
givitiCalibrationTest(test$STATUS_DISCHARGE, e=test$es_ii_logistic, devel="external")
postscript("ES2.test.belt.eps")
plot(cb, main = "EuroSCORE2", xlab = "Predicted probability", ylab = "Observed mortality")
dev.off()

cb <- givitiCalibrationBelt(o=test$STATUS_DISCHARGE, e=test$LR, devel = "external")
givitiCalibrationTest(test$STATUS_DISCHARGE, e=test$LR, devel="external")
postscript("LR.test.belt.eps")
plot(cb, main = "LogisticRegression", xlab = "Predicted probability", ylab = "Observed mortality")
dev.off()

cb <- givitiCalibrationBelt(o=test$STATUS_DISCHARGE, e=test$RF, devel = "external")
givitiCalibrationTest(test$STATUS_DISCHARGE, e=test$RF, devel="external")
postscript("RF.test.belt.eps")
plot(cb, main = "RandomForest", xlab = "Predicted probability", ylab = "Observed mortality")
dev.off()

cb <- givitiCalibrationBelt(o=test$STATUS_DISCHARGE, e=test$NN, devel = "external")
givitiCalibrationTest(test$STATUS_DISCHARGE, e=test$NN, devel="external")
postscript("NN.test.belt.eps")
plot(cb, main = "NeuralNetwork", xlab = "Predicted probability", ylab = "Observed mortality")
dev.off()