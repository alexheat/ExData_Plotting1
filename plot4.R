library(dplyr)

#Read the rows that correspond to the right dates
power.df <- read.table("household_power_consumption.txt",sep=";", header=TRUE, skip=66637, nrows = 2880)
#Read and assign the collumn names 
power.names <- read.table("household_power_consumption.txt",nrows = 1,sep=";", stringsAsFactors = FALSE)
power.df <- setNames(power.df,power.names[1,])

#Combine Date & Time into one variable 
power.df$Date <- strptime(paste(power.df$Date,power.df$Time),format="%d/%m/%Y %H:%M:%S")
power.df <- rename(power.df, DateTime = Date)
power.df <- select(power.df, -Time)

#Render chart and save and PNG
png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")

par(mfrow = c(2, 2))
plot(power.df$DateTime, power.df$Global_active_power, type="l", xlab="", ylab="Global Active Power")

plot(power.df$DateTime, power.df$Voltage, type="l", xlab="datetime", ylab="Voltage")


plot(power.df$DateTime, power.df$Sub_metering_1, type="l", xlab="", ylab="Energy Sub Metering")
lines(power.df$DateTime, power.df$Sub_metering_2,  col = "red")
lines(power.df$DateTime, power.df$Sub_metering_3,  col = "blue")
legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),col=c("black", "blue","red"), lty=c(1,1,1),???lwd=1.5, bty="n")

plot(power.df$DateTime, power.df$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off() 
