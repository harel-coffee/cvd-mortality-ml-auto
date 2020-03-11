library('pROC')
library('data.table')
library('ggplot2')

# increase font sizes
theme_update(text = element_text(size=22))

# read in test data
test <- fread("./probs.19.02.20.csv")
test$STATUS_DISCHARGE<-as.numeric(test$STATUS_DISCHARGE)

# make roc
es1_roc <- roc(test$STATUS_DISCHARGE, test$es_i_logistic, auc=TRUE, ci=TRUE)
es2_roc <- roc(test$STATUS_DISCHARGE, test$es_ii_logistic, auc=TRUE, ci=TRUE)
lr_roc <- roc(test$STATUS_DISCHARGE, test$LR, auc=TRUE, ci=TRUE)
rf_roc <- roc(test$STATUS_DISCHARGE, test$RF, auc=TRUE, ci=TRUE)
nb_roc <- roc(test$STATUS_DISCHARGE, test$NB, auc=TRUE, ci=TRUE)
nn_roc <- roc(test$STATUS_DISCHARGE, test$NN, auc=TRUE, ci=TRUE)

l <- list()
l[[paste0("EuroSCORE1\nAUC ", round(es1_roc$ci[2],2), "\n(95CI ", round(es1_roc$ci[1], 2), ", ", round(es1_roc$ci[3], 2), ")")]] <- es1_roc
l[[paste0("EuroSCORE2\nAUC ", round(es2_roc$ci[2],2), "\n(95CI ", round(es2_roc$ci[1], 2), ", ", round(es2_roc$ci[3], 2), ")")]] <- es2_roc
l[[paste0("LogisticRegression\nAUC ", round(lr_roc$ci[2],2), "\n(95CI ", round(lr_roc$ci[1], 2), ", ", round(lr_roc$ci[3], 2), ")")]] <- lr_roc
l[[paste0("RandomForest\nAUC ", round(rf_roc$ci[2],2), "\n(95CI ", round(rf_roc$ci[1], 2), ", ", round(rf_roc$ci[3], 2), ")")]] <- rf_roc
l[[paste0("NaiveBayes\nAUC ", round(nb_roc$ci[2],2), "\n(95CI ", round(nb_roc$ci[1], 2), ", ", round(nb_roc$ci[3], 2), ")")]] <- nb_roc
l[[paste0("NeuralNetwork\nAUC ", round(nn_roc$ci[2],2), "\n(95CI ", round(nn_roc$ci[1], 2), ", ", round(nn_roc$ci[3], 2), ")")]] <- nn_roc

p <- ggroc(l, size = 1.5) + 
    theme(legend.position='bottom') + 
    theme(legend.title = element_blank()) + 
    ggtitle("ROC curve (testidation data)") +
    geom_segment(aes(x = 1, xend = 0, y = 0, yend = 1), color="darkgrey", linetype="dashed")
ggsave('roc.test.jpg', p, width=11)