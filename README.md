# Getting and Cleaning Data Project



#Installation

* Create a directory for this project.
* Download the script run_analysis.R to your created directory
* Download the raw data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.  Unzip it and put the upzipped files in the same directory with the script.


#Dependencies

The script run_analysis.R depends on the library reshape2, so you need to install this package before you can run it.

#Running the analysis

* Change the working directory in R to the directory containg the script and data (ref. Installation section).
* Source the script 'run_analysis.R' in R by the command 'source("run_analysis.R")'

The execute of this script will generate a tidy data set (namely 'tidydata.txt') (please refer to 'Codebook' for its descriptions)

#Codebook

Information about the tidy data set is provided in CodeBook.md.

#Code

The code contains detailed commments explaining the steps in which the original data was transformed to tidydata.txt