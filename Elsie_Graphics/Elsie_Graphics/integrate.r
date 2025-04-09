##    Programme:  Elsie_Graphics.r
##
##    Objective:  
##
##    Plan of  :  
##    Attack   :  
##                
##
##    Important:  
##    Linkages :  
##
##    Author   :  James Hogan, SDD - Analysis and Insight, 24 March 2025
##
##    Peer     :  <PROGRAMMER>, <TEAM>, <PEER REVIEWED COMPLETED>
##    Reviewer :
##
   ##
   ##    Clear the decks and load up some functionality
   ##
      rm(list=ls(all=TRUE))
      options(scipen = 999)
   ##
   ##    Core libraries
   ##
      library(ggplot2)
      library(plyr)
      library(stringr)
      library(reshape2)
      library(lubridate)
      library(calibrate)
      library(Hmisc)
      library(RColorBrewer)
      library(stringi)
      library(sqldf)
      library(extrafont)
      library(scales)
      library(RDCOMClient)
      library(extrafont)
      library(tictoc)
   ##
   ##    Project-specific libraries
   ##
      library(sysfonts)
      library(showtext)

   ##
   ##    Set working directory
   ##
      setwd("C:\\repositories\\R_Fundamentals_Training\\Elsie_Graphics\\Elsie_Graphics")

      ##
      ##    STEP 1: Read the Spreadsheet data into R.
      ##
      ##
         source("Programmes/Read_Spreadsheets.r") 

      ##
      ##    STEP 2: Make the data tidy and consistent so it can be graphed
      ##
         source("Programmes/Clean_Data.r")     
         
      ##
      ##    STEP 3: Make Pictures
      ##
         source("Programmes/Make_Pictures.r") 

      ##
      ##    Write up of results
      ##      
         rmarkdown::render("Programmes/Write_Up.rmd", output_file = "C:\\repositories\\R_Fundamentals_Training\\Elsie_Graphics\\Elsie_Graphics\\Product_Output\\R_Disability_Factsheet2.docx")                   


##
##   End of programme
##
