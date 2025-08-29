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
pandas.options.display.max_rows = 1000
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


###
###      FIRST TRICK - AGGREGATION / SUMMERISATION
###

##
##    Subset the data for illustrative purposes only
##
Cut_Down_Dataset = Pacific_Labour_Force[(Pacific_Labour_Force["Indicator"] == "Number of persons by professional status") &
                                        (Pacific_Labour_Force["Labour and employment status"] == "Unemployed") &
                                        (Pacific_Labour_Force["Age"]  != "All ages") &
                                        (Pacific_Labour_Force["Sex"]  != "Total")]
print(Cut_Down_Dataset.head())

##
##  Group by the variables you want to aggregate by, then select the variables you wanted aggregated by
##
##
Pacific_Unemployed = Cut_Down_Dataset.groupby(['Sex', 
                                               'Age', 
                                               'Pacific Island Countries and territories',
                                               'TIME_PERIOD',
                                               'Urbanization', 
                                               'Labour and employment status',
                                               'Disability'],
                                               as_index = False,
                                               sort     = True)["OBS_VALUE"].aggregate("sum")

             
print(Pacific_Unemployed.head())  #  Show the territorial location authority area Pacific_Labour_Force totals

##
##      Not so easy to do this type of mapping on the fly
##
Cut_Down_Dataset["With_Island_in_Name"] = Cut_Down_Dataset['Pacific Island Countries and territories'].str.contains("Islands")
Cut_Down_Dataset.loc[Cut_Down_Dataset["With_Island_in_Name"] == True,  "With_Island_in_Name"] = "Has Island In Name"
Cut_Down_Dataset.loc[Cut_Down_Dataset["With_Island_in_Name"] == False, "With_Island_in_Name"] = "Does not have Island in Name"


Pacific_Unemployed = Cut_Down_Dataset.groupby(['Sex', 
                                               'Age', 
                                               'TIME_PERIOD',
                                               'Urbanization', 
                                               'Labour and employment status',
                                               'With_Island_in_Name'],
                                               as_index = False,
                                               sort     = False)["OBS_VALUE"].aggregate(["max","quantile","min"])

             
print(Pacific_Unemployed.head())  #  Show the territorial location authority area Pacific_Labour_Force totals
print(Cut_Down_Dataset[(Cut_Down_Dataset["Sex"]                                      == "Female") &
                       (Cut_Down_Dataset["Pacific Island Countries and territories"] == "Nauru") &
                       (Cut_Down_Dataset["TIME_PERIOD"]                              == 2011)])
###
###      SECOND TRICK - MAKING A DATAFRAME WIDE
###
##
##   Making a data frame "wide": use this when you want to take a variable and turning its values into separate columns
##
Nauru_Women_Only = Pacific_Labour_Force[(Pacific_Labour_Force["Indicator"]    == "Proportion of persons by professional status") &
                                        (Pacific_Labour_Force["Age"]          != "All ages") &
                                        (Pacific_Labour_Force["Urbanization"] == "National") &
                                        (Pacific_Labour_Force["Sex"]          == "Female") &
                                        (Pacific_Labour_Force["Pacific Island Countries and territories"] == "Nauru")]
                                    
print(Nauru_Women_Only.head())


Nauru_Women_Only_Wide = Nauru_Women_Only.pivot_table(index = ["Labour and employment status", "TIME_PERIOD"],
                                                     columns = ["Age"],
                                                     values = ["OBS_VALUE"],
                                                     aggfunc='first').reset_index()

print(Nauru_Women_Only_Wide)
print(Nauru_Women_Only_Wide.info())
##
##      Meditate on this - what a annoying situation!
##
Nauru_Women_Only_Wide.columns = [' '.join(col).strip() for col in Nauru_Women_Only_Wide.columns.values]
print(Nauru_Women_Only_Wide.info())

###
###      THIRD TRICK - MAKING A DATAFRAME LONG
###
##
##   Making a data frame "long": use this when someone has sent you a file that's not in tidy format, and you want to tidy it
##
Nauru_Women_Only_Long = Nauru_Women_Only_Wide.melt(id_vars = ["Labour and employment status","TIME_PERIOD"])   
print(Nauru_Women_Only_Long)
print(Nauru_Women_Only_Long.info())

Standard_Population = Pacific_Labour_Force[(Pacific_Labour_Force["Indicator"]    == "Proportion of persons by professional status") &
                                           (Pacific_Labour_Force["Age"]          != "All ages") &
                                           (Pacific_Labour_Force["Urbanization"] == "National") &
                                           (Pacific_Labour_Force["Sex"]          != "Total") &
                                           (Pacific_Labour_Force["Labour and employment status"] == "All labour and employment statuses")]
Standard_Population = Standard_Population.groupby(['Sex', 
                                                   'Age', 
                                                   'Disability'],
                                                   as_index = False,
                                                   sort     = False)["OBS_VALUE"].aggregate(["mean"])

# ##
# ##    That's the "macro" population structure.
# ##       Now apply the "micro" employment proportions to this common base - note I'm estimating a mean because of the different years
# ##
Country_Level_Employment_Structure =  Pacific_Labour_Force[(Pacific_Labour_Force["Indicator"]     == "Proportion of persons by professional status") &
                                                           (Pacific_Labour_Force["Age"]           != "All ages") &
                                                           (Pacific_Labour_Force["Urbanization"]  == "National") &
                                                           (Pacific_Labour_Force["Sex"]           != "Total") &
                                                           (Pacific_Labour_Force["Labour and employment status"].isin(["Employed", "Unemployed", "Outside Labour Force"]))]
                                                           
Country_Level_Employment_Structure = Country_Level_Employment_Structure.groupby(['Sex', 
                                                                                 'Age', 
                                                                                 'Pacific Island Countries and territories',
                                                                                 'Labour and employment status',
                                                                                 'Disability'],
                                                                                 as_index = False,
                                                                                 sort     = False)["OBS_VALUE"].aggregate(["mean"])  
Country_Level_Employment_Structure["mean"] = Country_Level_Employment_Structure["mean"]/100

print(Country_Level_Employment_Structure)
                                            # aggregate(list(Proportions = OBS_VALUE/100),
                                                      # list(Sex = Sex,
                                                           # Age = Age,
                                                           # Country = Pacific_Island_Countries_and_territories,
                                                           # Labour_and_employment_status = Labour_and_employment_status,  # DROP Out this indicator so we can see whether the data sums up
                                                           # Disability = Disability),
                                                    # mean, 
                                                    # na.rm = TRUE))      
# ##
# ##    Still sum up to 1? - Yep, good enough for me
# ##
# Country_Level_Employment_Structure <- reshape2::dcast(Country_Level_Employment_Structure,
                         # Country + Age + Disability + Sex ~  Labour_and_employment_status,
                         # value.var = c("Proportions"))       
                         
# Country_Level_Employment_Structure <- reshape2::melt(Country_Level_Employment_Structure,           
                        # id.vars = c("Country", "Age", "Disability", "Sex")) 
                                       
# Country_Level_Employment_Structure$value[is.na(Country_Level_Employment_Structure$value)] <- 0

# Check <- reshape2::dcast(Country_Level_Employment_Structure,                                   
                         # Country + Age + Disability + Sex ~  variable,
                         # value.var = c("value")) 

# Check$Total <- Check$Employed + Check$`Outside Labour Force` + Check$Unemployed

# ##
# ##    Now, apply these "micro" level breakdowns at the country level, to the standard population of the pacific 
# ##       to standardise employment using a merge
# ##
# Standardised_Employment_Estimates <- merge(Country_Level_Employment_Structure,
                                           # Standard_Population,
                                           # by = c("Age", "Disability", "Sex"))
                                           
# Standardised_Employment_Estimates$Number_of_Persons <- Standardised_Employment_Estimates$value * Standardised_Employment_Estimates$Total


# Standardised_Employment_Aggregates <-  with(Standardised_Employment_Estimates,
                                            # aggregate(list(Number_of_Persons = Number_of_Persons),
                                                      # list(Country = Country,
                                                           # Labour_and_employment_status = variable),
                                                    # sum, 
                                                    # na.rm = TRUE))    


                                     

##
##    And we're done
##
