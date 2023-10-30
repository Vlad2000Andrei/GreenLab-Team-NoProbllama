# Load the required libraries
library(dplyr)
library(tidyr)

folder_path <- "/Users/damlaural/Documents/vrijeuniversiteit/MASTER/Year 2/period 1/green lab/r-studio/energy-data/"

cn <- read.csv(file.path(folder_path, "cn_mili_joules.csv"))
human <- read.csv(file.path(folder_path, "human_mili_joules.csv"))
sr <- read.csv(file.path(folder_path, "sr_mili_joules.csv"))
ts <- read.csv(file.path(folder_path, "ts_mili_joules.csv"))

cn <- rename(cn, name = colnames(cn)[1])
human <- rename(human, name = colnames(human)[1])
sr <- rename(sr, name = colnames(sr)[1])
ts <- rename(ts, name = colnames(ts)[1])

llama <- bind_rows(cn, sr, ts)

for (i in 1:nrow(llama)) {
  name_parts <- unlist(strsplit(as.character(llama$name[i]), "-"))
  
  llama$algorithm[i] <- name_parts[1]
  if (name_parts[2] == 'E') {
    llama$efficient[i] <- TRUE
    llama$language[i] <- name_parts[3]
    llama$temperature[i] <- name_parts[4]
  } else {
    llama$efficient[i] <- FALSE
    llama$language[i] <- name_parts[2]
    llama$temperature[i] <- name_parts[3]
  }
}

for (i in 1:nrow(human)) {
  name_parts <- unlist(strsplit(as.character(human$name[i]), "-"))
  
  human$algorithm[i] <- name_parts[1]
  human$language[i] <- name_parts[3]
}

llama <- llama[, -which(names(llama) == "name")]
human <- human[, -which(names(human) == "name")]

write.csv(llama, file = file.path(folder_path, "llama.csv"), row.names = TRUE)
write.csv(human, file = file.path(folder_path, "human.csv"), row.names = TRUE)
