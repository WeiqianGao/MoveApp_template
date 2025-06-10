library('move2')
# library('lubridate')

library(plyr)
library(dplyr)
library(ggplot2)
library(proj4)
library(ctmm)
library(Hmisc)

library(lubridate);
library(metafor);
library(tidyverse);
library(amt);
library(adehabitatLT);
library(adehabitatHR); 
library(move2); 
library(epitools)
library(ggpubr)

## The parameter "data" is reserved for the data object passed on from the previous app

# to display messages to the user in the log file of the App in MoveApps
# one can use the function from the logger.R file:
# logger.fatal(), logger.error(), logger.warn(), logger.info(), logger.debug(), logger.trace()

# # Showcase injecting app setting (parameter `year`)
# rFunction = function(data, sdk, year, ...) {
#   logger.info(paste("Welcome to the", sdk))
#   result <- if (any(lubridate::year(mt_time(data)) == year)) { 
#     data[lubridate::year(mt_time(data)) == year,]
#   } else {
#     NULL
#   }
#   if (!is.null(result)) {
#     # Showcase creating an app artifact. 
#     # This artifact can be downloaded by the workflow user on Moveapps.
#     artifact <- appArtifactPath("plot.png")
#     logger.info(paste("plotting to artifact:", artifact))
#     png(artifact)
#     plot(result[mt_track_id_column(result)], max.plot=1)
#     dev.off()
#   } else {
#     logger.warn("nothing to plot")
#   }
#   # Showcase to access a file ('auxiliary files') that is 
#   # a) provided by the app-developer and 
#   # b) can be overridden by the workflow user.
#   fileName <- getAuxiliaryFilePath("auxiliary-file-a")
#   logger.info(readChar(fileName, file.info(fileName)$size))
# 
#   # provide my result to the next app in the MoveApps workflow
#   return(result)
# }


rFunction <- function(data, sdk, year) {
  data <- readRDS("./data/raw/input1_move2loc_LatLon.rds")
  attributes(data)$spec <- NULL
  
  ###### Set TimeZone and Projections#####
  # **********************************************************************************************
  # **********************************************************************************************
  
  # Timezones 
  # Other timezones can be found at https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
  Timezone1 <- "UTC"
  Timezone2 <- "Africa/Nairobi"
  
  # Projections
  LatLong.proj <- "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"  # EPSG:4326
  AEA.proj <- "+proj=aea +lat_1=20 +lat_2=-23 +lat_0=0 +lon_0=25 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs" # EPSG: 102022
  
  # Read files in Data directory (Data File and Accessory File)
  # data <- readRDS(input4_move2loc_LatLon.rds)
  
  ###### Reorganize Data#####
  # *********************************************
  # *********************************************
  
  # Look at the data and examine the data structure
  head(data)
  str(data)
  
  
  ##### Time Zone Formatting######
  # *********************************************
  # *********************************************
  
  # #str(data$timestamp)
  # data$timestamp[1:24]
  # 
  # # Format the timestamp from Timezone1 (UTC) to Timezone2 (EAT)
  # data$timestamp <- as_datetime(data$timestamp)
  # data$timestamp <- as.POSIXct(data$timestamp, format = "%Y-%m-%d %H:%M:%S", tz=Timezone1)
  # attr(data$timestamp, "tzone")
  # 
  # data$timestamp <- with_tz(data$timestamp, tz=Timezone2) 
  # attr(data$timestamp, "tzone")
  # 
  # # Look at the timestamp
  # data$timestamp[1:20]
  # 
  # ##### Completeness & Duplicates#####
  # # *********************************************
  # # *********************************************
  # 
  # # Determine if any missing data
  # if(all(complete.cases(data)) == T){print("All Looking Good. No issues found")} else {
  #   print("!!! Dallas, We Have a Problem !!!")
  #   # Remove NA rows
  #   nrow(data)
  #   data <- data[complete.cases(data[,c("id","location.lat","location.long","timestamp")]),]
  #   nrow(data)
  # }
  # 
  # # Duplicated Data Points
  # if(anyDuplicated(data[,c("individual_id","timestamp")]) == F){print("No Duplicates found")} else {
  #   
  #   # Remove Duplicates
  #   print(paste0("Initial Number of Records in Dataset: ",nrow(data)))
  #   print("Removing Duplicates")
  #   data  <-  data[!duplicated(data[c('id', 'timestamp')]),] # or data <- data %>% distinct(id, timestamp)
  #   print(paste0("Number of Records after NA's removed: ",nrow(data)))
  # }
  # 
  
  datadata <- data %>%
    mutate(
      timestamp = as.POSIXct(timestamp, format = "%Y-%m-%d %H:%M:%OS"),
      Year = format(timestamp, "%Y"),
      Month = format(timestamp, "%m"),
      Date = format(timestamp, "%d"),
      Hour = format(timestamp, "%H"),
      YMD = format(timestamp, "%Y-%m-%d")
    ) 
  
  
  
}
