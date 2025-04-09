##
##    Programme:  Make_Pictures.r
##
##    Objective:  What is this programme designed to do?
##
##    Author:     <PROGRAMMER>, <TEAM>, <DATE STARTED>
##    Peer Review:<PROGRAMMER>, <TEAM>, <DATE STARTED>
##
##
   ##
   ##    Clear the memory
   ##
      rm(list=ls(all=TRUE))
   ##
   ##    Load some generic functions or colour palattes, depending on what you're doing.
   ##
      source("R/themes.r")
   ##
   ##    Load data from somewhere
   ##
      load('Data_Intermediate/Demographics.rda')
      load('Data_Intermediate/Prevalence.rda')
      load('Data_Intermediate/Labour_Force.rda')
      load('Data_Intermediate/Education.rda')
                     
   ##
   ## Step 1: Demographics
   ##

      showtext_auto()
      ggplot() +
        geom_col(data=Demographics,
                 aes(factor(Age_Group, level = Demographics$Age_Group[1:8]), Population, fill= Sex), 
                 col='black', 
                 position = position_dodge(),
                 alpha = 0.8,
                 linewidth=0.1) +
        facet_wrap(. ~ factor(Measure, level = c("With Disability", "Without Disability")),scales = "free", ncol = 1) +
        ylab("Population") +
        xlab("Age Group") +
        scale_fill_manual(values = SPCColours(c("Gold", "Purple")), name="") + 
        scale_y_continuous(labels = comma) +
         
         theme_bw(base_size=18, base_family =  "Calibri") %+replace%
         theme(legend.title.align=0.5,
             plot.margin = unit(c(2,2,2,2),"mm"),
             panel.grid = element_blank(), #try to remove the grid
             panel.border = element_blank(),
             strip.background =  element_rect(fill   = SPCColours("Light_Blue")),
             strip.text = element_text(colour = "white", 
                                       family = "MyriadPro-Regular",
                                       size =  25,
                                       margin = margin(1.25,1.25,1.25,1.25, unit = "mm")),
             panel.spacing = unit(1, "lines"),                                              
             legend.text   = element_text(size = 18,colour = SPCColours("Dark_Blue"), family = "MyriadPro-Regular"),
             #plot.background = element_rect(fill = NULL, color = "White"),
             plot.title    = element_text(colour = SPCColours("Dark_Blue"),  family = "MyriadPro-Light"),
             plot.subtitle = element_text(colour = SPCColours("Light_Blue"), family = "MyriadPro-Light"),
             plot.caption  = element_text(colour = SPCColours("Dark_Blue"), family = "MyriadPro-Light", hjust = 1.0),
             plot.tag      = element_text(colour = SPCColours("Red")),
             axis.title    = element_text(size = 20,colour = SPCColours("Dark_Blue")),
             axis.text.x   = element_text(size = 18,colour = SPCColours("Dark_Blue"), angle = 00),
             axis.text.y   = element_text(size = 18,colour = SPCColours("Dark_Blue"), angle = 00),
             legend.key.width = unit(1, "cm"),
             legend.spacing.y = unit(1, "cm"),
             legend.margin = margin(0, 0, 0, 0),
             legend.position  = "bottom")
    ggsave("Graphical_Output/Demographics.png", height =(0.75*16.13), width = (0.75*20.66), dpi = 265, units = c("cm"))

   ##
   ## Step 2: Prevalence
   ##

      showtext_auto()
      ggplot() +
        geom_col(data=Prevalence,
                 aes(factor(Age_Group, level = Age_Group[1:8]), Proportion), 
                 col='black', 
                 fill = SPCColours("Gold"),
                 alpha = 0.8) +
        labs(y = "Proportion of Population\nDisabled",
             x = "Age Group") +
        scale_y_continuous(labels = comma) +
         
         theme_bw(base_size=12, base_family =  "Calibri") %+replace%
         theme(legend.title.align=0.5,
             plot.margin = unit(c(2,2,2,2),"mm"),
             panel.border = element_blank(),
             strip.background =  element_rect(fill   = SPCColours("Light_Blue")),
             strip.text = element_text(colour = "white", 
                                       family = "MyriadPro-Regular",
                                       size =  25,
                                       margin = margin(1.25,1.25,1.25,1.25, unit = "mm")),
             panel.spacing = unit(1, "lines"),                                              
             legend.text   = element_text(size = 18,colour = SPCColours("Dark_Blue"), family = "MyriadPro-Regular"),
             plot.title    = element_text(colour = SPCColours("Dark_Blue"),  family = "MyriadPro-Light"),
             plot.subtitle = element_text(colour = SPCColours("Light_Blue"), family = "MyriadPro-Light"),
             plot.caption  = element_text(colour = SPCColours("Dark_Blue"), family = "MyriadPro-Light", hjust = 1.0),
             plot.tag      = element_text(colour = SPCColours("Red")),
             axis.title    = element_text(size = 20,colour = SPCColours("Dark_Blue"), ),
             axis.text.x   = element_text(size = 18,colour = SPCColours("Dark_Blue"), angle = 00),
             axis.text.y   = element_text(size = 18,colour = SPCColours("Dark_Blue"), angle = 00),
             legend.key.width = unit(1, "cm"),
             legend.spacing.y = unit(1, "cm"),
             legend.margin = margin(0, 0, 0, 0),
             legend.position  = "bottom")
   ggsave("Graphical_Output/Prevalence.png", height =(0.45*16.13), width = (0.65*20.66), dpi = 265, units = c("cm"))


   ##
   ## Step 3: Education
   ##

      showtext_auto()
      ggplot() +
        geom_col(data=Education,
                 aes(factor(`Highest Level`, level = c("other","Post-secondary & Tertiary", "Secondary school", "Primary school")), Proportion, fill=factor(Measure, level = c("With disability", "Without disability","Total"))), 
                 position = position_dodge(),
                 col='black', 
                 alpha = 0.8) +
        coord_flip() +
        scale_fill_manual(values = SPCColours(c("Gold", "Purple", "Green")), name="") + 
        labs(y = "Proportion of Population Disabled",
             x = "Schooling") +
        
         theme_bw(base_size=12, base_family =  "Calibri") %+replace%
         theme(legend.title.align=0.5,
             plot.margin = unit(c(2,2,2,2),"mm"),
             panel.border = element_blank(),
             strip.background =  element_rect(fill   = SPCColours("Light_Blue")),
             strip.text = element_text(colour = "white", 
                                       family = "MyriadPro-Regular",
                                       size =  25,
                                       margin = margin(1.25,1.25,1.25,1.25, unit = "mm")),
             panel.spacing = unit(1, "lines"),                                              
             legend.text   = element_text(size = 20,colour = SPCColours("Dark_Blue"), family = "MyriadPro-Regular", hjust = 1.0),
             plot.title    = element_text(colour = SPCColours("Dark_Blue"),  family = "MyriadPro-Light"),
             plot.subtitle = element_text(colour = SPCColours("Light_Blue"), family = "MyriadPro-Light"),
             plot.caption  = element_text(colour = SPCColours("Dark_Blue"), family = "MyriadPro-Light", hjust = 1.0),
             plot.tag      = element_text(colour = SPCColours("Red")),
             axis.title    = element_text(size = 20,colour = SPCColours("Dark_Blue"), ),
             axis.text.x   = element_text(size = 18,colour = SPCColours("Dark_Blue"), angle = 00),
             axis.text.y   = element_text(size = 18,colour = SPCColours("Dark_Blue"), angle = 00),
             legend.key.width = unit(1, "cm"),
             legend.spacing.y = unit(1, "cm"),
             legend.margin = margin(0, 0, 0, 0),
             legend.position  = "bottom")
   ggsave("Graphical_Output/Education.png", height =(0.45*16.13), width = (0.65*20.66), dpi = 265, units = c("cm"))



   ##
   ## Step 4: Labour Force
   ##

      showtext_auto()
      ggplot() +
        geom_col(data=Labour_Force,
                 aes(factor(`Labour Force Status`, level = c("Employees","Own-account workers", "Others (contributing family workers)", "Employers")), 
                            Population, 
                            fill=factor(`Labour Force Status`, level = c("Employees","Own-account workers", "Others (contributing family workers)", "Employers"))), 
                 position = position_dodge(),
                 col='black', 
                 alpha = 0.8) +
        coord_flip() +
        facet_wrap(. ~ factor(Measure, level = c("Without Disability", "With Disability")),scales = "free", ncol = 1) +
        scale_fill_manual(values = SPCColours(c("Gold", "Purple", "Green", "Red")), name="") + 
        labs(x = "Labour Force Status Disabled",
             y = "Population") +
        
         theme_bw(base_size=12, base_family =  "Calibri") %+replace%
         theme(legend.title.align=0.5,
             plot.margin = unit(c(2,2,2,2),"mm"),
             panel.border = element_blank(),
             strip.background =  element_rect(fill   = SPCColours("Light_Blue")),
             strip.text = element_text(colour = "white", 
                                       family = "MyriadPro-Regular",
                                       size =  25,
                                       margin = margin(1.25,1.25,1.25,1.25, unit = "mm")),
             panel.spacing = unit(1, "lines"),                                              
             legend.text   = element_text(size = 20,colour = SPCColours("Dark_Blue"), family = "MyriadPro-Regular", hjust = 1.0),
             plot.title    = element_text(colour = SPCColours("Dark_Blue"),  family = "MyriadPro-Light"),
             plot.subtitle = element_text(colour = SPCColours("Light_Blue"), family = "MyriadPro-Light"),
             plot.caption  = element_text(colour = SPCColours("Dark_Blue"), family = "MyriadPro-Light", hjust = 1.0),
             plot.tag      = element_text(colour = SPCColours("Red")),
             axis.title    = element_text(size = 20,colour = SPCColours("Dark_Blue"), ),
             axis.text.x   = element_text(size = 18,colour = SPCColours("Dark_Blue"), angle = 00),
             axis.text.y   = element_text(size = 18,colour = SPCColours("Dark_Blue"), angle = 00, hjust = 1.0),
             legend.key.width = unit(1, "cm"),
             legend.spacing.y = unit(1, "cm"),
             legend.margin = margin(0, 0, 0, 0),
             legend.position  = "none")
   ggsave("Graphical_Output/Labour_Force.png", height =(0.75*16.13), width = (0.75*20.66), dpi = 265, units = c("cm"))




##
##    And we're done
##
