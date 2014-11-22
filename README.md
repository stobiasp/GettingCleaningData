GettingCleaningData
===================

Coursera Class: Getting and Cleaning Data

Overview of Analysis Script
The source file named run_analysis.R purpose is to take a data set from multiple data sets found at the 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones web site. These data are measurements from participants'
phones while they are doing various activities. 

This anaysis requires the user to save the following files into their working directory
"X_train.txt","features.txt","X_test.txt","subject_train.txt","y_test.txt","y_train.txt"

THE SCRIPT WILL FAIL IF THE FILES ARE NOT LOCATED IN THE USER'S WORKING DIRECTORY

The process will take these files and save out a new data set called tidyDatafinal.txt which is a pipe delimited file 
with the following fields:

<b>CODE BOOK</b>
<b>"Activity Name"</b>: A description of the activity <br/>
<b>"Subject ID"</b>: The participant's id  <br/>
<b>"Avg. Metric Value"</b> : an average value of a participant during a specific activity for a specific measurement  <br/>
<b>"Metric Name"</b>:  The name of the measurement.  <br/>
A background on these measurements can be found in the source data in a file named : features_info.txt

