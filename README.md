# Bristol Cardiovascular Surgery ML project

Repo for training a binary classifier to predict cardiac surgery mortality using clinical data collected from Bristol Heart Institute 1996-2017 and compare with existing logistic regression model (EuroSCORE).

## Notebooks

1. [feature selection](feature_selection.ipynb)
2. [euroscore](euroscore.ipynb)
3. [evaluation](evaluation.ipynb)

## Downstream analysis

### Baseline characteristics

```sh
Rscript summary_metrics.R
```

### ROC curve plot

```sh
Rscript roc.R
```

### Calbration plots

```sh
Rscript GiViTI.R
```

### Calibration drift

```sh
Rscript GiViTI_drift.R
Rscript hl_drift.R
```
