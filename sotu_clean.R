#This file puts together the SOTU speeches into one dataframe and preps the data for the creation of the Shiny app

library(readr)
library(stringr)

files <- list.files(path="C:/Dropbox/Projects/Dissertation/president/scrape_speeches/SOTU/all_speeches", pattern="*.txt", full.names=T, recursive=FALSE)

#split up file names
file_names <- unlist(str_split(files, "/"))
file_names <- matrix(file_names, nrow = length(files), ncol = 9, byrow = T)
#get years
years <- as.numeric(str_extract(file_names[,9], "\\d{4}"))

#create df
sp <- data.frame(matrix(nrow = length(files), ncol = 2))
colnames(sp) <- c("year", "speech")

for (i in 1:length(files)) {
        #year
        sp[i, "year"] <- years[i]
        
        #speech
        speech <- read_file(files[i])
        sp[i, "speech"] <- speech 
        
}

#make everything lower case
sp$speech <- tolower(sp$speech)

#Pick words to track
words <- c("god", "america", "china|chinese", "war", "peace", "econom", "environment", "slave", "republican", "democrat", "democracy", "budget", "debt", "deficit", "freedom", "tax", "constitution", "education", "communis", "health", "equal", "rights", "energy", "social security", "middle income", "nuclear", "prohibition", "russia|soviet|ussr", "gun", "justice", "fascis")

labels <- c("God", "America", "China", "War", "Peace", "Economy", "Environment", "Slavery", "Republican", "Democrat", "Democracy", "Budget", "Debt", "Deficit", "Freedom", "Tax", "Constitution", "Education", "Communism", "Health", "Equal", "Rights", "Energy", "Social Security", "Middle class", "Nuclear", "Prohibition", "Russia/Soviet Union", "Gun", "Justice", "Fascism")

for (i in 1:length(words)) {
        sp[,labels[i]] <- str_count(sp$speech, words[i])
}
sotu <- sp[,-2]
vars <- sort(colnames(sotu))
sotu <- sotu[vars]

#Create labels for the app
labels <- sort(labels)
labels_app <- list("America" = 1, "Budget" = 2, "China" = 3, "Communism" = 4, "Constitution" = 5, "Debt" = 6, "Deficit" = 7, "Democracy" = 8, "Democrat" = 9, "Economy" = 10, "Education" = 11, "Energy" = 12, "Environment" = 13, "Equal" = 14, "Fascism" = 15, "Freedom" = 16, "God" = 17, "Gun" = 18, "Health" = 19, "Justice" = 20, "Middle class" = 21, "Nuclear" = 22, "Peace" = 23, "Prohibition" = 24, "Republican" = 25, "Rights" = 26, "Russia/Soviet Union" = 27, "Slavery" = 28, "Social Security" = 29, "Tax" = 30, "War" = 31)            









