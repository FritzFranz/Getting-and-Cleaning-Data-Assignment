---
title: "Readme"
author: "FF, Getting and Cleaning Data - Course Project Github repo"
date: "Thursday, August 14, 2014"
output: html_document
---

This file explains the content of this Github repository


**raw data as provided for the assignment**:

* features.txt - giving the names of the variables

* features_info.txt - providing an overall description of the input data
    
* activity_labels.txt - providing the legend of activity codes 

* sub-directories /test and /train with subject data, activity data and measurements 


**R script: run_analysis.R**:
This script reads all the input data according to the given directory structure, selects the variables providing mean() and std() values, 
combines the test and training data into a combined dataset.
For storage reasons, this combined set has not been written out. 

Finally the script computes the "tidy" output dataset as described below. 


**The output dataset** contains the averages per subject and activities and writes out the dataset "avg_per_subject_and_activity.txt".
 
