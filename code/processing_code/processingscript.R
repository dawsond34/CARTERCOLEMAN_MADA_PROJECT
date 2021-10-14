###############################
# processing script
#
#this script loads the raw data, processes and cleans it 
#and saves it as Rds file in the processed_data folder

#load needed packages. Install any that need to be installed.

library(readxl) 
library(dplyr) 
library(here)
library(tidyverse)
library(tidyr)
library(readr)
library(stringr)
library(naniar)
library(here)

#path to data
#note the use of the here() package and not absolute paths
data_location <- here::here("data","raw_data","UOWN_data_master_spring2021 (2).xlsx")

#load data. 
rawdata <- readxl::read_excel(data_location)

#take a look at the data
dplyr::glimpse(rawdata)

#or

print(rawdata)

#I had to do a little digging, but it looks like R has not registered values
#designated "NA" as true missing values. We will have to fix that real quick.

rawdata <- rawdata %>%
  replace_with_na(replace = list(WSID = "NA",	
                                 biological_score = "NA",	
                                 conductivity.uscm = "NA", 
                                 turbidity.ntu = "NA",	
                                 po4.mgL = "NA",	
                                 no3.mgL = "NA",	
                                 pH = "NA",	
                                 temperature.c = "NA",	
                                 e.coli.cfu = "NA",	
                                 month = "NA",	
                                 year = "NA",	
                                 day = "NA"))

#Let's do some cleaning. First we need to grab the variables we want to work with.
data_cleaning <- rawdata %>%
  select("WSID",	
         "biological_score",	
         "conductivity.uscm", 
         "turbidity.ntu",	
         "po4.mgL",	"no3.mgL",	
         "pH",	
         "temperature.c",	
         "e.coli.cfu",	
         "month",	
         "year",	
         "day")

glimpse(data_cleaning)

#There is 3,075 rows and 12 columns... So, a lot of data. This is because data
#has been collected for ~20 years. Unfortunately, I am seeing a lot of NA's in 
#the data. Because this is citizen science monitoring data, NA most likely means
#the data wasn't collected during that event and is a form of human error bias.

#Let's take a look at the the NA's by each variable.

is_na <- as.data.frame(colSums(is.na(data_cleaning)))
view(is_na)

#Unfortunately, several of the columns have more than half of the data missing.
#This is pretty common for citizen science data, seeing as collection is 
#opportunistic
#Let's P04 and temperature, because they are missing a lot of data. Then, we can
#remove all missing values and see if there is any data left.

data_cleaning <- data_cleaning %>%
  select(-"po4.mgL", -"temperature.c") 

data_cleaning <- data_cleaning %>%
  na.omit(data_cleaning)
  
#Now we need to make sure all numeric columns are read as numeric instead of character

data_cleaning$biological_score <- as.numeric(data_cleaning$biological_score)

data_cleaning$conductivity.uscm <- as.numeric(data_cleaning$conductivity.uscm)

data_cleaning$turbidity.ntu = as.numeric(data_cleaning$turbidity.ntu)

data_cleaning$no3.mgL = as.numeric(data_cleaning$no3.mgL)

data_cleaning$pH = as.numeric(data_cleaning$pH)

data_cleaning$e.coli.cfu = as.numeric(data_cleaning$e.coli.cfu)
                           
summary(data_cleaning)

#Now, separate the data_cleaning df into three separate dfs based on location ID.
#These dfs will be: "MIDO", "NORO", and "BICO".
#This is to separate out any bias based on location of the streams within ACC.

data_cleaning$stream_ID = substr(data_cleaning$WSID,1,4)

MIDO <- filter(data_cleaning, stream_ID == "MIDO")

NORO <- filter(data_cleaning, stream_ID == "NORO")

BICO <- filter(data_cleaning, stream_ID == "BICO")

summary(MIDO)
summary(NORO)
summary(BICO)

#Now, because the number of rows between each site data frame and between years
#is not consistent, measuring between sites and through time maybe a little biased.
#That being said, my original question refers to the correlation between different
#indicators of stream health, not how they change spatial or temporally.
#Therefore, these space and time inconsistencies won't affect the analyses.

#At last, we can start exploring our cleaned data!
#See "analysis_code" folder for exploratory analysis.

#Save files
MIDO_location <- here::here("data","processed_data","MIDO.rds")
NORO_location <- here::here("data","processed_data","NORO.rds")
BICO_location <- here::here("data","processed_data","BICO.rds")

saveRDS(MIDO, file = MIDO_location)
saveRDS(NORO, file = NORO_location)
saveRDS(BICO, file = BICO_location)





