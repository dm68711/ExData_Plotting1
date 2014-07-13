#-----------------------------------------------------------------
# plot1.R - plot Global Active Power versus Frequency from the
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
                           Date >= as.Date('2007-02-01') );

dfs$Global_active_power <- as.numeric( dfs$Global_active_power );


#
# plot to png
#

png( file="plot1.png", height=480, width=480, units="px" );
hist( dfs$Global_active_power, col='Red', main='Global Active Power', 
      xlab='Global Active Power (kilowatts)', ylab='Frequency' );
dev.off();


