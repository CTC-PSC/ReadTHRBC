##########################################################################################
##                                                                                      ##
## This script reads a thrb or thrb produced from Coshak The data frame "x" contains    ##
## age-specific exploitation rates in the thrb file.                                    ## 
##                                                                                      ##
##########################################################################################  

# ----------------------------------------------------------------------------------------

readTHRBC <- function(directory, file) { 

  stock <- substr(file, 1, 3)
  fileType <- substr(file, 4, 7)

  x <- NULL

  lines <- readLines(file)
  startLines <- grep("Age", lines)
  nLines <- diff(startLines)[1]
  ages <- gsub(pattern="\"", replacement="", x=lines[startLines])
  ages[ages == "Age 5 and 6 combined into age 5"] <- "Age 5"
  ages[ages == "Age 2 and 3 combined into age 3"] <- "Age 3"


  for(i in 1:length(ages)) { 
  
    temp <- read.csv(file, skip=startLines[i], nrow=nLines-2, header=FALSE)[,c(1,3,5,7)]
    names(temp) <- c("by","totOceanMort","totTermMort","totMort")
    temp$age <- ages[i]
    temp$stock <- stock
    x <- rbind(x, temp)

  } 

  return(x)

}


# --------------------------------------------------------------------------------------------------------

# Test 
  # wd <- "C:\\Users\\gart\\Desktop\\"
  # readTHRBC(wd, "WSHTHRC.CSV")
  # readTHRBC(wd, "WRYTHRC.CSV")
  # readTHRBC(wd, "STLTHRC.CSV")

# -----------------------------------------------------------------------------------------





