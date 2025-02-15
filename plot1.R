library(data.table)

data<-fread("household_power_consumption.txt", sep= ";",na.strings = "?")#reading into R

data$Date <- as.Date(data$Date, format="%d/%m/%Y")#changing char to numeric 

useful_data <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")#filtering for dates 

# creating plot using filtered data

png("plot1.png", width=480, height=480)

hist(useful_data$Global_active_power,
     col="red",
     xlab="Global Active Power(kilowatts)",ylab="Frequency",
     main="Global Active Power")

dev.off()

