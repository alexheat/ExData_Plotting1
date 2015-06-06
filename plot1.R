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
hist(power.df$Global_active_power, col = "red", main="Global Active Power", xlab = "Global Active Power (kilowatts)") 
png(filename = "plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")
hist(power.df$Global_active_power, col = "red", main="Global Active Power", xlab = "Global Active Power (kilowatts)") 
dev.off()
