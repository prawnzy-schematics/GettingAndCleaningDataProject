
library(data.table)

data <- fread("household_power_consumption.txt", sep=";", na.strings="?")

# Convert Date column to Date format
data[, Date := as.Date(Date, format="%d/%m/%Y")]

# Filter for the required dates
useful_data <- data[Date >= "2007-02-01" & Date <= "2007-02-02"]

# Combine Date and Time into a proper Date-Time format
DateTime <- as.POSIXct(paste(useful_data$Date, useful_data$Time), format="%Y-%m-%d %H:%M:%S")

# Convert variables to numeric
Global_active_power <- as.numeric(useful_data$Global_active_power)
Sub_metering_1 <- as.numeric(useful_data$Sub_metering_1)
Sub_metering_2 <- as.numeric(useful_data$Sub_metering_2)
Sub_metering_3 <- as.numeric(useful_data$Sub_metering_3)


png("plot4.png",width=480,height=480)
par(mfrow=c(2,2))

plot(DateTime, Global_active_power, type="l",xlab="",ylab="Global Active Power")
plot(DateTime, useful_data$Voltage, type="l",xlab="datetime",ylab="voltage")


plot(DateTime, Sub_metering_1, type="l", ylab="Energy Sub metering", xlab="")
lines(DateTime, Sub_metering_2, type="l", col="red")
lines(DateTime, Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1, lwd=2, col=c("black", "red", "blue"),cex = 0.75)

plot(DateTime, useful_data$Global_reactive_power,type='l', xlab="datetime",ylab="Global_reactive_power")


dev.off()
