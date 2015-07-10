input <- "../household_power_consumption.txt"
in_sep <- ";"
in_na <- "?"
in_dateFormat <- "%d/%m/%Y"
in_datetimeFormat <- "%d/%m/%Y %H:%M:%S"
in_colClasses = c("character", "character", rep('numeric', 7))

output <- "plot4.png"
out_width <- 480
out_height <- 480

data <- read.csv(file=input, header=T, sep=in_sep, 
                 na.string=in_na, colClasses=in_colClasses)

data$datetime <- as.POSIXct(paste(data$Date, data$Time, sep = " "), format = in_datetimeFormat)
date_min = as.POSIXct("2007-02-01", format="%Y-%m-%d")
date_max = as.POSIXct("2007-02-03", format="%Y-%m-%d")
row_filter <- (data$datetime >= date_min) & (data$datetime < date_max)
data <- data[row_filter, ]

png(filename=output, width=out_width, height=out_height)
par(mfrow=c(2, 2))

# plot1
p1_title <- ""
p1_x_title <- ""
p1_y_title <- "Global Active Power"
plot(data$datetime, data$Global_active_power, 
     main=p1_title, xlab=p1_x_title, ylab=p1_y_title, 
     type="n")
lines(data$datetime, data$Global_active_power)

# plot2
p2_title <- ""
p2_x_title <- "datetime"
p2_y_title <- "Voltage"
plot(data$datetime, data$Voltage, 
     main=p2_title, xlab=p2_x_title, ylab=p2_y_title, 
     type="n")
lines(data$datetime, data$Voltage)

# plot3
p3_title <- ""
p3_x_title <- ""
p3_y_title <- "Energy sub metering"
plot(data$datetime, data$Sub_metering_1, 
     main=p3_title, xlab=p3_x_title, ylab=p3_y_title, 
     type="n")
lines(data$datetime, data$Sub_metering_1, col="black")
lines(data$datetime, data$Sub_metering_2, col="red")
lines(data$datetime, data$Sub_metering_3, col="blue")
legend("topright", pch="-", lwd=2, 
       col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_1"))

# plot4
p4_title <- ""
p4_x_title <- "datetime"
p4_y_title <- "Global_reactive_power"
plot(data$datetime, data$Global_reactive_power, 
     main=p4_title, xlab=p4_x_title, ylab=p4_y_title, 
     type="n")
lines(data$datetime, data$Global_reactive_power)
dev.off()