#read data
file.source <- "household_power_consumption.txt"
power <- read.table(file.source, header = T, sep = ";", na.strings="?", colClasses = "character")
#selecting required data for exploration
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")
power_2d <- subset(power, power$Date >= "2007-02-01" & power$Date <= "2007-02-02")
#combine date and time variables
power_2d$timestamp <- with(power_2d, format(as.POSIXct(paste(as.character(Date), Time)), "%Y-%m-%d %H:%M:%S"))
power_2d$timestamp <- strptime(power_2d$timestamp, format = "%Y-%m-%d %H:%M:%S")
#conversion of variables
power_2d$Global_active_power <- as.numeric(power_2d$Global_active_power)
#output to device
file.png <- "plot2.png"
png(file.png, width = 480, height = 480, units = "px")
with(power_2d, plot(timestamp, Global_active_power, type = "l", 
                                                    main = "", 
                                                    xlab = "", 
                                                    ylab = "Global Active Power (kilowatts)"))
dev.off()