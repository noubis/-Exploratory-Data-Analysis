readProjectData <- function() {
dta <- read.delim(unzippedDataFile, sep = ";", na.strings="?", 
stringsAsFactors = FALSE) 

- # Combine date and time into one column 
- dta$DateTime <- strptime(paste(dta$Date, dta$Time), 
- format="%d/%m/%Y %H:%M:%S") 
- dta$DateTime <- as.POSIXct(dta$DateTime) 
- 
# Create a formatted date column 
dta$DateObj <- as.Date(dta$Date, format="%d/%m/%Y") 

# Get only the subset we want 
dta <- subset(dta, "2007-02-01" <= DateObj & DateObj <= "2007-02-02") 
+ 
+ # Combine date and time into one column. 
+ # Do this after subsetting because it'll be a little faster. 
+ dta$DateTime <- strptime(paste(dta$Date, dta$Time), 
+ format="%d/%m/%Y %H:%M:%S") 
+ dta$DateTime <- as.POSIXct(dta$DateTime) 
+ 
+ # Force to be in correct date and time order. We could assume that 
+ # data is in order, which it appears to be, but often it's better 
+ # to be on the safe side. This could be excluded if the data is known 
+ # for sure to be in order and this takes too long. 
+ dta <- dta[order(dta$DateTime),] 
dta 
} else { 
stop(paste("download and unzip", rawDataFile, "first")) 



