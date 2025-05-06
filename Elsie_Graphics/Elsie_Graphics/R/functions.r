##    Programme:  functions.r
##
##    Objective:  Generic functions for doing something
##
##      Author:   
##

##
##    Put functions in here
##
st_rotate <- function(x){
  x2 <- (sf::st_geometry(x) + c(360,90)) %% c(360) - c(0,90) 
  x3 <- sf::st_wrap_dateline(sf::st_set_crs(x2 - c(180,0), 4326)) + c(180,0)
  x4 <- sf::st_set_crs(x3, 4326)
  
  x <- sf::st_set_geometry(x, x4)
  
  return(x)
}

# Function to extract lon and lat from the geometry listcol
# From https://github.com/r-spatial/sf/issues/231#issuecomment-290817623

sfc_as_cols <- function(x, names = c("lon","lat")) {
  ret <- sf::st_coordinates(x)
  ret <- tibble::as_tibble(ret)
  x <- x[ , !names(x) %in% names]
  ret <- setNames(ret,names)
  dplyr::bind_cols(x,ret)
}

##
##    List of iso_codes that define the Pacific Island Countries
##
   iso_codes <- c("KIR","ASM","COK","FSM","MHL","NRU","PNG","SLB","TKL","TUV","UMI","FJI","NIU","TON","WSM","WLF","VUT","NCL","PLW","IDN")

##
##   Who are the Parties to the Nauru Agreement
##
   PNA_codes <- c("FSM", "KIR", "MHL", "NRU", "PLW", "PNG", "SLB", "TUV", "TKL")





   
   


