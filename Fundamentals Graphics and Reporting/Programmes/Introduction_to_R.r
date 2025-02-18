##
##    Programme:  Introduction_to_R.r
##
##    Objective:  Part of R Fundamentals for Reading, Manipulating and Writing
##                data in R.
##
##                The main objective of this programme is to introduce you to R data frames,
##                and some basic data manipulation techniques. The output of the
##                process will be a data frame and a csv of regional tax data.
##
##                In the Documents directory are:
##                  (1) "Tidy Data" an article by Hadlee Wickham on what tidy data is,
##                      why you want it and how to make it. Have a read of that, because it
##                      explains what a fundamental principal of data analysis.
##
##                  (2) "Business Intelligence", a presentation I cooked up the role of an Analysis team.
##                      Analytical teams sit between IT-land and Policy World. You use IT tools and 
##                      Techniques, but you respond to policy world drivers.  
##                      To do this, you have to programme R like a developer.
##
##                There are two "flavours" of R: traditional R, which I'm going to teach you
##                and Tidy R, built around Hadlee Wickham's TidyVerse
##                https://vita.had.co.nz/papers/tidy-data.html
##
##                The langauges are fundamentally different, and they offer you choice for 
##                how to run your code.
##
##
##    Plan of  :  In this programme, we are going to:
##    Attack   :    (1) Read in some Pacific_Labour_Force data from a CSV file.
##                  (2) Finding out how to get R help.
##
##    Author:     James Hogan, FAME, 12 February 2025
##
##
   ##
   ##    Clear the memory
   ##
      rm(list=ls(all=TRUE))
                     
   ##
   ## Step 1: Read in data from a csv.
   ##    Reading csv is through either the read.table command or the read.csv command.
   ##    Find out a little bit about the syntax for each, but bring up the help documentation
   ##    through putting a question mark in front of the command you want more information on.
   ##
      ?read.csv
      ##    
      ##    The syntax for read.csv is:
      ##
      ##    read.csv(file, 
      ##             header = TRUE, 
      ##             sep = ",", 
      ##             quote = "\"",
      ##             dec = ".", 
      ##             fill = TRUE, 
      ##             comment.char = "", ...)
      ##
      ##    The help file shows that a few options have default values selected like "header = TRUE", which means the command
      ##    is expecting to read column names as the first line of the file. These options can be explicitly overwritten.  
      ##
      ##    What is "returned" from the command is: "A data frame (data.frame) containing a representation of the data in the file."
      ##    Lets read in the Pacific_Labour_Force data in the Data_Raw directory into a data frame called "Pacific_Labour_Force"
      ##       
      ##    R is case sensitive - you have to get the command exactly right: Read.csv and read.csv are not the same to R.
      ##    Same deal with variables: Pacific_Labour_Force and Pacific_Labour_Force are two separate variables in R.
      ##    Normally, I capitalise the variable names, because I think it just looks better.
      ##
      ##    Two other formating changes help with this codes readiblility: my COMPREHENSIVE use of comments to tell a word story
      ##    all the way through the programme, and my ordered indentiting. Both improve the readiblility of the code.
      ##
         ##
         ##    Introduction to Dataframes
         ##       Dataframes are the most common form of data representation in R. They are "square" in the sense that they
         ##       have a number of variables of different types, each of which has exactly the same number of observations.
         ##
         ##    In the code below, I've called the "read.csv" command, told it where (relative to the root directory) is the 
         ##       data I want to read in, and "assigned" the read in dataframe a name "Pacific_Labour_Force" using the <- command.
         ##
         ##
         ##    The Labour Force dataset came from here: https://stats.pacificdata.org/vis?fs[0]=Topic%2C0%7CSocial%23SOC%23&pg=0&fc=Topic&snb=4&tm=labour&hc[Labour%20and%20employment%20status]=&df[ds]=ds%3ASPC2&df[id]=DF_LABEMP&df[ag]=SPC&df[vs]=1.0&dq=A..LABEMPRF..._T._T.&pd=2011%2C&to[TIME_PERIOD]=false&ly[rw]=GEO_PICT%2CLABEMP_STATUS%2CSEX%2CAGE%2CTIME_PERIOD
         ##

            Pacific_Labour_Force <- read.csv(file = "Data_Raw/SPC,DF_LABEMP,1.0+all.csv")
            
         ##
         ##   head(Pacific_Labour_Force) will show you the first 6 records of the dataframe.
         ##   tail(Pacific_Labour_Force) will show you the last 6 records of the dataframe.
         ##   str(Pacific_Labour_Force) will show you the structure of the dataframe
         ##
         ##   R throws on row numbers when it prints data out. At the moment, ignore these - they're not "data" and are not
         ##    within the dataframe
         ##
            head(Pacific_Labour_Force)
            tail(Pacific_Labour_Force)
            str(Pacific_Labour_Force)


         ##
         ##   Data frames have column headings, content and variable types. For example, from the str(), 
         ##   the Pacific_Labour_Force data frame:
         ##    (1) is a data frame -  'data.frame'
         ##    (2) has 19084 observations within it
         ##    (3) has 36 variables within it (then number of columns is the data frame's "length" - which is a bit confusing):
         ##
         ##    "Data" in all programming langauges has a "type" and dimension.  For example
         ##    Data <- 1       will make a scalar variable of type "num"
         ##    Data <- "1"     will make a scalar variable of type "chr"
         ##    Data <- 1:10    will make a vector variable of type "num" and dimension 10
         ##    Data <- LETTERS will make a vector variable of type "chr" and dimension 26 (LETTERS is a built-in constant)
         ##

         ##
         ##   Data frames can have their headings changed through passing a character vector of the same "length" 
         ##    as the data frame to the function "names" with the data frame as its parameter
         ##
            names(Pacific_Labour_Force)
            
            names(Pacific_Labour_Force) = str_replace_all(names(Pacific_Labour_Force), "\\.", "_")
            names(Pacific_Labour_Force)[names(Pacific_Labour_Force) == "Unit_of_measure"] = "Unit of measure"

            names(Pacific_Labour_Force)
            head(Pacific_Labour_Force)
            
         ##
         ##    You can access the columns using $ notation
         ##
            ##
            ##    Show the Pacific_Island_Countries_and_territories column of the Pacific_Labour_Force dataframe
            ##
               Pacific_Labour_Force$Pacific_Island_Countries_and_territories 
               
            ##
            ##    Assign the Pacific_Island_Countries_and_territories column of the Pacific_Labour_Force dataframe to a new variable called "Pacific_Labour_Force_Areas". I'm doing
            ##       this just to show you can work on columns and elements of dataframes
            ##
            
               Pacific_Labour_Force_Areas <- Pacific_Labour_Force$Pacific_Island_Countries_and_territories # Assign the Pacific_Island_Countries_and_territories column in the Pacific_Labour_Force dataframe to a new variable
               str(Pacific_Labour_Force_Areas)                                                             # shows the new variable "Pacific_Labour_Force_Areas" is a character VECTOR of with 1:107 elements
               unique(Pacific_Labour_Force_Areas)                                                          # shows the unique values of the Pacific_Labour_Force_Areas vector - turns out to only have 4 UNIQUE elements
               Unique_Areas <- unique(Pacific_Labour_Force_Areas)                                          # Find all of the unique values and assign those to a new variable :)
               str(Unique_Areas)                                                                           # "Unique_Countries" is a character VECTOR of with 1:4 elements

            ##
            ##    Data frame names can have spaces in them, but to access them using $ notation, they need to be enclosed on a special character `
            ##       (` is the key immediately to the left of the number 1 on the main keys of the keyboard)
            ##
               Pacific_Labour_Force$Unit of measure
               Pacific_Labour_Force$`Unit of measure`

            ##
            ##    With later versions of R, this can also be a ", but might cause issues when sharing code between organisations
            ##
               Pacific_Labour_Force$"Unit of measure"


         ##
         ##    You can access the rows using R's matrix notation of [row,col]
         ##
            Pacific_Labour_Force[1,]    # the first row of the Pacific_Labour_Force dataframe. Note, the comma and brackets. R reads this as "first row, all coloums"
            Pacific_Labour_Force[1:10,] # the first 10 rows of the Pacific_Labour_Force dataframe. The : tells R to made a sequence from 1 to 10
            1:10                        # just show what happens when you run this command.
            
         ##
         ##    You can access the columns using R's matrix notation of [row,col] notation
         ##
             Pacific_Labour_Force[,8]  #  R reads this as "all row, eighth" column
             Another_Pacific_Labour_Force_Area <- Pacific_Labour_Force[,8] # Assign the "all row, eighth" (which should be Pacific_Island_Countries_and_territories from the str(Pacific_Labour_Force) command) to a new variable 
             
            ##
            ## Test to see whether the Pacific_Labour_Forces Area column from using $ is the same as the Pacific_Labour_Forces Area column from the matrix notation.
            ##
            ##   In R, tests for equality using the double == sign. A single = sign is the same as an assignment <- 
            ##
            Pacific_Labour_Force_Areas == Another_Pacific_Labour_Force_Area
            
         ##
         ##    Put the matrix notation together to select elements or groups of elements
         ##
            Pacific_Labour_Force[80,5]                # the 80th row and the 5th column
            Pacific_Labour_Force[25:30,1:3]           # rows 25:30 of columns 1:3
            Pacific_Labour_Force[c(1,3,5,7),  c(1,3)] # rows 1,3,5 and 7 of columns 1 and 3
         
         ##
         ##    Subsetting through matrix notation
         ##
            ##
            ##    With matrix notation, what's ACTUALLY happening is R "tests" each row / column value against the data.
            ##       You can use this to subset data
            ##
               Pacific_Labour_Force$Pacific_Island_Countries_and_territories == "Solomon Islands"          # this tests whether the Pacific_Island_Countries_and_territories variable in the Pacific_Labour_Force data frame equals "Solomon Islands"
                                                                                                          # and returns either TRUE or FALSE for each observations in the data frame
               Pacific_Labour_Force[Pacific_Labour_Force$Pacific_Island_Countries_and_territories == "Solomon Islands",]  # Putting the same test as a row manipulation will return every observation where the value is true

            ##
            ##    If the variable you're interested in is numeric, then you can use this to select different values
            ##
               unique(Pacific_Labour_Force$Indicator)
               
               
               ##
               ##    Lets subset the data to unemployment, by gender, all ages
               ##
            
               Pacific_Island_Proportion_Data <- Pacific_Labour_Force[Pacific_Labour_Force$Indicator == "Proportion of persons by professional status",]
               
               Pacific_Island_Proportion_Data <- Pacific_Island_Proportion_Data[Pacific_Island_Proportion_Data$Labour_and_employment_status == "Unemployed",]
               Pacific_Island_Proportion_Data <- Pacific_Island_Proportion_Data[Pacific_Island_Proportion_Data$Age  == "All ages",]
               Pacific_Island_Proportion_Data <- Pacific_Island_Proportion_Data[Pacific_Island_Proportion_Data$Sex  != "Total",]
               
               Pacific_Island_Proportion_Data

               ##
               ##    We can add multiple subsetting conditions together:  "and" is &
               ##                                                         "or"  is |  (shift + "\") also known as the "pipe" character
               ##
               Same_Extract <- Pacific_Labour_Force[(Pacific_Labour_Force$Indicator == "Proportion of persons by professional status") &
                                                    (Pacific_Labour_Force$Labour_and_employment_status == "Unemployed") &
                                                    (Pacific_Labour_Force$Age  == "All ages") &
                                                    (Pacific_Labour_Force$Sex  != "Total"),]
               Same_Extract
               
               
               
               ##
               ##    Note the dataframe matrix notation: Pacific_Labour_Force[ <row operations in here> , <column operations in here>]
               ##
               ##    where <row operations in here> are tests that produce TRUE or FALSE results
               ##

            ##
            ##    Subsetting can be combined together with function operations
            ##
               max(Same_Extract$OBS_VALUE)
               Same_Extract[Same_Extract$OBS_VALUE == max(Same_Extract$OBS_VALUE) ,]


               ##
               ## String operations use the concatenate function: c() and the %in% operator for many strings, or == for one string
               ##
                  Same_Extract[Same_Extract$Pacific_Island_Countries_and_territories == "Kiribati",]

                  Specific_Countries <- Same_Extract[Same_Extract$Pacific_Island_Countries_and_territories %in% c("Kiribati", "Tuvalu", "Tonga"),]
                  Specific_Countries


            ##
            ## String operators become particularly useful: There's a whole heap of these, and they're well worth looking at 
            ##
               ?stringr
               ?str_detect ## From the help text:
                           ##    Value
                           ##     A logical vector.
                           ##
                           ## AH - a logical vector is exactly what we need for subsetting!!

               Places_with_Islands_in_Name <- Same_Extract[str_detect(Same_Extract$Pacific_Island_Countries_and_territories, "Islands"),]  # Case sensitive test
               Places_with_Islands_in_Name
               
               
               
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
            for(Counting_Variable in 1:10)
            {
               print(Counting_Variable)
            }
         ##
         ##    ... or backwards
         ##
            for(Counting_Variable in 10:1)
            {
               print(Counting_Variable)
            }
         ##
         ##    ... or across an integer vector
         ##
            for(Counting_Variable in c(1,3,5,7,9))
            {
               print(Counting_Variable^2)
            }
         ##
         ##    ... or across a character vector
         ##
            for(Counting_Variable in c("Peaches","Apples","Bunnies","Carrots","Butter"))
            {
               print(Counting_Variable)
            }
         ##
         ##    ... or mixed vector (take a look at what R outputs - the integer is "coerced" into a string)
         ##
            for(Counting_Variable in c(1,"Peaches","Bunnies",3,"Butter"))
            {
               print(Counting_Variable)
            }
      ##
      ##    We'll just leave it at that at the moment, but we'll use loops more extensively later
      ##

               

##
##    And we're done
##
