input <- "../household_power_consumption.txt"
in_sep <- ";"
in_na <- "?"
in_dateFormat <- "%d/%m/%Y"
in_datetimeFormat <- "%d/%m/%Y %H:%M:%S"
in_colClasses = c("character", "character", rep('numeric', 7))

output <- "plot2.png"
out_width <- 480
out_height <- 480

data <- read.csv(file=input, header=T, sep=in_sep, 
                 na.string=in_na, colClasses=in_colClasses)

col_filter1 <- c("Date", "Time", "Global_active_power")
data <- data[, col_filter1]

col_filter2 <- c("datetime", "Global_active_power")
data$datetime <- as.POSIXct(paste(data$Date, data$Time, sep = " "), format = in_datetimeFormat)
data <- data[, col_filter2]

date_min = as.POSIXct("2007-02-01", format="%Y-%m-%d")
date_max = as.POSIXct("2007-02-03", format="%Y-%m-%d")
row_filter <- (data$datetime >= date_min) & (data$datetime < date_max)
data <- data[row_filter, ]

graph_title <- ""
graph_x_title <- ""
graph_y_title <- "Global Active Power (kilowatts)"

png(filename=output, width=out_width, height=out_height)
plot(data$datetime, data$Global_active_power, 
     main=graph_title, xlab=graph_x_title, ylab=graph_y_title, 
     type="n")
lines(data$datetime, data$Global_active_power)
dev.off()