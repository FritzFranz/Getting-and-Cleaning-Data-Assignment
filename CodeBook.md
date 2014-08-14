---
title: "CodeBook"
author: "FF Getting and Cleaning Data - Course Project"
date: "Thursday, August 14, 2014"
output: html_document
---

This codebook describes 

* the variables  
* the data  
* the transformations 
 
### The variables 
We have 3 types of variables:  
* the subject codess, which come from the subject_train.txt 
resp subject_test.txt datasets. There is 1 entry per observation.
In total we have 30 subjects. 

* the activity codes, which come from the y.train.txt and y.test.txt datasets. For readability, this codes are translated to labels, for this the dataset activity_labels.txt is used. 
There are 6 different activities with codes 1-6 and labels as described.

```r
activity =  read.table("activity_labels.txt", 
                       header=F, colClasses=c("integer", "character"))
activity[,2] = tolower(activity[,2])
names(activity) = c("Code", "Label")
activity 
```

```
##   Code              Label
## 1    1            walking
## 2    2   walking_upstairs
## 3    3 walking_downstairs
## 4    4            sitting
## 5    5           standing
## 6    6             laying
```


* the computed data from the measurements: 
In total there are 561 computed numeric variables per observation which are provided in the X_train.txt and X_test.txt datasts. The names of the variables are contained in the features.txt dataset and are read from there for further processing. 

Out of these 561 variables, 66 variables are selected. 
The relevant variables are identified using regular expressionws applied to their names. 
The selected names contain either -mean() or -std()  as substrings. 
The grep() function provides the indices needed to select the variables in the later steps. 



```r
features = read.table("features.txt", 
                      header=F, colClasses=c("integer", "character"))
names(features) = c("seq", "varname")

select_mean = grep('+-mean\\(\\)*', features$varname)    
select_std = grep("*-std\\(\\)*", features$varname)
select = unique(c(select_mean, select_std))  # combine lists
features[select,]
```

```
##     seq                     varname
## 1     1           tBodyAcc-mean()-X
## 2     2           tBodyAcc-mean()-Y
## 3     3           tBodyAcc-mean()-Z
## 41   41        tGravityAcc-mean()-X
## 42   42        tGravityAcc-mean()-Y
## 43   43        tGravityAcc-mean()-Z
## 81   81       tBodyAccJerk-mean()-X
## 82   82       tBodyAccJerk-mean()-Y
## 83   83       tBodyAccJerk-mean()-Z
## 121 121          tBodyGyro-mean()-X
## 122 122          tBodyGyro-mean()-Y
## 123 123          tBodyGyro-mean()-Z
## 161 161      tBodyGyroJerk-mean()-X
## 162 162      tBodyGyroJerk-mean()-Y
## 163 163      tBodyGyroJerk-mean()-Z
## 201 201          tBodyAccMag-mean()
## 214 214       tGravityAccMag-mean()
## 227 227      tBodyAccJerkMag-mean()
## 240 240         tBodyGyroMag-mean()
## 253 253     tBodyGyroJerkMag-mean()
## 266 266           fBodyAcc-mean()-X
## 267 267           fBodyAcc-mean()-Y
## 268 268           fBodyAcc-mean()-Z
## 345 345       fBodyAccJerk-mean()-X
## 346 346       fBodyAccJerk-mean()-Y
## 347 347       fBodyAccJerk-mean()-Z
## 424 424          fBodyGyro-mean()-X
## 425 425          fBodyGyro-mean()-Y
## 426 426          fBodyGyro-mean()-Z
## 503 503          fBodyAccMag-mean()
## 516 516  fBodyBodyAccJerkMag-mean()
## 529 529     fBodyBodyGyroMag-mean()
## 542 542 fBodyBodyGyroJerkMag-mean()
## 4     4            tBodyAcc-std()-X
## 5     5            tBodyAcc-std()-Y
## 6     6            tBodyAcc-std()-Z
## 44   44         tGravityAcc-std()-X
## 45   45         tGravityAcc-std()-Y
## 46   46         tGravityAcc-std()-Z
## 84   84        tBodyAccJerk-std()-X
## 85   85        tBodyAccJerk-std()-Y
## 86   86        tBodyAccJerk-std()-Z
## 124 124           tBodyGyro-std()-X
## 125 125           tBodyGyro-std()-Y
## 126 126           tBodyGyro-std()-Z
## 164 164       tBodyGyroJerk-std()-X
## 165 165       tBodyGyroJerk-std()-Y
## 166 166       tBodyGyroJerk-std()-Z
## 202 202           tBodyAccMag-std()
## 215 215        tGravityAccMag-std()
## 228 228       tBodyAccJerkMag-std()
## 241 241          tBodyGyroMag-std()
## 254 254      tBodyGyroJerkMag-std()
## 269 269            fBodyAcc-std()-X
## 270 270            fBodyAcc-std()-Y
## 271 271            fBodyAcc-std()-Z
## 348 348        fBodyAccJerk-std()-X
## 349 349        fBodyAccJerk-std()-Y
## 350 350        fBodyAccJerk-std()-Z
## 427 427           fBodyGyro-std()-X
## 428 428           fBodyGyro-std()-Y
## 429 429           fBodyGyro-std()-Z
## 504 504           fBodyAccMag-std()
## 517 517   fBodyBodyAccJerkMag-std()
## 530 530      fBodyBodyGyroMag-std()
## 543 543  fBodyBodyGyroJerkMag-std()
```


### The data
For both the training and the test dataset, the subject code, activity code and computed values come from corresponding rows in the different datasets as described above. 

The R script does this combination for the training and the test data and finally combines both sets for the computation of averages per activity and subject. 


### The Process

The process is completely handled and described by the given R script. 
The only preparation was to extract the data from the zip file and to move them either into the main level of the repository or one level below (train and test). 

After that preparation, the R script 
- reads the meta data regarding variables and activites,   
- selects the relevant variables,   
- reads and combines the various data files,  
- transforms the activity codes into a factor variable,  
- splits the combined file along subjects and activities   
- computes the averages of the selected variables per subject and activity  
- writes the data frame containing these averages into the repository.   



