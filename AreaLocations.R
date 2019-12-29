library(stringr)

#Read in group data from SQL database (saved as csv)
data <- read.csv('~/git/DLR/loadprofiles/AllGroups.csv', header = TRUE, col.names = c('GroupID','GroupName','Description','ContextID','ParentID','lock'))

#Extract year information from data
data$Year <- sapply(X = data$GroupName, function(x) str_extract(x, "[[:digit:]]+"))

#Extract area information from 
data$Area <- sapply(data$GroupName, function(x) str_replace(str_extract_all(x, "([ ].[A-Za-z -]+)"), " ", ""))

#Read in Cape Town municipal places file
places <- read.csv('~/git/DLR/loadprofiles/DLR_Groups_01022017.csv')

all_areas <- merge(data, places, by.x = 1, by.y = 1)
all_areas <- all_areas[,c('GroupID','Year','Area','TLC','X','Y','MainPlace','Municipality','District','Province')]
