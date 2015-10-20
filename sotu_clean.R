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

save(sotu, file = "C:/Dropbox/Projects/Dissertation/president/scrape_speeches/SOTU/speeches.RData")







