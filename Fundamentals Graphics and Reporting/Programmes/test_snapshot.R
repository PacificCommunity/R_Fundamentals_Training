test <- data.frame(country = c("CK","KI","FJ","TO"),
                   value = c(4,6,3,2))

if(nrow(test) < 2) {

  print("Hello")  
  
} else {
  
  print("Goodbye")
  
}

if(nrow(test) < 5) {
  
  print("Hello")  
  
} else {
  
  print("Goodbye")
  
}
