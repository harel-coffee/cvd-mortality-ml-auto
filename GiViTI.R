library('data.table')
library('givitiR')
library('ResourceSelection')
library('broom')

# read in probabilities
test <- fread("./probs.19.02.20.csv")
test$STATUS_DISCHARGE<-as.numeric(test$STATUS_DISCHARGE)

# plot
cb <- givitiCalibrationBelt(o=test$STATUS_DISCHARGE, e=test$es_i_logistic, devel = "external")
givitiCalibrationTest(test$STATUS_DISCHARGE, e=test$es_i_logistic, devel="external")
jpeg("ES1.test.belt.jpg")
plot(cb, main = "EuroSCORE1 (test)", xlab = "Predicted probability", ylab = "Observed mortality")
dev.off()

cb <- givitiCalibrationBelt(o=test$STATUS_DISCHARGE, e=test$es_ii_logistic, devel = "external")
givitiCalibrationTest(test$STATUS_DISCHARGE, e=test$es_ii_logistic, devel="external")
jpeg("ES2.test.belt.jpg")
plot(cb, main = "EuroSCORE2 (test)", xlab = "Predicted probability", ylab = "Observed mortality")
dev.off()

cb <- givitiCalibrationBelt(o=test$STATUS_DISCHARGE, e=test$LR, devel = "external")
givitiCalibrationTest(test$STATUS_DISCHARGE, e=test$LR, devel="external")
jpeg("LR.test.belt.jpg")
plot(cb, main = "LogisticRegression (test)", xlab = "Predicted probability", ylab = "Observed mortality")
dev.off()

cb <- givitiCalibrationBelt(o=test$STATUS_DISCHARGE, e=test$RF, devel = "external")
givitiCalibrationTest(test$STATUS_DISCHARGE, e=test$RF, devel="external")
jpeg("RF.test.belt.jpg")
plot(cb, main = "RandomForest (test)", xlab = "Predicted probability", ylab = "Observed mortality")
dev.off()

cb <- givitiCalibrationBelt(o=test$STATUS_DISCHARGE, e=test$NN, devel = "external")
givitiCalibrationTest(test$STATUS_DISCHARGE, e=test$NN, devel="external")
jpeg("NN.test.belt.jpg")
plot(cb, main = "NeuralNetwork (test)", xlab = "Predicted probability", ylab = "Observed mortality")
dev.off()