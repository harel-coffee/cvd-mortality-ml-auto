# Bristol Cardiovascular Surgery ML project

Repo for training a binary classifier to predict cardiac surgery mortality using clinical data collected from Bristol Heart Institute 1996-2017 and compare with existing logistic regression model (EuroSCORE).

## Citation

Benedetto, U., Sinha, S., Lyon, M., Dimagli, A., Gaunt, T. R., Angelini, G., & Sterne, J. (2020). Can machine learning improve mortality prediction following cardiac surgery? European Journal of Cardio-Thoracic Surgery. https://doi.org/10.1093/ejcts/ezaa229

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
