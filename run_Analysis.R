# run_analysis.R
# Getting and Cleaning data assignment for wearable computing
#
# Goals
# - create a tidy data set 
# - create a codebook 


### getting data 
list.files(path="./train")
list.files(path="./train/Inertial Signals")

### getting data 
list.files(path="./test")
list.files(path="./train/Inertial Signals")

### Activitiy labels are 
# 1 WALKING
# 2 WALKING_UPSTAIRS
# 3 WALKING_DOWNSTAIRS
# 4 SITTING
# 5 STANDING
# 6 LAYING

### Features.txt contains names of 561 variables 

features = read.table("features.txt", header=F, colClasses=c("integer", "character"))
head(features)
dim(features)
names(features) = c("seq", "varname")
head(features)

name1 = sub("/(/)","$$", features$varname)
head(name1)

# double backslash needed to have one backslash in the expression 
select_mean = grep('+-mean\\(\\)*', features$varname)    # numbers selected 
select_std = grep("*-std\\(\\)*", features$varname)

select = unique(c(select_mean, select_std))

features.sel = features[select,]
features.sel
dim(features.sel)     ## 66 variables remain 

#----------------------------------------------
# read activity labels
#-----------------------------------------------

activity =  read.table("activity_labels.txt", header=F, colClasses=c("integer", "character"))
activity      # 1st column = number, 2nd column = text 

#-------------------------------
# read subject test data 
#-------------------------------
subject.test = read.table("./test/subject_test.txt", header=F)
dim(subject.test)
head(subject.test)
table(subject.test)    # counts per subject 
summary(subject.test)  # values between 2 and 24 

#-------------------------------
# read activity ids for test 
#-------------------------------
y.test = read.table("./test/y_test.txt", header=F)
dim(y.test)
table(y.test)

#----------------------------------------
# read 561 variables for each test case 
#----------------------------------------
X.test = read.table("./test/X_test.txt", header=F,colClasses=rep("numeric",561))
dim(X.test)
head(X.test)
class(X.test)
class(X.test$V557)

#--------------------------
# same for train - 7352 obs 
#---------------------------
subject.train = read.table("./train/subject_train.txt", header=F)
dim(subject.train)
head(subject.train)
table(subject.train)    # counts per subject 
summary(subject.train)  # values between 2 and 24 

# activity codes
y.train = read.table("./train/y_train.txt", header=F)
dim(y.train)
table(y.train)

# measurements
X.train = read.table("./train/X_train.txt", header=F,colClasses=rep("numeric",561))
dim(X.train)
class(X.train)
class(X.train$V557)

# inertia details
body_acc_x_train = read.table("./train/Inertial Signals/body_acc_x_train.txt", header=F)
dim(body_acc_x_train)

# create training set with subject, activity, 

train = cbind(subject.train[[1]], y.train[[1]], X.train[,select])
dim(train)
head(train)

class(train)
nt = c("Subject", "Activity", features.sel[,2])
names(train) = nt
head(train)
     
# combine test data 
test = cbind(subject.test[[1]], y.test[[1]], X.test[,select])
dim(test)
names(test) = nt  # same names as for train 
head(test)





