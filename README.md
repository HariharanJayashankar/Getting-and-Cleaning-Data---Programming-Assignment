# Getting and Cleaning Data-Programming Assignment

# Background

This assignment involved merging a couple of data tables from the UCI HAR dataset. 

# Usage of Script

There is a script attached named run_analysis.R. I will now briefly describe how to use it and how it works

First, make sure to set your working directory in an appropriate in R before you run this. You need not have downloaded the dataset
beforehand for this to work. Since all the downloaded files will be placed in your working directory, I suggest you make a new folder where ever you are comfortable to get this going

Initially the script downloads the dataset and unzips. Before doing each of these, it checks if the data is present at the location already, in which case it wont download it. Then it checks if the unzipped files are present at the location, and if they are it doesn't unzip the file either.


Next the script imports the relevant files from the unzipped folder. The objects "labels" and "features" are first downloaded. These aren't used immediately, but are used a bit later to help with naming.

We subset the "features" object and create a new object - "features_sub", to include only the relevant observations, that is those with "mean" and "std" in them. This is done using the grep command. "features_sub" includes only the observation numbers (for example the 1st, 3rd, 4th, ith observations) for which the relevant observations exist. Based on this we create "featrues_req" which is nothing but the character vector which has the feature names we want. 

We do the above so that it makes our lives easier later. "features_sub" can be easily used to subset the training and test data to get what we want and the "features_req" can help us name our final dataset better.

We then move on to importing the training and testing datasets. There are three tables for each. These are imported with the appropriate names. We also subset these to include only those which we need based on "features_sub". For both the training and test data, we first column bind all three relevant tables for each (thus creating full test and training datasets), and then we row bind the training and test datasets to create the full dataset.

We use gsub to clean up the observation names for the object "features_req". Then we assign column names to our dataset - "fulldata".


Finally, to work towards the tidy dataset we first make the activity variable in "fulldata" a factor variable with labels.

We then use a combination of group_by and summarise_each from the dplyr package to get average values for each activity and subject.

Finally, the dataset created is exported to a txt document called "tidy_averages.txt" using write.table.
