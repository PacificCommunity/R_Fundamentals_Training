##
##    Programme:  Initial_System_Setup.r
##
##    Objective:  Part of R Fundamentals for Reading, Manipulating and Writing
##                data in R.
##
##                The main objective of this programme is to set up each person's systems
##                to use their corporate fonts
##
##
##    Author:     James Hogan, FAME, 18 February 2025
##
##
   ##
   ##    Clear the memory and grab some case data and lab data
   ##
      rm(list=ls(all=TRUE))
   ##
   ##    Load in some colours and functions 
   ##
      source("R/themes.r")

   ##
   ##    Under extrafont, we need to import the font library, but we only need to do that once.
   ##
      font_import()
   ##
   ##    Everyone time we use extrafont, we need to load the fonts like below
   ##
      loadfonts(device = "win")

   ##
   ##    Fonts available under extrafont
   ##
      fonts()

   ##
   ##    For example....
   ##

      a <- ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point() +
                 ggtitle("Fuel Efficiency of 32 Cars") +
                 xlab("Weight (x1000 lb)") + ylab("Miles per Gallon") +
                 theme(text=element_text(size=16,  family="Elephant"))
      print(a)

      
   ##
   ##    Unfortunately, SPC fonts have to be separately loaded by library showtext
   ##
      font_paths(paste0(getwd(), "/R"))
      font_add(family = "MyriadPro-Bold",        regular = "/R/MYRIADPRO-BOLD.OTF")
      font_add(family = "MyriadPro-Light",       regular = "/R/MyriadPro-Light.OTF")
      font_add(family = "MyriadPro-Regular",     regular = "/R/MYRIADPRO-REGULAR.OTF")
      font_add(family = "MyriadPro-BoldItalics", regular = "/R/MYRIADPRO-BOLDCONDIT.OTF")
      font_add(family = "MyriadPro-Italics",     regular = "/R/MYRIADPRO-CONDIT.OTF")

   ##
   ##    TURN R OFF AND ON AGAIN!!!
   ##

   ##
   ##    To use the SPC fonts, we need to turn library showtext on
   ##       ... like this ...
   ##
   ##    And to go back to windows fonts, we need to turn showtext off
   ##
      showtext_begin()
      
      ##
      ##    In ggplot with SPC Fonts
      ##
         a <- ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point() +
                     ggtitle("Fuel Efficiency of 32 Cars") +
                     xlab("Weight (x1000 lb)") + 
                     ylab("Miles per Gallon") +
                     theme(text=element_text(size=16,  family="MyriadPro-Light"))
         print(a)
      showtext_end()
 
   ##
   ##    Close SPC Fonts, and now we use windows fonts, again
   ##       ... like this ...

      a <- ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point() +
                  ggtitle("Fuel Efficiency of 32 Cars") +
                  xlab("Weight (x1000 lb)") + 
                  ylab("Miles per Gallon") +
                  theme(text=element_text(size=16,  family= "Ink Free"))
      print(a)
##
##   End of programme
##
