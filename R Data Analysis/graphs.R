# Define path names
folder_path <- "/Users/damlaural/Documents/vrijeuniversiteit/MASTER/Year 2/period 1/green lab/r-studio/energy-data/"

cn_path <- paste(folder_path,"cn_mili_joules.csv",sep = '')
sr_path <- paste(folder_path,"sr_mili_joules.csv",sep = '')
ts_path <- paste(folder_path,"ts_mili_joules.csv",sep = '')
human_path <- paste(folder_path,"human_mili_joules.csv",sep = '')

# Import files
cn <- read.csv(cn_path)
sr <- read.csv(sr_path)
ts <- read.csv(ts_path)
human <- read.csv(human_path)

#Merge datasets
datasets <- list(cn, sr, ts, human)
merged_dataset <- do.call(rbind, datasets)


# Filter by keyword
filterByKeyword <- function(dataset, column_name, keyword) {
  keyword_rows <- grepl(keyword, dataset[[column_name]])

  filtered_dataset <- dataset[keyword_rows, ]
  
  return(filtered_dataset)
}

# Filter by non energy efficient code
filterByNonE <- function(dataset, column_name) {
  keyword_rows <- !grepl("E", dataset[[column_name]])
  
  filtered_dataset <- dataset[keyword_rows, ]
  
  return(filtered_dataset)
}

non_energy <- filterByNonE(merged_dataset, "X")



