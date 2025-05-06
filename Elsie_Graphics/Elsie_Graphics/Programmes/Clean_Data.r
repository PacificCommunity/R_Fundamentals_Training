##
##    Programme:  Clean_Data.r
##
##    Objective:  Clean Elsie's data.
##
##    Author:     James Hogan, Analysis and Insight, SDD, 24 March 2025
##    Peer Review:<PROGRAMMER>, <TEAM>, <DATE STARTED>
##
##
   ##
   ##    Clear the memory
   ##
      rm(list=ls(all=TRUE))
   ##
   ##    Load data from somewhere
   ##
      load("Data_Intermediate/RAWDATA_DemographicsXXKiribati_Disability_factsheet.rda")
      load("Data_Intermediate/RAWDATA_EducationXXKiribati_Disability_factsheet.rda")
      load("Data_Intermediate/RAWDATA_Labour forceXXKiribati_Disability_factsheet.rda")
      load("Data_Intermediate/RAWDATA_PrevalenceXXKiribati_Disability_factsheet.rda")

   ##
   ## Step 1: Education
   ##
      Education <- RAWDATA_EducationXXKiribati_Disability_factsheet[3:7,]
      names(Education) <- c("Highest Level", Education[1,2:4])
      Education <- reshape2::melt(Education,
                                  id.var = c("Highest Level"))
      Education$Proportion <- as.numeric(str_replace_all(Education$value, "\\%",""))/100
      Education <- Education[!is.na(Education$Proportion),]
      
      Education <- Education[,c(1,2,4)]
      names(Education) <- c("Highest Level", "Measure", "Proportion")
   
   ##
   ## Step 2: Disability
   ##
      Demographics <- RAWDATA_DemographicsXXKiribati_Disability_factsheet
      Demographics <- Demographics[5:12,2:8]
      Mapping      <- data.frame(variable = names(Demographics)[2:length(names(Demographics))],
                                 Measure  = rep(c("With Disability", "Without Disability"), each = 3),
                                 Sex  = rep(c("Males", "Females", "Total"),2))
      
      Demographics <- reshape2::melt(Demographics,
                                     id.var = c("V2"))
      Demographics <- merge(Demographics,
                            Mapping,
                            by = c("variable"))
      names(Demographics)[2:3] <- c("Age_Group","Population")
      Demographics <-Demographics[Demographics$Sex != "Total",]
      Demographics$Left_Age   <- (as.numeric(str_split_fixed(Demographics$Age_Group,"-",2)[,1]) + as.numeric(str_split_fixed(Demographics$Age_Group,"-",2)[,2]))/2
      Demographics$Left_Age[is.na(Demographics$Left_Age)] <- 80
      Demographics$Population <- as.numeric(Demographics$Population)

      Demographics <- Demographics[,c(2,6,4,5,3)]
   
   ##
   ## Step 3: Education
   ##


   ##
   ## Step 4: Labour_Force
   ##
      Labour_Force <- `RAWDATA_Labour forceXXKiribati_Disability_factsheet`
      Labour_Force <- Labour_Force[16:19,1:4]
      Mapping      <- data.frame(variable = names(Labour_Force)[2:length(names(Labour_Force))],
                                 Measure  = c("Total", "With Disability", "Without Disability"))
      
      Labour_Force <- reshape2::melt(Labour_Force,
                                     id.var = c("V1"))
      Labour_Force <- merge(Labour_Force,
                            Mapping,
                            by = c("variable"))
      names(Labour_Force)[2:3] <- c("Labour Force Status","Population")
      Labour_Force <- Labour_Force[Labour_Force$Measure != "Total",]
      Labour_Force$Population <- as.numeric(Labour_Force$Population)
      Labour_Force <- Labour_Force[,c(2,4,3)]
   
   ##
   ## Step 5: Prevalence
   ##
      Prevalence   <- sqldf('Select Demographics.Age_Group,
                                    Demographics.Left_Age,
                                    sum(Demographics.Population) as Disabled,
                                    sum(Demographics.Population) / Total.Total_Population as Proportion,
                                    Total.Total_Population
                              from Demographics,
                                   (select Age_Group, sum(Population) as Total_Population
                                       from Demographics
                                       group by Age_Group) as Total
                              where (Demographics.Measure = "With Disability")
                                and (Demographics.Age_Group = Total.Age_Group)
                              group by Demographics.Age_Group,
                                       Total.Total_Population
                              order by Demographics.Left_Age')

   ##
   ## Save files our produce some final output of something
   ##
      save(Demographics, file = 'Data_Intermediate/Demographics.rda')
      save(Prevalence,   file = 'Data_Intermediate/Prevalence.rda')
      save(Labour_Force, file = 'Data_Intermediate/Labour_Force.rda')
      save(Education,    file = 'Data_Intermediate/Education.rda')
##
##    And we're done
##
