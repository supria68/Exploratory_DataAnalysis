# Reading the data, and treat ? as missing data
data <- read.csv('household_power_consumption.txt', header = T, sep = ';', stringsAsFactors = F, na.strings = "?")
colnames(data)

# data$Date - the date format is day / month / year
# choosing only the dates from '1/2/2007' and '2/2/2007'
selected_data <- data[data$Date %in% c('1/2/2007', '2/2/2007'), ]
head(selected_data)

# --------------------- Plot - 1 
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(selected_data$Global_active_power, col = 'red', xlab = 'Global Active Power (kilowatts)', main = 'Global Active Power')
dev.off()

# --------------------- Plot - 2
# Get datatime column in coverted format
selected_data$datetime <- strptime( paste(selected_data$Date, selected_data$Time), format = "%d/%m/%Y %H:%M:%S") 
png(filename = "plot2.png", width = 480, height = 480, units = "px")
with(selected_data, plot(datetime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "",))

dev.off()

#---------------------- Plot - 3
# Get the legend names directly from the header (avoid mistyping)
legend_titles <- names(selected_data)[7:9]

png(filename = "plot3.png", width = 480, height = 480, units = "px")
# Make the base plot, and add extra lines.
with(selected_data, plot(datetime, Sub_metering_1, type='l', col='black', ylab = 'Energy sub metering', xlab=''))
with(selected_data, lines(datetime, Sub_metering_2, type='l', col='red'))
with(selected_data, lines(datetime, Sub_metering_3, type='l', col='blue'))
legend("topright",pch = 1, col=c('black','red','blue'), legend = legend_titles)

dev.off()

# --------------------- Plot - 4
png(filename = "plot4.png", width = 480, height = 480, units = "px")

par(mfrow=c(2,2))
with(selected_data, {
  plot(datetime, Global_active_power, type = 'l', ylab='Global Active Power', xlab='')
  plot(datetime, Voltage, type = 'l')
  
  # This is plot 3, with multiple lines on plot
  plot(datetime, Sub_metering_1, type='l', col='black', ylab = 'Energy sub metering', xlab='')
  lines(datetime, Sub_metering_2, type='l', col='red')
  lines(datetime, Sub_metering_3, type='l', col='blue')
  legend("topright",pch = 1, col=c('black','red','blue'), 
         legend = c('Sub_metering_1','Sub_metering_2', 'Sub_metering_3'), bty='n')
  
  
  plot(datetime, Global_reactive_power, type = 'l')  
})

dev.off()
