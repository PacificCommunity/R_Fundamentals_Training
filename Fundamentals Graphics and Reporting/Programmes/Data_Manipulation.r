##
##    Programme:  Data_Manipulation.r
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
##                http://statseducation.com/Introduction-to-R/modules/tidy%20data/tidy-data/
##
##                The langauges are fundiamentally different, and they offer you choice for 
##                how to run your code.
##
##
##    Plan of  :  In this programme, we are going to:
##    Attack   :    (1) Read in some Pacific_Labour_Force data from a CSV file
##                  (2) Manipulate the data in R to get it into a usable form
##                  (3) Output the usuable data to a csv
##
##    Author:      James Hogan, FAME, 12 February 2025
##
##
   ##
   ##    Clear the memory
   ##
      rm(list=ls(all=TRUE))
   ##
   ##    Load in some colours, functions 
   ##
      source("R/themes.r")
                     
      ##
      ##    Read in the data from last week
      ##
         Pacific_Labour_Force <- read.csv(file = "Data_Raw/SPC,DF_LABEMP,1.0+all.csv")
         
         names(Pacific_Labour_Force) = str_replace_all(names(Pacific_Labour_Force), "\\.", "_") # Clean up the dataframe column labels

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
   ##    I'm going to teach the "old" R.  Here's a link to "new R": https://r4ds.had.co.nz/tidy-data.html
   ##
   ##    These 5 manipulations are used repeatedly and together to create tidy data ready for data analysis, visualisation and reporting.
   ##
      

###
###      FIRST TRICK - AGGREGATION / SUMMERISATION
###
      ##
      ##    Aggregation: I use the aggregation function which looks like this:
      ##
      ##   <Output_Dframe> <- with(<Input_Dframe>,                                                 # "with" the input dataframe
      ##                          aggregate(list(<new_measure_var1> = <old_measure_var1>,          #  "aggregate" the following input variables and 
      ##                                         <new_measure_var2> = <old_measure_var2>,          #     rename them to new variables names
      ##                                         <new_measure_var3> = <old_measure_var3>),         #
      ##                                    list(<new_dimension_var1> = <old_dimension_var1>,      #  across these dimensions in the input variable
      ##                                         <new_dimension_var2> = <old_dimension_var2>,      #
      ##                                         <new_dimension_var3> = <old_dimension_var3>),     #
      ##                                  sum,                                                     #  "sum" the variables 
      ##                                  na.rm = TRUE))                                           #  remove all non-existant cells
      ##
      
         ##
         ##    Subset the data for illustrative purposes only
         ##
            Cut_Down_Dataset <- Pacific_Labour_Force[(Pacific_Labour_Force$Indicator == "Number of persons by professional status") &
                                                     (Pacific_Labour_Force$Labour_and_employment_status == "Unemployed") &
                                                     (Pacific_Labour_Force$Age  != "All ages") &
                                                     (Pacific_Labour_Force$Sex  != "Total"),]
         
         
            Pacific_Unemployed <- with(Cut_Down_Dataset,
                                   aggregate(list(OBS_VALUE = OBS_VALUE),
                                             list(Sex = Sex,
                                                  Age = Age,
                                                  Pacific_Island_Countries_and_territories = Pacific_Island_Countries_and_territories,
                                                  TIME_PERIOD = TIME_PERIOD,
                                                  Urbanization = Urbanization,
                                                  Labour_and_employment_status = Labour_and_employment_status,
                                                  Disability = Disability),
                                           sum, 
                                           na.rm = TRUE))
                                                    
            Pacific_Unemployed  #  Show the territorial location authority area Pacific_Labour_Force totals
         
         ##
         ##    We don't need to keep the original variable names if we don't want to...
         ##
            Pacific_Unemployed <- with(Cut_Down_Dataset,
                                            aggregate(list(Number_Unemployed = OBS_VALUE),
                                                         list(Sex = Sex,
                                                              Age = Age,
                                                              Country = Pacific_Island_Countries_and_territories,
                                                              Year = TIME_PERIOD,
                                                              Indicator = Indicator,
                                                              Urbanisation = Urbanization,
                                                              Labour_and_employment_status = Labour_and_employment_status,
                                                              Disability = Disability),
                                                    sum, 
                                                    na.rm = TRUE))
            Pacific_Unemployed
         
         
         ##
         ##    And of course, we can throw more variables in there
         ##
            Pacific_Unemployed <- with(Cut_Down_Dataset,
                                            aggregate(list(Number_Unemployed = OBS_VALUE),
                                                         list(Sex = Sex,
                                                              Age = Age,
                                                              Country = Pacific_Island_Countries_and_territories,
                                                              Year = TIME_PERIOD,
                                                              Indicator = Indicator,
                                                              Labour_and_employment_status = Labour_and_employment_status,
                                                              Disability = Disability,
                                                              Urbanisation = Urbanization,
                                                              With_Island_in_Name = ifelse(str_detect(Cut_Down_Dataset$Pacific_Island_Countries_and_territories, "Islands"), 
                                                                                           "Has Island In Name", 
                                                                                           "Does not have Island in Name")),
                                                    sum, 
                                                    na.rm = TRUE))
            Pacific_Unemployed


         ##
         ##    Other forms of summerization? Means / max / mins / ... anything you can do with a number stuff
         ##
            
            Cut_Down_Dataset <- Pacific_Labour_Force[(Pacific_Labour_Force$Indicator == "Number of persons by professional status") &
                                                     (Pacific_Labour_Force$Labour_and_employment_status == "Unemployed") &
                                                     (Pacific_Labour_Force$Age  != "All ages") &
                                                     (Pacific_Labour_Force$Urbanization  == "National") &
                                                     (Pacific_Labour_Force$Sex  != "Total"),]
         
         ##
         ##    Take out Age
         ##
            Highs_and_Lows <- with(Cut_Down_Dataset,
                                aggregate(list(Number_Unemployed = OBS_VALUE),
                                          list(Sex = Sex,
                                             #  Age = Age,
                                               Country = Pacific_Island_Countries_and_territories,
                                               Year = TIME_PERIOD,
                                               Indicator = Indicator,
                                               Labour_and_employment_status = Labour_and_employment_status,
                                               Disability = Disability,
                                               With_Island_in_Name = ifelse(str_detect(Cut_Down_Dataset$Pacific_Island_Countries_and_territories, "Islands"), 
                                                                            "Has Island In Name", 
                                                                            "Does not have Island in Name")),
                                           range, 
                                           na.rm = TRUE))
            Highs_and_Lows
            ##
            ##    Here's the data with Age in it so you can see what's happened
            ##
               Cut_Down_Dataset[(Cut_Down_Dataset$Sex     == "Female") &
                                (Cut_Down_Dataset$Pacific_Island_Countries_and_territories == "Nauru") &
                                (Cut_Down_Dataset$TIME_PERIOD    == 2011),]

         ##
         ##    Estimate Averages
         ##
            Average <- with(Cut_Down_Dataset,
                          aggregate(list(Number_Unemployed = OBS_VALUE),
                                    list(Sex = Sex,
                                       #  Age = Age,
                                         Country = Pacific_Island_Countries_and_territories,
                                         Year = TIME_PERIOD,
                                         Indicator = Indicator,
                                         Labour_and_employment_status = Labour_and_employment_status,
                                         Disability = Disability,
                                         With_Island_in_Name = ifelse(str_detect(Cut_Down_Dataset$Pacific_Island_Countries_and_territories, "Islands"), 
                                                                      "Has Island In Name", 
                                                                      "Does not have Island in Name")),
                                  mean, 
                                  na.rm = TRUE))
            Average
            
         ##
         ##    Count the total number of things within the data
         ##
         
            Cut_Down_Dataset$Count <- 1
            Count_of_Items <-  with(Cut_Down_Dataset,
                                   aggregate(list(Count = Count),
                                             list(Sex = Sex,
                                                #  Age = Age,
                                                  Country = Pacific_Island_Countries_and_territories,
                                                  Year = TIME_PERIOD,
                                                  Indicator = Indicator,
                                                  Labour_and_employment_status = Labour_and_employment_status,
                                                  Disability = Disability,
                                                  With_Island_in_Name = ifelse(str_detect(Cut_Down_Dataset$Pacific_Island_Countries_and_territories, "Islands"), 
                                                                               "Has Island In Name", 
                                                                               "Does not have Island in Name")),
                                           sum, 
                                           na.rm = TRUE))
            Count_of_Items
            
            Cut_Down_Dataset[(Cut_Down_Dataset$Sex     == "Female") &
                             (Cut_Down_Dataset$Pacific_Island_Countries_and_territories == "Nauru") &
                             (Cut_Down_Dataset$TIME_PERIOD    == 2011),]
                             
                             
###
###      SECOND TRICK - MAKING A DATAFRAME WIDE
###
      ##
      ##   Making a data frame "wide": use this when you want to take a variable and turning its values into separate columns
      ##
         Nauru_Women_Only <- Pacific_Labour_Force[(Pacific_Labour_Force$Indicator     == "Proportion of persons by professional status") &
                                                  (Pacific_Labour_Force$Age           != "All ages") &
                                                  (Pacific_Labour_Force$Urbanization  == "National") &
                                                  (Pacific_Labour_Force$Sex           == "Female") &
                                                  (Pacific_Labour_Force$Pacific_Island_Countries_and_territories == "Nauru"),]
                                            


         Nauru_Women_Only_Wide <- reshape2::dcast(Nauru_Women_Only,                                   #     What's the dataset we want to make "wide"
                                                   Labour_and_employment_status + TIME_PERIOD ~  Age, #     row variables ~ column variable. The values of the column variables are going to be new columns
                                                   value.var = c("OBS_VALUE"))                        #     What's the value to be included within the new columne?
         Nauru_Women_Only_Wide


         Nauru_Women_Only_Wide <- reshape2::dcast(Nauru_Women_Only,                                   #     What's the dataset we want to make "wide"
                                                  Age  + TIME_PERIOD ~  Labour_and_employment_status, #     row variables ~ column variable. The values of the column variables are going to be new columns
                                                  value.var = c("OBS_VALUE"))                         #     What's the value to be included within the new columne?
         Nauru_Women_Only_Wide





###
###      THSPC TRICK - MAKING A DATAFRAME LONG
###
      ##
      ##   Making a data frame "long": use this when someone has sent you a file that's not in tidy format, and you want to tidy it
      ##
         Nauru_Women_Only_Long <- reshape2::melt(Nauru_Women_Only_Wide,               #  What's the dataset we want to make "long". 
                                                 id.vars = c("Age", "TIME_PERIOD"))   #  What's the variables that are existing columns you want to keep as colomns? All other variables will be transposed
         Nauru_Women_Only_Long   #  R makes two new variables: "variable" which new has all of the column headings, and "value" which has all of the values.
  

###
###      FOURTH TRICK - SUBSETTING
###
      ##
      ##    We saw this at different stages along this training
      ##
         Nauru_Women_Only <- Pacific_Labour_Force[(Pacific_Labour_Force$Indicator     == "Proportion of persons by professional status") &
                                                  (Pacific_Labour_Force$Age           != "All ages") &
                                                  (Pacific_Labour_Force$Urbanization  == "National") &
                                                  (Pacific_Labour_Force$Sex           == "Female") &
                                                  (Pacific_Labour_Force$Pacific_Island_Countries_and_territories == "Nauru"),]
      ##
      ##    ... or ... it looks like these groups are mutually exclusive - lets check
      ##

         Women_Only <- Pacific_Labour_Force[(Pacific_Labour_Force$Indicator     == "Proportion of persons by professional status") &
                                            (Pacific_Labour_Force$Age           != "All ages") &
                                            (Pacific_Labour_Force$Urbanization  == "National") &
                                            (Pacific_Labour_Force$Sex           == "Female") &
                                            (Pacific_Labour_Force$Labour_and_employment_status %in% c("Employed", "Unemployed", "Outside Labour Force")),]

         ##
         ##    Make the employment status "wide"
         ##
            Exclusive_Wide_Check <- reshape2::dcast(Women_Only,                                   
                                                     Pacific_Island_Countries_and_territories + Age + Disability + TIME_PERIOD ~  Labour_and_employment_status,
                                                     value.var = c("OBS_VALUE")) 
                                                     
            Exclusive_Wide_Check$Total <- Exclusive_Wide_Check$Employed + Exclusive_Wide_Check$`Outside Labour Force` + Exclusive_Wide_Check$Unemployed
         ##
         ##    ... Mmmm - Don't like NAs. Try aggregating?
         ##
            Exclusive_Wide_Check <-  with(Women_Only,
                                         aggregate(list(Total = OBS_VALUE),
                                                   list(Sex = Sex,
                                                        Age = Age,
                                                        Country = Pacific_Island_Countries_and_territories,
                                                        Year = TIME_PERIOD,
                                                        Indicator = Indicator,
                                                        # Labour_and_employment_status = Labour_and_employment_status,  # DROP Out this indicator so we can see whether the data sums up
                                                        Disability = Disability),
                                                 sum, 
                                                 na.rm = TRUE))
                                                 
            Exclusive_Wide_Check    #   Yep, good enough for Government

         ##
         ##    Getting Rid of the NAs - use BOTH wide and Long, and subset and wide again
         ##
            Exclusive_Wide_Check <- reshape2::dcast(Women_Only,                                   
                                                     Pacific_Island_Countries_and_territories + Age + Disability + TIME_PERIOD ~  Labour_and_employment_status,
                                                     value.var = c("OBS_VALUE")) 
                                                     
            Exclusive_Wide_Check <- reshape2::melt(Exclusive_Wide_Check,           
                                                   id.vars = c("Pacific_Island_Countries_and_territories", "Age", "Disability", "TIME_PERIOD")) 
                                                   
            Exclusive_Wide_Check$value[is.na(Exclusive_Wide_Check$value)] <- 0
            
            Exclusive_Wide_Check <- reshape2::dcast(Exclusive_Wide_Check,                                   
                                                     Pacific_Island_Countries_and_territories + Age + Disability + TIME_PERIOD ~  variable,
                                                     value.var = c("value")) 

            Exclusive_Wide_Check$Total <- Exclusive_Wide_Check$Employed + Exclusive_Wide_Check$`Outside Labour Force` + Exclusive_Wide_Check$Unemployed



      ##
      ##    With Subsetting, anything that excepts a dataset, will also except a subsetted data
      ##
            Exclusive_Wide_Check_with_Both_Gender <-  with(Pacific_Labour_Force[(Pacific_Labour_Force$Indicator     == "Proportion of persons by professional status") &
                                                                                (Pacific_Labour_Force$Age           != "All ages") &
                                                                                (Pacific_Labour_Force$Urbanization  == "National") &
                                                                                (Pacific_Labour_Force$Sex           != "Total") &
                                                                                (Pacific_Labour_Force$Labour_and_employment_status %in% c("Employed", "Unemployed", "Outside Labour Force")),],
                                                        aggregate(list(Total = OBS_VALUE),
                                                                  list(Sex = Sex,
                                                                       Age = Age,
                                                                       Country = Pacific_Island_Countries_and_territories,
                                                                       Year = TIME_PERIOD,
                                                                       Indicator = Indicator,
                                                                       # Labour_and_employment_status = Labour_and_employment_status,  # DROP Out this indicator so we can see whether the data sums up
                                                                       Disability = Disability),
                                                                sum, 
                                                                na.rm = TRUE))

            ##
            ##    ... or
            ##

            Exclusive_Wide_Check_with_Both_Gender <- reshape2::dcast(Pacific_Labour_Force[(Pacific_Labour_Force$Indicator     == "Proportion of persons by professional status") &
                                                                                          (Pacific_Labour_Force$Age           != "All ages") &
                                                                                          (Pacific_Labour_Force$Urbanization  == "National") &
                                                                                          (Pacific_Labour_Force$Sex           != "Total") &
                                                                                          (Pacific_Labour_Force$Labour_and_employment_status %in% c("Employed", "Unemployed", "Outside Labour Force")),],
                                                     Pacific_Island_Countries_and_territories + Age + Disability + TIME_PERIOD + Sex ~  Labour_and_employment_status,
                                                     value.var = c("OBS_VALUE")) 



###
###      FIFTH TRICK - Merging
###
      ##
      ##    Most of you would be pretty familiar with this in sql
      ##       Nothing explains it better than stackoverflow: https://stackoverflow.com/questions/5706437/whats-the-difference-between-inner-join-left-join-right-join-and-full-join
      ##
   
      ##
      ##    Used in conjunction with aggregate, gives you a Macro/Micro perspective which might be good for comparing difference.
      ##
      ##    Indirect standardisation is a technique for comparing things together, adjusting for changes in thier population.
      ##    For example, how would each pacific country's unemployment look, if all the countries had the same population structure?
      ##
      ##    We can use different "cuts" of the Pacific_Labour_Force dataset to estimate both a standard pacific population, and each country's unemployment relate to is
      ##
      ##
      ##

         Standard_Population <-  with(Pacific_Labour_Force[(Pacific_Labour_Force$Indicator     == "Number of persons by professional status") &
                                                           (Pacific_Labour_Force$Age           != "All ages") &
                                                           (Pacific_Labour_Force$Urbanization  == "National") &
                                                           (Pacific_Labour_Force$Sex           != "Total") &
                                                           (Pacific_Labour_Force$Labour_and_employment_status %in% c("All labour and employment statuses")),],
                                                     aggregate(list(Total = OBS_VALUE),
                                                               list(Sex = Sex,
                                                                    Age = Age,
                                                                    Disability = Disability),
                                                             mean, 
                                                             na.rm = TRUE))
         ##
         ##    That's the "macro" population structure.
         ##       Now apply the "micro" employment proportions to this common base - note I'm estimating a mean because of the different years
         ##
            Country_Level_Employment_Structure <-  with(Pacific_Labour_Force[(Pacific_Labour_Force$Indicator     == "Proportion of persons by professional status") &
                                                                             (Pacific_Labour_Force$Age           != "All ages") &
                                                                             (Pacific_Labour_Force$Urbanization  == "National") &
                                                                             (Pacific_Labour_Force$Sex           != "Total") &
                                                                             (Pacific_Labour_Force$Labour_and_employment_status %in% c("Employed", "Unemployed", "Outside Labour Force")),],
                                                        aggregate(list(Proportions = OBS_VALUE/100),
                                                                  list(Sex = Sex,
                                                                       Age = Age,
                                                                       Country = Pacific_Island_Countries_and_territories,
                                                                       Labour_and_employment_status = Labour_and_employment_status,  # DROP Out this indicator so we can see whether the data sums up
                                                                       Disability = Disability),
                                                                mean, 
                                                                na.rm = TRUE))      
         ##
         ##    Still sum up to 1? - Yep, good enough for me
         ##
            Country_Level_Employment_Structure <- reshape2::dcast(Country_Level_Employment_Structure,
                                     Country + Age + Disability + Sex ~  Labour_and_employment_status,
                                     value.var = c("Proportions"))       
                                     
            Country_Level_Employment_Structure <- reshape2::melt(Country_Level_Employment_Structure,           
                                    id.vars = c("Country", "Age", "Disability", "Sex")) 
                                                   
            Country_Level_Employment_Structure$value[is.na(Country_Level_Employment_Structure$value)] <- 0
            
            Check <- reshape2::dcast(Country_Level_Employment_Structure,                                   
                                     Country + Age + Disability + Sex ~  variable,
                                     value.var = c("value")) 

            Check$Total <- Check$Employed + Check$`Outside Labour Force` + Check$Unemployed
      
      ##
      ##    Now, apply these "micro" level breakdowns at the country level, to the standard population of the pacific 
      ##       to standardise employment using a merge
      ##
            Standardised_Employment_Estimates <- merge(Country_Level_Employment_Structure,
                                                       Standard_Population,
                                                       by = c("Age", "Disability", "Sex"))
                                                       
            Standardised_Employment_Estimates$Number_of_Persons <- Standardised_Employment_Estimates$value * Standardised_Employment_Estimates$Total


            Standardised_Employment_Aggregates <-  with(Standardised_Employment_Estimates,
                                                        aggregate(list(Number_of_Persons = Number_of_Persons),
                                                                  list(Country = Country,
                                                                       Labour_and_employment_status = variable),
                                                                sum, 
                                                                na.rm = TRUE))    

     ##
     ##    What does size look like? (don't worry about this bit - we'll pick it up later)
     ##
        Standardised_Employment_Aggregates$Country_Split <- str_wrap(Standardised_Employment_Aggregates$Country, 10)

        showtext_auto()
                   
        ggplot(Standardised_Employment_Aggregates) +
          geom_col(aes(x = reorder(Country_Split, Number_of_Persons),
                       y = Number_of_Persons/1000),
                       fill = SPCColours("Red"), alpha = 0.75) +
          facet_wrap(. ~ Labour_and_employment_status, ncol = 1,scales = "free_y" ) +
          labs(title = "Pacific Island Employment Status",
               subtitle = "\nStandardised to a Common Population\n",
               caption  = "The Pacific Community (SPC)") +
          ylab("Number of People\n(1000)\n") +
          xlab("") +
          
          theme_bw(base_size=12, base_family =  "Calibri") %+replace%
          theme(legend.title.align=0.5,
                plot.margin = unit(c(1,1,1,1),"mm"),
                panel.border = element_blank(),
                strip.background =  element_rect(fill   = SPCColours("Light_Blue")),
                strip.text = element_text(colour = "white", 
                                          size   = 18,
                                          family = "MyriadPro-Bold",
                                          margin = margin(2,2,2,2, unit = "mm")),
                panel.spacing = unit(1, "lines"),                                              
                legend.text   = element_text(size = 6, family = "MyriadPro-Regular"),
                legend.title  = element_text(size = 6, family = "MyriadPro-Regular"),
                plot.title    = element_text(size = 30, colour = SPCColours("Dark_Blue"),  family = "MyriadPro-Light"),
                plot.subtitle = element_text(size = 20, colour = SPCColours("Light_Blue"), family = "MyriadPro-Light"),
                plot.caption  = element_text(size = 14,  colour = SPCColours("Dark_Blue"), family = "MyriadPro-Light", hjust = 1.0),
                plot.tag      = element_text(size =  9, colour = SPCColours("Red")),
                axis.title    = element_text(size = 12, colour = SPCColours("Dark_Blue")),
                axis.text.x   = element_text(size = 16, colour = SPCColours("Dark_Blue"), angle = 00,  margin = margin(t = 0, r = 0, b = 0, l = 0, unit = "pt")),
                axis.text.y   = element_text(size = 10, colour = SPCColours("Dark_Blue"), angle = 00),
                legend.key.width = unit(0, "mm"),
                legend.spacing.y = unit(0, "mm"),
                legend.margin = margin(0, 0, 0, 0),
                legend.position  = "bottom")         
          
      
   ##
   ## Save the TA_Only as both and R data frame, and as a csv for sending to someone. 
   ##
      save(Standardised_Employment_Estimates,    file = 'Data_Intermediate/Standardised_Employment_Estimates.rda')
      
##
##    And we're done
##
