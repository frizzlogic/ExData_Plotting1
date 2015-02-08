#read data
file.source <- "household_power_consumption.txt"
power <- read.table(file.source, header = T, sep = ";", na.strings="?", colClasses = "character")
#conversion of required variable for data exploration
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")
power_2d <- subset(power, power$Date >= "2007-02-01" & power$Date <= "2007-02-02")
power_2d$Global_active_power <- as.numeric(power_2d$Global_active_power)
#output to device
file.png <- "plot1.png"
png(file.png, width = 480, height = 480, units = "px")
with(power_2d, hist(Global_active_power, 
                        col="orangered",
                        main = "Global Active Power",
                        xlab = "Global Active Power (kilowatts)",
                        ylab = "Frequency"))
dev.off()