# EarlyDiagCRC
Identification of CRC and normal samples based on methylation probe expression profile.
# Install
To install the EarlyDiagCRC, install from github using devtools
```
library(devtools)
install_github("Zhao-Wenyuan/EarlyDiagCRC")
```
Or you can download the .ZIP file and and unzip it.
```
install.packages("EarlyDiagCRC",repos = NULL,type="source")
#The "EarlyDiagCRC" should be combined with the absolute path.
```
# Usage
```
library(EarlyDiagCRC)
data(example)
data(model)
Pred=EarlyDiag(data1)
Eval=EarlyDiag_AUC(Tumor,Normal))
biomakers()#The methylation probe markers used in the model and the corresponding gene information were displayed. 
```
The example is two DNA methylation probes("cg07146119","cg06848185") data values (β value) of CRC sample from TCGA M450K data.
# Data input
Tumor or Normal, a dataframe with methylation probes beta values where columns are samples and rows are probes IDs.This data set is used to test the known labels of the input of samples.Data sets need to be divided into two groups: Tumor and Normal.

data1, a dataframe with methylation probes beta values  where columns are samples and rows are probes IDs.This data set is used to predict the input of unknown samples.It doesn't need the original label of the sample.

# Citation
Please use the following citation:
```
https://github.com/Zhao-Wenyuan/EarlyDiagnosis_CRC
```

# Contact email
Please don't hesitate to address comments/questions/suggestions regarding this R package to:
zhaowenyuan@ems.hrbmu.edu.cn
