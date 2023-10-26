source("load-run-joules.r")  # import the functions from load-run-joules.r
source("check-normality.r") # get the normality check info

library(rcompanion)  # if this fails, run:  install.packages("rcompanion")  in the console

path_all_joules = 'C:/Users/cursa/Documents/University/MSc CS/Green Lab/Code Llama/GreenLab-Team-NoProbllama/R Data Analysis/Data Files/Run Joules'
output_dir      = 'C:/Users/cursa/Documents/University/MSc CS/Green Lab/Code Llama/GreenLab-Team-NoProbllama/R Data Analysis'
path_separator  = "/"

data = load_data(path_all_joules, output_dir)
normality = check_normality(path_all_joules, output_dir)

## RQ1 ##
human_data = get_bench_data(data, source="human")
llama_data = get_bench_data(data, source="llama", efficient = "FALSE")
# TODO: test

## RQ2 ##
llama_default = get_bench_data(data, source="llama", efficient = "FALSE")
llama_eff = get_bench_data(data, source="llama", efficient = "TRUE")
# TODO: test


## RQ3 ##
llama_rq3_ts = get_bench_data(data, source="llama", efficient = "FALSE", algorithm = "two sum", calc_mean = TRUE)
llama_rq3_cn = get_bench_data(data, source="llama", efficient = "FALSE", algorithm = "closest numbers", calc_mean = TRUE)
llama_rq3_sr = get_bench_data(data, source="llama", efficient = "FALSE", algorithm = "string replacement", calc_mean = TRUE)

scheirerRayHare(mean_data ~ temp * lang, data = llama_rq3_ts)   # Non-parametric alternative to 2-way anova
scheirerRayHare(mean_data ~ temp * lang, data = llama_rq3_cn)   # Non-parametric alternative to 2-way anova
scheirerRayHare(mean_data ~ temp * lang, data = llama_rq3_sr)   # Non-parametric alternative to 2-way anova
