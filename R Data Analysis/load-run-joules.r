load_data <- function(path_all_joules, output_dir, path_separator="/") {
  benchmarks = list.dirs(path_all_joules)[-1] # Exclude the first element of the list because that is the path_all_joules parent dir
  data = data.frame()
  
  for (dir in benchmarks) {
    files = list.files(dir)
    benchmark_name = strsplit(tail(strsplit(dir, path_separator)[[1]], 1), " ")[[1]][1] # Magic to get the TS / CN / SR out of the path
    
    for (file in files) {
      path_file = paste(c(dir, file), collapse=path_separator)
      run_data = read.csv(path_file) 
      run_data = as.numeric(as.vector(run_data[1,])[-1]) #the other script writes it all weird so we need to transpose it weirdly
      
      # Now find out all the things about it
      algo = benchmark_name
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
      else {
        temp = "N/A"
      }
      
      new_row = data.frame(algo=algo, lang=lang, efficient=efficient, temp=temp)
      new_row$data = list(run_data)
      data = rbind(data, new_row)
      
    }
  }
  return(data)
}

path_all_joules = 'C:/Users/cursa/OneDrive/Documente/Uni/Green Lab/GreenLab-Team-NoProbllama/R Data Analysis/Data Files/Run Joules'
output_dir      = 'C:/Users/cursa/OneDrive/Documente/Uni/Green Lab/GreenLab-Team-NoProbllama/R Data Analysis'
path_separator  = "/"

data = load_data(path_all_joules, output_dir, path_separator)
