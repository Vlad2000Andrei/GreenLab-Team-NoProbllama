load_data <- function(path_all_joules, output_dir, path_separator="/") {
  benchmarks = list.dirs(path_all_joules)[-1] # Exclude the first element of the list because that is the path_all_joules parent dir
  data = data.frame()
  
  for (subdir in benchmarks) {
    files = list.files(subdir)
    benchmark_name = strsplit(tail(strsplit(subdir, path_separator)[[1]], 1), " ")[[1]][1] # Magic to get the TS / CN / SR out of the path
    
    for (file in files) {
      if(endsWith(file, "csv")) {
        
        path_file = paste(c(subdir, file), collapse=path_separator)
        run_data = read.csv(path_file) 
        run_data = as.numeric(as.vector(run_data[1,])[-1]) #the other script writes it all weird so we need to transpose it weirdly
        
        # Now find out all the things about it
        algo = paste(strsplit(file, '_')[[1]][1:2], collapse = " ")
        lang = tail(strsplit(file, "_")[[1]],2)[1]
        
        if (grepl("efficient", file, ignore.case = TRUE)) {
          efficient = TRUE
        }
        else {
          efficient = FALSE
        }
        
        temps_06 = c("prompt1", "prompt4", "prompt7", "prompt10", "prompt13", "prompt16")
        temps_08 = c("prompt2", "prompt5", "prompt8", "prompt11", "prompt14", "prompt17")
        temps_10 = c("prompt3", "prompt6", "prompt9", "prompt12", "prompt15", "prompt18")
        
        promptnr = strsplit(tail(strsplit(file, "_")[[1]],1)[1], " ")[[1]][1]
        if (promptnr %in% temps_06) {
          temp = "0.6"
        }
        else if (promptnr %in% temps_08) {
          temp = "0.8"
        }
        else if (promptnr %in% temps_10) {
          temp = "1.0"
        }
      
        
        if (grepl("human", subdir, ignore.case = TRUE)) {
          temp = "N/A"
          efficient = "N/A"
          source = "human"
          algo = paste(strsplit(file, '_')[[1]][4:5], collapse = " ")
          lang = strsplit(strsplit(file, '_')[[1]][6], " ")[[1]][1]
        }
        else {
          source = "llama"
        }
        
        new_row = data.frame(src=source, algo=algo, lang=lang, eff=efficient, temp=temp)
        new_row$data = list(run_data)
        data = rbind(data, new_row)
      }
    }
  }
  return(data)
}

# Arguments:
# - data: the dataframe returned by load_data()
# - source (optional): "human" or "llama"
# - algorithm (optional): "closest numbers", "string replacement" or "two sum"
# - language (optional): "Python", "JavaScript" or "C++"
# - temperature (otitonal): "0.6", "0.8" or "1.0"   YES, as a string, not a number
# - efficient (optional): "TRUE" or "FALSE"   yes, againm as a string
# - only_data (optional, default = FALSE) whether to return just the data column or all the other columns as well.
# - calc_mean (optional, default = FALSE) whether to add the mean of the data column as a new column as well
#
# Returns:
#   A subset of the original data with only the rows that match the filter provided. If only_data==TRUE, then it only returns a vector 
#   of data lists, corresponding to the rows that match the filters.

get_bench_data <- function(data, source=NULL, algorithm=NULL, language=NULL, temperature=NULL, efficient=NULL, only_data = FALSE, calc_mean = FALSE) {
  result = data
  
  if (!is.null(source)) {
    result = subset(result, src == source)
  }
  if (!is.null(algorithm)) {
    result = subset(result, algo == algorithm)
  }
  if (!is.null(language)) {
    result = subset(result, lang == language)
  }
  if (!is.null(temperature)) {
    result = subset(result, temp == temperature)
  }
  if (!is.null(efficient)) {
    result = subset(result, eff == efficient)
  }
  
  if (calc_mean) {
    mean_data <- vector(length = length(result$data))
    for (i in 1:length(result$data)) {
      mean_data[i] <- mean(result$data[[i]])
    }
    result$mean_data <- mean_data
  }
  
  if (only_data) {
    result = as.vector(result$data)
  }
  
  return(result)
}

