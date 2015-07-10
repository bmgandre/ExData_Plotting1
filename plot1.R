input <- "../household_power_consumption.txt"
in_sep <- ";"
in_na <- "?"
in_dateFormat <- "%d/%m/%Y"
in_colClasses = c("myDate", "character", rep('numeric', 7))

output <- "plot1.png"
out_width <- 480
out_height <- 480

setClass("myDate")
setAs("character", "myDate",
      function(from) { 
          as.Date(from, format=in_dateFormat)
      });

data <- read.csv(file=input, header=T, sep=in_sep, 
                 na.string=in_na, colClasses=in_colClasses)

date_min = as.Date("2007-02-01")
date_max = as.Date("2007-02-02")

date_filter = c(date_min, date_max)
row_filter <- data$Date %in% date_filter
col_filter <- "Global_active_power"

data <- data[row_filter, col_filter]

graph_title <- "Global Active Power"
graph_x_title <- "Global Active Power (kilowatts)"
graph_y_title <- "Frequency"
graph_col_color <- 552 #red

png(filename=output, width=out_width, height=out_height)
hist(data, main=graph_title, xlab=graph_x_title, ylab=graph_y_title, col="red")
dev.off()
