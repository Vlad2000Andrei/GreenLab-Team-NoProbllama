

check_normality = function(path_all_joules, output_dir, path_separator = '/', alpha=0.05) {
  
  benchmarks = list.dirs(path_all_joules)[-1] # Exclude the first element of the list because that is the path_all_joules parent dir
  
  result = data.frame(prompt = character(), pvalue = numeric(), signif=character(), normal=character())
  
  
  for (dir in benchmarks) {
    files = list.files(dir)
    benchmark_name = tail(strsplit(dir, path_separator)[[1]], 1)
    
    for (file in files) {
      if (endsWith(file, "csv")) {
        path_file = paste(c(dir, file), collapse=path_separator)
        run_data = read.csv(path_file) 
        run_data = as.numeric(as.vector(run_data[1,])[-1]) #the other script writes it all weird so we need to transpose it weirdly
        
        
        options("scipen"=100, "digits"=20)
        pval = shapiro.test(run_data)$p.value
        significant = pval < alpha
        
        normal = ""
        if (significant) {
          normal = "Not Normal"
        }
        else {
          normal = "Unknown"
        }
        
        new_row = data.frame(bench=file, pvalue=pval, signif=significant, normal=normal)
        result = rbind(result, new_row)
      }
    }
  }
  
  colnames(result) = c("Prompt File", "Shapiro p-Value", paste("Smaller than Alpha=",alpha), "Normal")
  write.csv(result, file=paste(output_dir, "normality_shapiro.csv", sep=path_separator))
  return(result)
}
