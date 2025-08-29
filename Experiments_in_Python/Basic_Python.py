##
##    Programme:  Basic_Python.py
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

#Pacific_Labour_Force = pandas.read_csv("C:/GIT_Projects/R_Fundamentals_Training/Experiments_in_Python/SPC,DF_LABEMP,1.0+all.csv")
Pacific_Labour_Force = pandas.read_csv("C:/From BigDisk/GIT/R_Fundamentals_Training/Experiments_in_Python/SPC,DF_LABEMP,1.0+all.csv")



##
##   Pacific_Labour_Force.head() will show you the first 6 records of the dataframe.
##   Pacific_Labour_Force.tail() will show you the last 6 records of the dataframe.
##   Pacific_Labour_Force.info() will show you the structure of the dataframe
##
##   Python throws on row numbers when it prints data out. At the moment, ignore these - they're not "data" and are not
##    within the dataframe
##

print(Pacific_Labour_Force.head())
print(Pacific_Labour_Force.tail())      
print(Pacific_Labour_Force.info())      # quite useful

##   Data frames have column headings, content and variable types. For example, from the info(), 
##   the Pacific_Labour_Force data frame:
##    (1) is a data frame -  <class 'pandas.core.frame.DataFrame'>
##    (2) has 19084 observations within it
##    (3) has 36 variables within it 

##
##   Data frames can have their headings changed through passing a character vector of the same "length" 
##    as the data frame to the function "names" with the data frame as its parameter
##
print(Pacific_Labour_Force.columns)     # Not that useful

##
##    Show the Pacific_Island_Countries_and_territories column of the Pacific_Labour_Force dataframe
##
print(Pacific_Labour_Force["Pacific Island Countries and territories"].unique())

##
##    Assign the Pacific_Island_Countries_and_territories column of the Pacific_Labour_Force dataframe to a new variable called "Pacific_Labour_Force_Areas". I'm doing
##       this just to show you can work on columns and elements of dataframes
##
Pacific_Labour_Force_Areas = Pacific_Labour_Force["Pacific Island Countries and territories"]
print(type(Pacific_Labour_Force_Areas))  # <class 'pandas.core.series.Series'>
Pacific_Labour_Force_Areas.unique()

##
##    Data frame names can have spaces in them
##

Unique_Areas = Pacific_Labour_Force["Pacific Island Countries and territories"].unique()   # Find all of the unique values and assign those to a new variable :)
print(type(Unique_Areas))                # <class 'numpy.ndarray'>


##
##    You can access the rows using loc and iloc
##

print(Pacific_Labour_Force.iloc[0,:])  # the first row of the Pacific_Labour_Force dataframe. Note, the comma and brackets. R reads this as "first row, all coloums"
print(Pacific_Labour_Force.iloc[0:9,]) # the first 10 rows of the Pacific_Labour_Force dataframe. The : tells R to made a sequence from 1 to 10

Pacific_Labour_Force["Unique_ID"] = Pacific_Labour_Force.index
print(Pacific_Labour_Force.tail())      

print(Pacific_Labour_Force.iloc[:,7])                              # Python reads this as "all row, eighth" column
Another_Pacific_Labour_Force_Area = Pacific_Labour_Force.iloc[:,7] # Assign the "all row, eighth" (which should be Pacific_Island_Countries_and_territories from the str(Pacific_Labour_Force) command) to a new variable 

##
## Test to see whether the Pacific_Labour_Forces Area column from using $ is the same as the Pacific_Labour_Forces Area column from the matrix notation.
##
##   In Python, tests for equality using the double == sign. A single = sign is the same as an assignment  
##
print(Pacific_Labour_Force_Areas == Another_Pacific_Labour_Force_Area)

##
##    Put the matrix notation together to select elements or groups of elements
##
print(Pacific_Labour_Force.iloc[79,4])              # the 80th row and the 5th column
print(Pacific_Labour_Force.iloc[24:29,0:3])         # rows 25:30 of columns 1:3
print(Pacific_Labour_Force.iloc[[0,2,4,6],  [0,2]]) # rows 1,3,5 and 7 of columns 1 and 3
         

##
##    Subsetting through matrix notation
##
##
##    With matrix notation, what's ACTUALLY happening is R "tests" each row / column value against the data.
##       You can use this to subset data
##
print(Pacific_Labour_Force["Pacific Island Countries and territories"] == "Solomon Islands") # this tests whether the Pacific_Island_Countries_and_territories variable in the Pacific_Labour_Force data frame equals "Solomon Islands"
                                                                                              # and returns either TRUE or FALSE for each observations in the data frame
                                                                                              
print(Pacific_Labour_Force[Pacific_Labour_Force["Pacific Island Countries and territories"] == "Solomon Islands"]) # Putting the same test as a row manipulation will return every observation where the value is true

SB = Pacific_Labour_Force[Pacific_Labour_Force["Pacific Island Countries and territories"] == "Solomon Islands"] 

print(SB)
print(SB.info())


Pacific_Island_Proportion_Data = Pacific_Labour_Force[Pacific_Labour_Force["Indicator"] == "Proportion of persons by professional status"]

Pacific_Island_Proportion_Data = Pacific_Island_Proportion_Data[Pacific_Island_Proportion_Data["Labour and employment status"] == "Unemployed"]
Pacific_Island_Proportion_Data = Pacific_Island_Proportion_Data[Pacific_Island_Proportion_Data["Age"]  == "All ages"]
Pacific_Island_Proportion_Data = Pacific_Island_Proportion_Data[Pacific_Island_Proportion_Data["Sex"]  != "Total"]

print(Pacific_Island_Proportion_Data)

##
##    We can add multiple subsetting conditions together:  "and" is &
##                                                         "or"  is |  (shift + "\") also known as the "pipe" character
##
Same_Extract = Pacific_Labour_Force[(Pacific_Labour_Force["Indicator"] == "Proportion of persons by professional status") & 
                                    (Pacific_Labour_Force["Labour and employment status"] == "Unemployed")                & 
                                    (Pacific_Labour_Force["Age"]  == "All ages")                                          & 
                                    (Pacific_Labour_Force["Sex"]  != "Total")]
print(Same_Extract)

##
##    Note the dataframe matrix notation: Pacific_Labour_Force[ <row operations in here> , <column operations in here>]
##
##    where <row operations in here> are tests that produce TRUE or FALSE results
##

##
##    Subsetting can be combined together with function operations
##
print(Same_Extract["OBS_VALUE"].max())
print(Same_Extract[Same_Extract["OBS_VALUE"] == Same_Extract["OBS_VALUE"].max()])


##
## String operations use the concatenate function: c() and the %in% operator for many strings, or == for one string
##
print(Same_Extract[Same_Extract["Pacific Island Countries and territories"] == "Kiribati"])

Specific_Countries = Same_Extract["Pacific Island Countries and territories"].isin({"Kiribati", "Tuvalu", "Palau"})
print(Specific_Countries)

##
## String operators become particularly useful: There's a whole heap of these, and they're well worth looking at 
##

Places_with_Islands_in_Name = Same_Extract[Same_Extract["Pacific Island Countries and territories"].str.contains("Islands")]  # Case sensitive test
print(Places_with_Islands_in_Name)
   
####
####     LAST BUT NOT LEAST - INTRODUCTION TO LOOPS
####
####
##
##    Most of the time you'll want to "do" something with the data - like recode it, or
##       make a loop that does something with some or all of the observations one at a time.
##
##    Loops are the real reason you programme computers - they do most of the heavy-lifting grunt
##       work. For example, looping through each DHB and undertaking analysis on specific things.
##
##
##
##    THE main point about loops is they produce an ITERATOR variable, which changes in a specific way every time the loop cycles over again
##
##    "For" loops are loops which loop through a VECTOR of values, for example...
##       they can count forwards...
##
for Counting_Variable in range(0,10):
    print(Counting_Variable)
##
##    ... or backwards
##
for Counting_Variable in range(10,0,-1):
    print(Counting_Variable)

# ##
# ##    ... or across an integer vector
# ##
for Counting_Variable in {1,3,5,7,9}:
    print(Counting_Variable^2)

# ##
# ##    ... or across a character vector
# ##
for Counting_Variable in {"Peaches","Apples","Bunnies","Carrots","Butter"}:
    print(Counting_Variable)

# ##
# ##    ... or mixed vector (take a look at what R outputs - the integer is "coerced" into a string)
# ##
for Counting_Variable in {1,"Peaches","Bunnies",3,"Butter"}:
    print(Counting_Variable)

# ##
# ##    We'll just leave it at that at the moment, but we'll use loops more extensively later
# ##



##
##    And we're done
##
