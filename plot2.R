library(lubridate)

#encapsulating actual plot function
plot2 <- function(x, y){
        plot(x, y, type="l", xlab="", ylab="Global Active Power (kilowatts)")       
}

message("Downloading file")

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "powerconsumption.zip")

message("Unarchiving")

unzip(zipfile = "powerconsumption.zip", exdir="powerconsumption")

message("Reading data")

data <- read.table("powerconsumption/household_power_consumption.txt", sep = ";", header = T, na.strings = "?")

message("Parsing date")

data$Date  <- dmy(data$Date)

message("Subsetting by date")

subData  <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02", ]

subData$Date  <- subData$Date + hms(subData$Time)

subData$Time <- NULL

message("Saving to file")


# Note, I'm not printing on screen and then using dev.copy as it seems that background transparency cannot be
# applied to the png file using dev.copy

png("plot2.png", width=480, height=480, res=72, bg = "transparent")

plot2(subData$Date, subData$Global_active_power)

dev.off()

plot2(subData$Date, subData$Global_active_power)
