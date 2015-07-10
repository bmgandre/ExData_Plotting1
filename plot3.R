input <- "../household_power_consumption.txt"
in_sep <- ";"
in_na <- "?"
in_dateFormat <- "%d/%m/%Y"
in_datetimeFormat <- "%d/%m/%Y %H:%M:%S"
in_colClasses = c("character", "character", rep('numeric', 7))

output <- "plot3.png"
out_width <- 480
out_height <- 480

data <- read.csv(file=input, header=T, sep=in_sep, 
                 na.string=in_na, colClasses=in_colClasses)

col_filter1 <- c("Date", "Time", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
data <- data[, col_filter1]

col_filter2 <- c("datetime", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
data$datetime <- as.POSIXct(paste(data$Date, data$Time, sep = " "), format = in_datetimeFormat)
data <- data[, col_filter2]

date_min = as.POSIXct("2007-02-01", format="%Y-%m-%d")
date_max = as.POSIXct("2007-02-03", format="%Y-%m-%d")
row_filter <- (data$datetime >= date_min) & (data$datetime < date_max)
data <- data[row_filter, ]

graph_title <- ""
graph_x_title <- ""
graph_y_title <- "Energy sub metering"

png(filename=output, width=out_width, height=out_height)
plot(data$datetime, data$Sub_metering_1, 
     main=graph_title, xlab=graph_x_title, ylab=graph_y_title, 
     type="n")
lines(data$datetime, data$Sub_metering_1, col="black")
lines(data$datetime, data$Sub_metering_2, col="red")
lines(data$datetime, data$Sub_metering_3, col="blue")
legend("topright", pch="-", lwd=2, 
       col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_1"))
dev.off()