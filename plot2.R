#-----------------------------------------------------------------
# plot2.R - plot Global Active Power versus time from the
# Individual Household Electric Power Consumption data set
#-----------------------------------------------------------------

#
# load the original data
#

df <- read.csv( 'household_power_consumption.txt', sep=';', 
   colClasses=c('character', 'character', 'character', 'character', 
                'character', 'character', 'character', 'character', 
                'character') );


#
# extract and massage the desired subset
#

df$Date <- as.Date( df$Date, '%d/%m/%Y' );

dfs <- subset( subset( df, 
                           Date <= as.Date('2007-02-02')), 
                           Date >= as.Date('2007-02-01') );   # TODO: can compound conditon?

dfs$Global_active_power <- as.numeric(dfs$Global_active_power);
dfs$DateTime <- strptime( sprintf("%s %s", dfs$Date, dfs$Time), 
                          format="%Y-%m-%d %H:%M:%S" );


#
# plot to png
#

png( file="plot2.png", height=480, width=480, units="px" );
plot( dfs$DateTime, dfs$Global_active_power, type='n', main='', 
       ylab='Global Active Power (kilowatts)', xlab='' );
lines( dfs$DateTime, dfs$Global_active_power );
dev.off();

