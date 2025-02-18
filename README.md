# R_Fundamentals_Training
Welcome to R! This project is designed to give you the basic fundamentals in R for the Statistics for Development Division of SPC

## Software Prerequestions
Download and install the software in this order:

1. The latest version of Rtools here: https://cloud.r-project.org/
2. The latest version of R from here: https://cloud.r-project.org/
3. Notepad++ from here: https://notepad-plus-plus.org/downloads/
4. Miktek from here: https://miktex.org/howto/download-miktex
5. Pandoc from here: https://pandoc.org/
6. ImageMagik from here: https://imagemagick.org/script/download.php#windows
7. Git (64 bit windows version) from here: https://git-scm.com/downloads/win

## FRESH R SET UP Code
R is like a new baby when its first installed. Copy and paste the following code EXACTLY as is. This will take a few hours, and prompt you a copy of times for answers to different questions.

```{r }
install.packages("ctv")
library(ctv)
install.views("Bayesian")
install.views("CausalInference")
install.views("Cluster")
install.views("Databases")
install.views("Distributions")
install.views("DynamicVisualizations")
install.views("Econometrics")
install.views("Environmetrics")
install.views("ExperimentalDesign")
install.views("ExtremeValue")
install.views("GraphicalModels")
install.views("HighPerformanceComputing")
install.views("MachineLearning")
install.views("MissingData")
install.views("MixedModels")
install.views("ModelDeployment")
install.views("NaturalLanguageProcessing")
install.views("NumericalMathematics")
install.views("OfficialStatistics")
install.views("Optimization")
install.views("Psychometrics")
install.views("ReproducibleResearch")
install.views("Robust")
install.views("Spatial")
install.views("Survival")
install.views("TimeSeries")
install.views("Tracking")
install.views("WebTechnologies")
install.views("ActuarialScience")
install.views("Hydrology")
devtools::install_github("omegahat/RDCOMClient")
```
If you want to know what functionality each of these commands is loading, look here: https://cran.r-project.org/web/views/



## Clone your own Repo
In the instructions below, "FirstnameLastnameVersion" is your first name, and your last name put together. Secondly, GIT is case-sensistive so "git add -a" is different from "git add -A".

#### Time to make a git clone of this repo.
1. Find a place on your c drive - NOT ON YOUR ONEDRIVE (yes, I shouted. A local copy, not a cloud copy,  is really important) - where you are going to save all of your GIT work. For example, I have an area called "C:\From BigDisk\GIT"
2. Open gitbash and change directory to that choosen location in 1.a (cd "C:\From BigDisk\GIT") 
3. Clone the repo: git clone https://github.com/PacificCommunity/R_Fundamentals_Training.git
4. Move to that new location (cd "C:\From BigDisk\GIT\R_Fundamentals_Training")
5. Make a new branch for you (git branch FirstnameLastnameVersion)
6. Check out new branch (git checkout FirstnameLastnameVersion)
7. Add all of the files (git add -A)
8. Do an initial commit (git commit -m "Initial commit")
9. Push your new branch back into GitHub (git push --set-upstream origin FirstnameLastnameVersion)
   



