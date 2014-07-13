#-----------------------------------------------------------------
# plot2.R - plot Global Active Power versus time from the
# Individual Household Electric Power Consumption data set
#-----------------------------------------------------------------

library(sqldf)


#
# Load the original data. Use read.csv2.sql to only load the desired
# records into memory, thereby reducing memory usage.
#

myFile <- "./household_power_consumption.txt"
mySql <- "SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'"
df <- read.csv2.sql(myFile,mySql)


#
# Extract and massage the desired subset ... this was necessary
# when using read.csv to read in the entire data set, harmless
# to leave this in now that we're using read.csv2.sql (overhead
# is negligible).
#

df$Date <- as.Date( df$Date, '%d/%m/%Y' );

dfs <- subset( subset( df, 
                           Date <= as.Date('2007-02-02')), 
                           Date >= as.Date('2007-02-01') );

dfs$Global_active_power <- as.numeric(dfs$Global_active_power);
dfs$DateTime <- strptime( sprintf("%s %s", dfs$Date, dfs$Time), 
                          format="%Y-%m-%d %H:%M:%S" );


#
# Plot to png.
#

png( file="plot2.png", height=480, width=480, units="px" );
plot( dfs$DateTime, dfs$Global_active_power, type='n', main='', 
       ylab='Global Active Power (kilowatts)', xlab='' );
lines( dfs$DateTime, dfs$Global_active_power );
dev.off();

