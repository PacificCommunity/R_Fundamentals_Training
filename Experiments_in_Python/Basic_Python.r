##
##    Programme:  New_Zealand_Production_Function.r
##
##    Objective:  Now all of the InfoShare data has been read in, lets try estimating a production function
##                as an error correction model, based on constant price GDP, Capital and Labour.
##
##                There's a couple of issues: 
##                1. The Capital Stock measure is annual, so I'll take the spline to interpolate the quarters.
##                   For the last year, I'll extrapolate it out by GFKF.
##
##                2. The Quarterly Employment Survey labour measure is quarterly actuals, which will need seasonally
##                   adjusted to match with the SA GDP measure.
##
##                3. The industries are bound to not be on the same definition.
##
##                4. There's no gaurantee that the macro level function will look anything like the micro level
##                   industry functions, or share similar short run dynamics.
##
##    Author:     James Hogan, started 27 June 2025
##
##
   ##
   ##    Clear the memory
   ##
      rm(list=ls(all=TRUE))
   ##
   ##    Load data from somewhere
   ##
      load("Data_Intermediate/ConstantPrice_SA_Qtr_GDP_Published20240331.rda")
      load("Data_Intermediate/ConstantPrice_Actual_Annual_CapitalStock_Published20240331.rda")
      load("Data_Intermediate/ConstantPrice_SA_Qtr_GDP_Published20240331.rda")
                     
   ##
   ## Step 1: Check out the Industries and move each data source to a common industry definition
   ##




   ##
   ## Step 2: Interpolate the annual capital stock into a quarterly measure. I'll use these as "seaonally adjusted"
   ##
   
   
   ##
   ## Step 3: Seasonally adjust the quarterly QES measure
   ##

   ##
   ## Step 4: Combine the data sources together into a common industry and time period, and save. This will become our
   ##         modelling data set.
   ##





   ##
   ## Save files our produce some final output of something
   ##
      save(xxxx, file = 'Data_Intermediate/xxxxxxxxxxxxx.rda')
      save(xxxx, file = 'Data_Output/xxxxxxxxxxxxx.rda')
##
##    And we're done
##
