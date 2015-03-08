library(lubridate)

#encapsulating actual plot function
plot4 <- function(x, y1, y2, y3.1, y3.2, y3.3, y4){
                        
        par(mfrow = c(2,2))
        
        #top left
        plot(x, y1, type="l", xlab="", ylab="Global Active Power")   
        
        #top right
        plot(x, y2, type="l", xlab="datatime", ylab="Voltage")   
        #bottom left
        plot(x, y3.1, type="n", xlab="", ylab="Energy sub metering")
        lines(x, y3.1, col = "black")
        lines(x, y3.2, col = "red")
        lines(x, y3.3, col = "blue")
        legend("topright", 
               col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               lty= c(1,1), bty="n" )
        
        #bottom right        
        plot(x, y4, type="l", xlab="datatime", ylab="Global_reactive_power")
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

png("plot4.png", width=480, height=480, res=72, bg = "transparent")

plot4(subData$Date, subData$Global_active_power, subData$Voltage, subData$Sub_metering_1, subData$Sub_metering_2, subData$Sub_metering_3, subData$Global_reactive_power)

dev.off()

plot4(subData$Date, subData$Global_active_power, subData$Voltage, subData$Sub_metering_1, subData$Sub_metering_2, subData$Sub_metering_3, subData$Global_reactive_power)
