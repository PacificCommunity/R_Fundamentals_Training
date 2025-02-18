##    Programme:  Fundamentals, Graphics and Reporting.r
##
##    Objective:  Welcome to R! This project is designed to give you the basic
##                fundiamentals in R for SPC.
##
##    Plan of  :  This is a first programme to do three things: reading in data,
##    Attack   :  manipulating it into form its useful, and writing out a 
##                comma separated file, and a dataframe
##
##    Author   :  James Hogan, SDD - Analaysis and Insights, 12 February 2025
##
   ##
   ##    Clear the decks and load up some functionality
   ##
      rm(list=ls(all=TRUE))
      
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
      library(scales)
      library(RDCOMClient)
      library(extrafont)
      library(tictoc)
      library(sysfonts)
      library(showtext)
      
   ##
   ##    Set working directory - REPLACE THIS WITH SOMETHING SPECIFIC FOR YOU
   ##
      setwd("C:\\Users\\jamesh\\OneDrive - SPC\\R Fundamentals Training\\Fundamentals Graphics and Reporting")

      ##
      ##    Run a programme that reads in excel and outputs R dataframes
      ##
         source("Programmes/Read_Spreadsheets.r") # This programme tests RDCOMClient is working
      
      ##
      ##    DAY 1: Basics and Data Manipulation
      ##
         source("Programmes/Introduction_to_R.r") # This is a first session programme, including time for setting the scene and playing with RStudio
         source("Programmes/Data_Manipulation.r") # This extends the first session into data manipulation and data output (writing)
      ##
      ##    DAY 2: Graphing and Markdown
      ##
         source("Programmes/Initial_System_Setup.r")      # Sets up your fonts for SDD Publication Standards
         source("Programmes/Introduction_to_Graphics.r")  # Introduction to Grammar of the Graphs (ggplot)
         ##
         ##    Make sure the output_file location is something specific for you
         ##
         rmarkdown::render("Programmes/SSAP_Value_Report.rmd", output_file = "C:\\From BigDisk\\GIT\\R_Fundamentals_Training\\Fundamentals Graphics and Reporting\\Product_Output\\Value of Good Science.docx")                



##
##   End of programme
##
