input <- "../household_power_consumption.txt"
in_sep <- ";"
in_na <- "?"
in_dateFormat <- "%d/%m/%Y"
in_colClasses = c("character", "character", rep('numeric', 7))

output <- "plot1.png"
out_width <- 480
out_height <- 480

data <- read.csv(file=input, header=T, sep=in_sep, 
                 na.string=in_na, colClasses=in_colClasses)

col_filter1 <- c("Date", "Global_active_power")
data <- data[, col_filter1]
data$Date <- as.Date(data$Date, format=in_dateFormat)

date_min = as.Date("2007-02-01")
date_max = as.Date("2007-02-03")

row_filter <- (data$Date >= date_min) & (data$Date < date_max)
data <- data[row_filter, ]

graph_title <- "Global Active Power"
graph_x_title <- "Global Active Power (kilowatts)"
graph_y_title <- "Frequency"
graph_col_color <- 552 #red

png(filename=output, width=out_width, height=out_height)
hist(data$Global_active_power, 
     main=graph_title, xlab=graph_x_title, ylab=graph_y_title, 
     col="red")
dev.off()
