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
power_2d$Sub_metering_1 <- as.numeric(power_2d$Sub_metering_1)
power_2d$Sub_metering_2 <- as.numeric(power_2d$Sub_metering_2)
power_2d$Sub_metering_3 <- as.numeric(power_2d$Sub_metering_3)
#output to device
file.png <- "plot3.png"
png(file.png, width = 480, height = 480, units = "px")
with(power_2d, plot(timestamp, Sub_metering_1, type = "n", 
                                                main = "", 
                                                xlab = "", 
                                                ylab = "Energy Sub Metering"))
with(power_2d, lines(timestamp, Sub_metering_1, col = "black"))
with(power_2d, lines(timestamp, Sub_metering_2, col = "red"))
with(power_2d, lines(timestamp, Sub_metering_3, col = "blue"))
legend("topright", c("Metering1", "Metering2", "Metering3"), 
                    lty=c(1,1), 
                    lwd=c(2.5,2.5), 
                    col=c("black", "red", "blue"), 
                    cex=0.7,
                    yjust = 0)
dev.off()