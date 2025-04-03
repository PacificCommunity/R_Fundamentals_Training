##
##    Programme:  Introduction_to_Graphics.r
##
##    Objective:  Part of R Fundamentals for Reading, Manipulating and Writing
##                data in R.
##
##                The main objective of this programme is to introduce you to basic
##                graphics using ggplot2.
##
##
##    Plan of  :  In this programme, we are going to:
##    Attack   :    (1) Read in some publically available tax data
##                  (2) Generate a graph
##                  (3) Building on the graph and add themes
##                  (4) Saving and incorporating into documents
##
##    Author:     James Hogan, SDD - Analaysis and Insights, 27 March 2025
##
##
   ##
   ##    Clear the memory and grab some case data and lab data
   ##
      rm(list=ls(all=TRUE))
   ##
   ##    Load in some colours, functions. Here's how to add new fonts, instance, a Google Font https://fonts.google.com/share?selection.family=Rochester
   ##
      source("R/themes.r")

      font_paths(paste0(getwd(), "/R"))
      font_add("Rochester", regular = "Rochester-Regular.ttf")
      
      ##
      ## Lets work in IRD Fonts for this session
      ##
         windows()        # This opens a blank graphics window, otherwise showtext falls over if a graphics window isn't already open
         showtext_begin()
         
      ##
      ## Test to see if it works
      ##
         hist(rnorm(1000), 
             breaks = 30, 
             col = SPCColours("Light_Blue"), 
             border = SPCColours("Green"),       
             main = "", 
             xlab = "", 
             ylab = "")
         title(main   = "Histogram of Normal Random Numbers", 
               family = "Rochester", 
               cex.main = 4, 
               col.main = SPCColours("Gold"))
         title(sub = "Publication Compliant Chart", 
            family = "Rochester", 
            cex.sub = 2, 
            col.sub = SPCColours("Purple"))
         title(ylab = "Frequency", 
             family = "Rochester", 
            cex.lab = 1.75, 
            col.lab = SPCColours("Dark_Blue"))
         axis(1, family = "Verdana", col = SPCColours("Gold"), col.axis = SPCColours("Gold"))
         axis(2, family = "Verdana", col = SPCColours("Gold"), col.axis = SPCColours("Gold"))
         text(2, 80, "N = 1000", family = "Rochester", cex = 1.75, col = SPCColours("Dark_Blue"))

      
   ##    ggplot2 (grammer of graphics) is the main graphing library in R and is
   ##    one of the first big advances in graphics lead by Hadley Wickham and its a 
   ##    big deal. Drop "Grammer of Graphics" into google and you get a LARGE amount
   ##    of content, like this: https://towardsdatascience.com/a-comprehensive-guide-to-the-grammar-of-graphics-for-effective-visualization-of-multi-dimensional-1f92b4ed4149
   ##    and this: https://vita.had.co.nz/papers/layered-grammar.html
   ##
   ##    This is just a basic introduction because, frankly the topic is too big.
   ##    I encourage you to dive into the volumes of information on the internet
   ##    about it.
   ##
   ##    THE GRAPHICAL TOOL SHAPES THE ANALYTICAL THINKING
   ##    Graphing is one of R's advantage is over other langauges, and it the influence
   ##    visualistion has on modelling and analystical thinking is fundamental and 
   ##    persuasive. 
   ##
   ##    A limitation of excel is its pre-canned charts lead to experienced
   ##    excel users possessing "pre-canned" thinking. You'll find the constraints on 
   ##    your ability to thinking about how to visualise data will constrain your ability
   ##    to think differently about data. For example, with Excel's bar charts and time-
   ##    series out of the box functionality, most analysts become so accustom to thinking
   ##    about time-series as a dimension, they can't think about the data in any other
   ##    way. 
   ##
   ##    How many times have your seen a dashboard of four / five charts all graphed
   ##    over time, where time may not be the best dimension. 
   ##    Try this one on pages 11 & 12: https://www.beehive.govt.nz/sites/default/files/2020-12/NZ%20Story.pdf
   ##
   ##    We call those type of graphic "univariate" thinking because the time dimension 
   ##    is so implicit in the graphs and makes no sense.
   ##
   ##    STRUCTURE OF A GGPLOT GRAPHIC
   ##    GGplot is a LAYERED langauge: R processes each component of a ggplot request
   ##    superimposing one layer over the last. The basic format goes something like this
   ##    (note the pluses):
   ##
   ##    ggplot(data) +                              (1)
   ##       geom_something(aes(something_in_here) +  (2)
   ##       scale_x_something(something_in_here)  +  (3)
   ##       labs(something_in_here)               +  (4)
   ##       other graph modifiers                    (5)
   ##
   ##    Spend some time going through ?ggplot2 and seeing what I mean about many options.
   ##
   ##    geom_something refers to the very wide, and very extensive types of chart types.
   ##    (1) What's the datasource use to build 
   ##    (1) The main ones are:
   ##          geom_line:        A line chart, where all of the points are connect with a line
   ##          geom_point:       A chart where all of the points are dots
   ##          geom_histogram:   A chart showing frequency distribution
   ##          geom_bar:         A bar chart which is customisable
   ##          geom_col:         A bar chart which in some important ways differs from geom_bar
   ##          geom_smooth:      A smoothed line, with different smoothing algorythms
   ##          geom_sf:          Map plotting functionality
   ##
   ##          "aes" means "aesthetics", which is the content of the graphics. Usual options include:
   ##          aes(x = something, y = something_else, colour = by_some_variable), which defines the 
   ##          x-axis variable, the y-axis variable, and another variable which represents a grouping
   ##          within the data.
   ##
   ##    (2) Scale alters/defines the x or the y axis. Common scales include (for both x and y)
   ##          scale_x_continuous:  used for continous variables. The main difference is how you set the breaks (tick marks)
   ##          scale_x_date:        used for dates. Breaks can be formated using time format information (%d - %B for 12 June for example)
   ##          scale_x_discrete:    where the data is something like c("apples", "oranges", "pumpkin"), you can order the breaks a specific way.
   ##          scale_x_log10:       Logarytimic scale, where each break is 10x larger than the value before it.
   ##
   ##    (3) Lables for the axis, the titles, the subtitle and a footnote if you want it 
   ##
   ##    (5) Other graph modifiers are invocked through the "theme" command, and gives you
   ##          tremendous flexibility of all aspects of the graph, for example fonts, title size,
   ##          colours, etc.
   
   ##
   ##    Grab some data  - this time we're going to pull from PDH.stat
   ##    https://docs.pacificdata.org/dotstat/plugins/r
   ##
      SDMX_Data_Sources <- as.data.frame(getSDMXServiceProviders())
      SDMX_Data_Sources

      PDH_Topics <- as.data.frame(readSDMX(providerId="PDH", resource="dataflow"))
      head(PDH_Topics)
      PDH_Topics[,c("id", "Name.en")]

      ##
      ##    Lets grab the Balance of Payments
      ##

      library(rsdmx)
      sdmx <- readSDMX(providerId="PDH", resource="dataflow", resourceId="DF_BOP", dsd=TRUE)
      this_df <- sdmx@dataflows[[1]]
      this_df@dsd@codelists@codelists[[2]]
      BoP  <- data.table(as.data.frame(sdmx))


   
   ##
   ##    PART 1: Make a very basic graph
   ##
     ##
     ##     bar chart
     ##
      ggplot(Standardised_Employment_Aggregates) +
          geom_col(aes(x = Country_Split,
                       y = Number_of_Persons/1000))
                       
         ##
         ##    Maybe we want to reorder the countries?
         ##
      ggplot(Standardised_Employment_Aggregates) +
          geom_col(aes(x = reorder(Country_Split, Number_of_Persons),
                       y = Number_of_Persons/1000))



     ##
     ##     line chart
     ##
     ggplot(Standardised_Employment_Aggregates) +
       geom_line(aes(x = Country_Split, 
                     y = Number_of_Persons/1000))

     ##
     ##     These charts can be "layered" over each other in order
     ##        for example this...
     ggplot(Standardised_Employment_Aggregates) +
       geom_line( aes(x = Date, y = Total_Tax_Revenue), size = 1) +
       geom_point(aes(x = Date, y = Total_Tax_Revenue), size = 3, colour = "red")
     ##
     ##     Is different from this...  can you see the difference?
     ##
     ggplot(Standardised_Employment_Aggregates) +
       geom_point(aes(x = Date, y = Total_Tax_Revenue), size = 3, colour = "red")+
       geom_line( aes(x = Date, y = Total_Tax_Revenue), size = 1) 

     ##
     ##    Ok, lets go with this being our basic chart.
     ##
     ggplot(Standardised_Employment_Aggregates) +
       geom_point(  aes(x = Date, y = Total_Tax_Revenue), size = 3, colour = "red")+
       geom_line(   aes(x = Date, y = Total_Tax_Revenue), size = 1) +
       geom_smooth( aes(x = Date, y = Total_Tax_Revenue), size = 1)
       
     ##
     ##    Lets introduce some of the features of ggplot that improve the communications
     ##     (1) The "story" of this chart is its shape - lets keep the smoothed line and the points
     ##
     ggplot(Standardised_Employment_Aggregates) +
       geom_point(  aes(x = Date, y = Total_Tax_Revenue), size = 3, colour = "red")+
       geom_smooth( aes(x = Date, y = Total_Tax_Revenue), size = 1) 
     ##
     ##     Lets downplay the points, to accent the shape. The points are needed to "prove"
     ##        the shape, but the story is the shape. Use alpha to drop the opaqueness of the dots
     ##        so they're still in the picture, but they're not overpowering the graphic
     ##
     ggplot(Standardised_Employment_Aggregates) +
       geom_point(  aes(x = Date, y = Total_Tax_Revenue), size = 3, colour = "red", alpha = .3)+
       geom_smooth( aes(x = Date, y = Total_Tax_Revenue), size = 1) 
     ##
     ##     Lets alter the scales and add some lables
     ##
     ##     The escape characters "\n" add a carriage return to the text, spacing it out better
     ##
     ggplot(Standardised_Employment_Aggregates) +
       geom_point(  aes(x = Date, y = Total_Tax_Revenue), size = 3, colour = "red", alpha = .3)+
       geom_smooth( aes(x = Date, y = Total_Tax_Revenue), size = 1) +
       scale_y_continuous(breaks = seq(from = 20000, to = 80000, by =5000)) +
       scale_x_date(date_breaks = "1 year",
                    limits = as.Date(c('30/06/1999"', '30/06/2017'), format="%d/%m/%Y"), expand = c(0,0))  + 
       labs(x = "\nFinancial Years",
            y = "Total Tax Revenue\n($Mill)\n",
            title = "New Zealand Total Tax Revenue",
            subtitle = "Source: Schedule of non-departmental revenue, For the year ended 30 June 2017, IR Annual Report 2017, pp144-145",
            caption  = "Created by the IRD High Wealth Individual Research Project")
     ##
     ##     Coming on... Its already starting to look great :)
     ##
     ##        Lets modify aspects of the graph using the "themes" 
     ##
     
     ##
     ##     At this point, check out the file "themes.r" in the "R" directory off the base directory.
     ##        I've gone through the IRD Branding Guide and created some R code which will allow you 
     ##        to colour your graph according to IRD colours.
     ##
     
     ##
     ##     Unfortunately, pictures with IRD fonts need to be saved using ggsave, which is a bit flakey.
     ##        You will need to juggle with the sizes of the different picture elements, and / or the 
     ##        output width and height to get the picture looking perfect.
     ##
     
     showtext_auto()
      ##
      ##    Lets save two pictures - one with titles and one without
      ##       First with titles
      ##
        ggplot(Standardised_Employment_Aggregates) +
          geom_point(  aes(x = Date, y = Total_Tax_Revenue), size = 3, colour = SPCColours("IR_Silver"), alpha = .4) +
          geom_smooth( aes(x = Date, y = Total_Tax_Revenue), fill=SPCColours("Purple"), size = 1.5, colour = SPCColours("Green")) +
          scale_y_continuous(breaks = seq(from = 20000, to = 80000, by =5000),
                             labels = scales::label_comma()) +
          scale_x_date(date_breaks = "1 year",
                       limits = as.Date(c('30/06/2000"', '30/06/2018'), format="%d/%m/%Y"),
                       date_labels = "%Y")  + 
          labs(x = "Financial Years",
               y = "Total Tax Revenue\n($Mill)\n",
               title = "New Zealand Total Tax Revenue",
               subtitle = "\nSource: Schedule of non-departmental revenue, For the year ended 30 June 2017, IR Annual Report 2017, pp144-145\n",
               caption  = "\nCreated by the IRD High Wealth Individual Research Project") +
          theme_bw(base_size=12, base_family =  "Rochester") %+replace%
          theme(legend.title.align=0.5,
                 plot.margin = unit(c(0,0,0,0),"mm"),
                 panel.border = element_blank(),
                 strip.background =  element_rect(fill = SPCColours("IR_Taupe")),
                 strip.text = element_text(colour = SPCColours("Gold"), 
                                           size=10,
                                           family = "Rochester",
                                           margin = margin(1,3,1,3, unit = "mm")),
                 panel.spacing = unit(1, "lines"),                                              
                 legend.text   = element_text(size = 12),
                 plot.title    = element_text(size = 22, colour = SPCColours("Purple"),                ),
                 plot.subtitle = element_text(size = 12, colour = SPCColours("Purple"),     hjust = 0.5),
                 plot.caption  = element_text(size = 10, colour = SPCColours("Purple"),     hjust = 1.0, face = "italic"),
                 plot.tag      = element_text(size =  9, colour = SPCColours("Gold"), hjust = 0.0, face = "italic" ),
                 axis.title    = element_text(size = 18, colour = SPCColours("Light_Blue")),
                 axis.text.y   = element_text(size = 14, colour = SPCColours("Light_Blue"), angle = 00),
                 axis.text.x   = element_text(size = 14, colour = SPCColours("Light_Blue"), angle = 90, hjust = 1.0),
                 legend.key.width = unit(1, "cm"),
                 legend.spacing.y = unit(1, "cm"),
                 legend.margin    = margin(0, 0, 0, 0),
                 legend.position  = "none") 
   ##
   ## Save it to the "Graphical_Output" location, so all your pictures are in the one place
   ##
   ggsave("Graphical_Output/Total_Tax_Revenue_With_Titles.png", width =16.13, height = 20.66, dpi = 165, units = c("cm"))
   ##
   ##    Lets make two pictures - one with titles and one without
   ##       Second without titles
   ##
        ggplot(Standardised_Employment_Aggregates) +
          geom_point(  aes(x = Date, y = Total_Tax_Revenue), size = 3, colour = SPCColours("IR_Silver"), alpha = .4) +
          geom_smooth( aes(x = Date, y = Total_Tax_Revenue), fill=SPCColours("Purple"), size = 1.5, colour = SPCColours("Green")) +
          scale_y_continuous(breaks = seq(from = 20000, to = 80000, by =5000),
                             labels = scales::label_comma()) +
          scale_x_date(date_breaks = "1 year",
                       limits = as.Date(c('30/06/2000"', '30/06/2018'), format="%d/%m/%Y"),
                       date_labels = "%Y")  + 
          labs(x = "Financial Years",
               y = "Total Tax Revenue\n($Mill)\n") +
          theme_bw(base_size=12, base_family =  "Rochester") %+replace%
          theme(legend.title.align=0.5,
                 plot.margin = unit(c(0,0,0,0),"mm"),
                 panel.border = element_blank(),
                 strip.background =  element_rect(fill = SPCColours("IR_Taupe")),
                 strip.text = element_text(colour = SPCColours("Gold"), 
                                           size=10,
                                           family = "Rochester",
                                           margin = margin(1,3,1,3, unit = "mm")),
                 panel.spacing = unit(1, "lines"),                                              
                 legend.text   = element_text(size = 12),
                 plot.title    = element_text(size = 22, colour = SPCColours("Purple"),                ),
                 plot.subtitle = element_text(size = 12, colour = SPCColours("Purple"),     hjust = 0.5),
                 plot.caption  = element_text(size = 10, colour = SPCColours("Purple"),     hjust = 1.0, face = "italic"),
                 plot.tag      = element_text(size =  9, colour = SPCColours("Gold"), hjust = 0.0, face = "italic" ),
                 axis.title    = element_text(size = 18, colour = SPCColours("Light_Blue")),
                 axis.text.y   = element_text(size = 14, colour = SPCColours("Light_Blue"), angle = 00),
                 axis.text.x   = element_text(size = 14, colour = SPCColours("Light_Blue"), angle = 90, hjust = 1.0),
                 legend.key.width = unit(1, "cm"),
                 legend.spacing.y = unit(1, "cm"),
                 legend.margin    = margin(0, 0, 0, 0),
                 legend.position  = "none") 
                 
   ##
   ## Save it to the "Graphical_Output" location, so all your pictures are in the one place
   ##
   ggsave("Graphical_Output/Total_Tax_Revenue_Without_Titles.png", width =16.13, height = 20.66, dpi = 165, units = c("cm"))

 
##
## FACET Charts:  These are super fantastic for showing differences in the data 
##
   ##
   ##    Bring back yesterday's data and lets use it for some analysis
   ##
      Plot_Me <- TA_Only

      ##
      ##    Estimate the average proportion of "Young_Individuals" in this tax data
      ##
         AverYouth <-  with(Plot_Me,
                          aggregate(list(TA_Proportion_Young = TA_Proportion_Young),
                                    list(Size_of_Customer_Base = Size_of_Customer_Base),
                                  mean, 
                                  na.rm = TRUE))
         names(AverYouth)[2] ="Average_over_Time"

      ##
      ##    Merge the "Macro" averages back in the TA level data using the Size_of_Customer_Base variable
      ##
         Plot_Me <- merge(Plot_Me,
                          AverYouth,
                          by = c("Size_of_Customer_Base"))
    
      ##
      ##    We want to facet graphs the data by Size_of_Customer_Base, but we want Size_of_Customer_Base to be in a specific order. 
      ##       To do this, we need to make Size_of_Customer_Base a factor type variable (catagorical), and set its order according to 
      ##       how we want to present it.
      ##
      
         Plot_Me$Size_of_Customer_Base <- factor(Plot_Me$Size_of_Customer_Base, levels = c("Really Small", "Small", "Normal", "Large", "Really Large"))
                   
      ##
      ## Now, layer the data just like we did in the above example.
      ##
         ggplot(data = Plot_Me) +
               ##
               ##    I want to see which TAs have move young taxpayers than others.
               ##       To do this, I sort the "Locations" by the proportions measure BEFORE I graphic, like this...
               ##

            geom_point(aes(x = reorder(Location, TA_Proportion_Young), 
                           y = TA_Proportion_Young),
                      colour = SPCColours("Gold"), 
                        size = 2) +
               ##
               ##    Now, I want to layer the average for the Size measure onto the chart, so I can both
               ##       compare locations to the size measure, and location size measures to themselves like this...
               ##

            geom_line(aes(x = Location,
                          y = Average_over_Time,
                      group = Size_of_Customer_Base),
                     colour = SPCColours("IR_Ruby"), 
                   linetype = "dashed", 
                       size = 1.0) +
               ##
               ##    Make the Y-axis a percentage measure
               ##
            scale_y_continuous(labels = scales::label_percent(digits=0)) +
               ##
               ##    This is the facet command. The ". ~ Size_of_Customer_Base" says "All the data BY columns of size.
               ##       Try as well the "facet_wrap" command I've commented out
               ##
            facet_grid(. ~ Size_of_Customer_Base, scales = "free", space="free") +
            #facet_wrap(. ~ Size_of_Customer_Base, scales = "free") +
            labs(x = "\nTerritorial Authorities\n",
                  y = "Proportion of\nYoung Individuals\n",
                  title = "Proportion of Young Taxpayers - By Territorial Authority",
                  subtitle = "\nIndividuals Aged 16 or Over\nCombined Companies and Natural Persons\n",
                  caption  = "Created by the IRD High Wealth Individual Research Project") +
            theme_bw(base_size=12, base_family =  "Rochester") %+replace%
            theme(legend.title.align=0.5,
                   plot.margin = unit(c(3,3,3,3),"mm"),
                   panel.border = element_blank(),
                   strip.background =  element_rect(fill = SPCColours("IR_Taupe")),
                   strip.text = element_text(colour = SPCColours("Gold"), 
                                             size=10,
                                             family = "Noto Sans SemBd",
                                             margin = margin(1,3,1,3, unit = "mm")),
                   panel.spacing = unit(1, "lines"),                                              
                   legend.text   = element_text(size = 12),
                   plot.title    = element_text(size = 22, colour = SPCColours("Purple"),                ),
                   plot.subtitle = element_text(size = 14, colour = SPCColours("Purple"),     hjust = 0.5),
                   plot.caption  = element_text(size = 11, colour = SPCColours("Purple"),     hjust = 1.0, face = "italic"),
                   plot.tag      = element_text(size =  9, colour = SPCColours("Gold"), hjust = 0.0, face = "italic" ),
                   axis.title    = element_text(size = 14, colour = SPCColours("Light_Blue")),
                   axis.text.y   = element_text(size = 12, colour = SPCColours("Light_Blue"), angle = 00),
                   axis.text.x   = element_text(size = 12, colour = SPCColours("Light_Blue"), angle = 90, hjust = 1.0),
                   legend.key.width = unit(1, "cm"),
                   legend.spacing.y = unit(1, "cm"),
                   legend.margin    = margin(0, 0, 0, 0),
                   legend.position  = "none") 
   ##
   ## Save it to the "Graphical_Output" location, so all your pictures are in the one place
   ##
      ggsave("Graphical_Output/Youth_Taxpayers_by_Size_With_Titles.png", width =20.66, height = 16.13, dpi = 165, units = c("cm"))
      
   ##
   ## Now without titles
   ##
         ggplot(data = Plot_Me) +
               ##
               ##    I want to see which TAs have move young taxpayers than others.
               ##       To do this, I sort the "Locations" by the proportions measure BEFORE I graphic, like this...
               ##

            geom_point(aes(x = reorder(Location, TA_Proportion_Young), 
                           y = TA_Proportion_Young),
                      colour = SPCColours("Gold"), 
                        size = 2) +
               ##
               ##    Now, I want to layer the average for the Size measure onto the chart, so I can both
               ##       compare locations to the size measure, and location size measures to themselves like this...
               ##

            geom_line(aes(x = Location,
                          y = Average_over_Time,
                      group = Size_of_Customer_Base),
                     colour = SPCColours("IR_Ruby"), 
                   linetype = "dashed", 
                       size = 1.0) +
            labs(x = "\nTerritorial Authorities\n",
                  y = "Proportion of\nYoung Individuals\n") +
               ##
               ##    Make the Y-axis a percentage measure
               ##
            scale_y_continuous(labels = scales::label_percent(digits=0)) +
               ##
               ##    This is the facet command. The ". ~ Size_of_Customer_Base" says "All the data BY columns of size.
               ##       Try as well the "facet_wrap" command I've commented out
               ##
            facet_grid(. ~ Size_of_Customer_Base, scales = "free", space="free") +
            #facet_wrap(. ~ Size_of_Customer_Base, scales = "free") +
            theme_bw(base_size=12, base_family =  "Rochester") %+replace%
            theme(legend.title.align=0.5,
                   plot.margin = unit(c(3,3,3,3),"mm"),
                   panel.border = element_blank(),
                   strip.background =  element_rect(fill = SPCColours("IR_Taupe")),
                   strip.text = element_text(colour = SPCColours("Gold"), 
                                             size=10,
                                             family = "Noto Sans SemBd",
                                             margin = margin(1,3,1,3, unit = "mm")),
                   panel.spacing = unit(1, "lines"),                                              
                   legend.text   = element_text(size = 12),
                   plot.title    = element_text(size = 22, colour = SPCColours("Purple"),                ),
                   plot.subtitle = element_text(size = 14, colour = SPCColours("Purple"),     hjust = 0.5),
                   plot.caption  = element_text(size = 11, colour = SPCColours("Purple"),     hjust = 1.0, face = "italic"),
                   plot.tag      = element_text(size =  9, colour = SPCColours("Gold"), hjust = 0.0, face = "italic" ),
                   axis.title    = element_text(size = 14, colour = SPCColours("Light_Blue")),
                   axis.text.y   = element_text(size = 12, colour = SPCColours("Light_Blue"), angle = 00),
                   axis.text.x   = element_text(size = 12, colour = SPCColours("Light_Blue"), angle = 90, hjust = 1.0),
                   legend.key.width = unit(1, "cm"),
                   legend.spacing.y = unit(1, "cm"),
                   legend.margin    = margin(0, 0, 0, 0),
                   legend.position  = "none") 
   ##
   ## Save it to the "Graphical_Output" location, so all your pictures are in the one place
   ##
   ggsave("Graphical_Output/Youth_Taxpayers_by_Size_No_Titles.png", width =20.66, height = 16.13, dpi = 165, units = c("cm"))


   ##
   ## Lets pretend this dataset is the "final output" of the analysis
   ##
      save(Standardised_Employment_Aggregates, file = "Data_Output/Standardised_Employment_Aggregates.rda")
   
   
##
##    And we're done
##
   