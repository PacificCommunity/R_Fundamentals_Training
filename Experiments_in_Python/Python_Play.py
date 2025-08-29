##
##    Programme:  Data_Manipulation.py
##
##    Objective:  Learn how to do all those things I teach other people to do in R
##                  https://www.w3schools.com/python/python_casting.asp
##
##                Functionality installed from the command prompt:
##                    python -m pip install Geopandas pandas geodatasets matplotlib
##
##                    pip install pywin32 
##
##    Author:     James Hogan, started 28 August 2026
##
##

##
##      Clear the memory
##

for name in dir():
    if not name.startswith('__'):  # Exclude built-in names and special attributes
        del globals()[name]
##
##  load some functionality
##
import pandas
import seaborn
import matplotlib
import os
import win32com.client


pandas.options.display.max_columns = None
pandas.options.display.max_rows = 1000
pandas.options.display.width = 1500

current_directory = os.getcwd()
print(f"Current Working Directory: {current_directory}")


arr = os.listdir("C:/From BigDisk/GIT/R_Fundamentals_Training/Experiments_in_Python/")
print(arr)

##
##    Initialise some ComClient parameters
##
ex = win32com.client.Dispatch("Excel.Application")
ex.Visible = True
ex.DisplayAlerts = False
ex.AskToUpdateLinks = False
Workbook = ex.workbooks

Worksheet = "WCPFC-CA tuna fisheries 2024"


current_file = Workbook.Open(current_directory + "/" + Worksheet + ".xlsx")

for j in range(0,current_file.Worksheets.count):
    Name = current_file.Worksheets[j].name
    print(Name)
    
    Save_Name = current_directory + "\\RAWDATA_" + Name
    Save_Name = Save_Name + "XX" + Worksheet
    Save_Name = Save_Name.replace(" ", "_")
    Save_Name = Save_Name.replace("-", "_")
    Save_Name = Save_Name.replace(".", "")
    Save_Name = Save_Name + ".csv"
    print(Save_Name)
    
    ##
    ##  Save each tab as CSV and read it inidentif
    ##
    Current_Tab = current_file.Worksheets(Name)
    Current_Tab.Range("A1:IV60000").RemoveSubtotal()
    Range = Current_Tab.Range("A1:IV60000")
    Range.NumberFormat = "0.000000000000"
    
    Current_Tab.SaveAs(Save_Name, FileFormat = 6)
    # ##
    # ##     Stick everything back in an appropriately named data frame and save
    # ##
    # X <- read.csv(paste0(str_replace_all(getwd(), "\\/", "\\\\\\\\"), "\\\\Data_Intermediate\\\\test.csv"), colClasses = c("character"),header = FALSE)
    # X[] <- lapply(X, as.character)
    # assign(paste0("RAWDATA_", Name, "XX", Directories$Save_Name[File]), X )
    # save(list = paste0("RAWDATA_", Name, "XX", Directories$Save_Name[File]), 
    # file = paste0("Data_Intermediate/RAWDATA_", Name, "XX", Directories$Save_Name[File], ".rda"))
    # rm(list=paste0("RAWDATA_", Name, "XX", Directories$Save_Name[File]))
    # }, warning = function(w) {
    # }, error = function(e) {
    # DidntRead <- rbind.fill( DidntRead , data.frame(File = Directories$Details[File],
                                        # Tab = Name))
    # }, finally = {
    # })  

ex.quit()


