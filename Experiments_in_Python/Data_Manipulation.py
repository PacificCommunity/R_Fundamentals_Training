##
##    Programme:  Data_Manipulation.py
##
##    Objective:  Learn how to do all those things I teach other people to do in R
##                  https://www.w3schools.com/python/python_casting.asp
##
##                Functionality installed from the command prompt:
##                    python -m pip install Geopandas pandas geodatasets matplotlib
##
##    Author:     James Hogan, started 28 August 2026
##
##

##
##  load some functionality
##
import pandas
pandas.options.display.max_columns = None
pandas.options.display.width = 1500

##
##    Load data from somewhere
##

##
## Step 1: Read in data from a csv.
##    Reading csv is through either the read.table command or the read.csv command.
##    Find out a little bit about the syntax for each, but bring up the help documentation
##    through putting a question mark in front of the command you want more information on.
##

Pacific_Labour_Force = pandas.read_csv("C:/GIT_Projects/R_Fundamentals_Training/Experiments_in_Python/SPC,DF_LABEMP,1.0+all.csv")

##
## Manipulate the data. Have you read the Tidy Data pdf yet?
##
##    In my whole entire 30 year working career, I only really know 5 data cleaning / manipulation tricks.
##
##    The bigest manipulation tricks we use are:
##       (1) Aggregation / summarisation
##       (2) Making a data frame "wide": using one of the variables to create new columns
##       (3) Making a data frame "long": taking all of the columns of a dataframe and turning them into a variable
##       (4) Subsetting the dataset
##       (5) Merging datasets
##
##    For these tricks to work, the data needs to be tidy. This is also the main point of departure between "old R" and "new R".
##    These 5 manipulations are used repeatedly and together to create tidy data ready for data analysis, visualisation and reporting.
##







##
##    And we're done
##
