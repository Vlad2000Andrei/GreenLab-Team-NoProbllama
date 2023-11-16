source("load-run-joules.r")  # import the functions from load-run-joules.r
source("check-normality.r") # get the normality check info

library(rcompanion)  # if this fails, run:  install.packages("rcompanion")  in the console
library(effsize)

path_all_joules = 'C:/Users/berta/OneDrive/Documents/GreenLab-Team-NoProbllama/R Data Analysis/Data Files/Run Joules'
output_dir      = 'C:/Users/berta/OneDrive/Documents/GreenLab-Team-NoProbllama/R Data Analysis/Data Files'
path_separator  = "/"

data = load_data(path_all_joules, output_dir)
normality = check_normality(path_all_joules, output_dir)

benchmarks = c("two sum", "string replacement", "closest numbers")
languages = c("Python", "C++", "JavaScript")

## RQ1 ##
rq1 = data.frame()

for (benchmark in benchmarks) {
  for (language in languages) {
    human_data = get_bench_data(data, source="human", language=language, algorithm=benchmark, only_data = TRUE)[[1]]
    llama_data = get_bench_data(data, source="llama", efficient = "FALSE", language=language, algorithm=benchmark, only_data = TRUE)[[1]]
    
    rq1_testresult = wilcox.test(human_data, llama_data)$p.value
    effect_size_1 = cliff.delta(human_data, llama_data)$estimate
    new_row = data.frame(benchmark = benchmark, lang = language, pvalue = rq1_testresult, cliff = effect_size_1)
    rq1 = rbind(rq1, new_row)
  }
}
write.csv(rq1, "rq1_testresults.csv", row.names = TRUE)

## RQ2 ##
rq2 = data.frame()
for (benchmark in benchmarks) {
  for (language in languages) {
    llama_default = get_bench_data(data, source="llama", efficient = "FALSE", language=language, algorithm=benchmark, only_data = TRUE)[[1]]
    llama_eff = get_bench_data(data, source="llama", efficient = "TRUE", language=language, algorithm=benchmark, only_data = TRUE)[[1]]

    rq2_testresult = wilcox.test(llama_default, llama_eff)$p.value
    new_row = data.frame(benchmark = benchmark, lang = language, pvalue = rq2_testresult)
    rq2 = rbind(rq2, new_row)
  }
}
write.csv(rq2, "rq2_testresults.csv", row.names = TRUE)

## RQ3 ##
rq3 = data.frame()

for (bench in benchmarks) {
  for (lang in languages) {
    llama_rq3_0_6 = get_bench_data(data, source="llama", efficient = "FALSE", temperature = "0.6", language=lang, algorithm=bench, only_data = TRUE)[[1]]
    llama_rq3_0_8 = get_bench_data(data, source="llama", efficient = "FALSE", temperature = "0.8", language=lang, algorithm=bench, only_data = TRUE)[[1]]
    llama_rq3_1_0 = get_bench_data(data, source="llama", efficient = "FALSE", temperature = "1.0", language=lang, algorithm=bench, only_data = TRUE)[[1]]

    rq3_testresult = kruskal.test(list(llama_rq3_0_6, llama_rq3_0_8, llama_rq3_1_0))$p.value
    new_row = data.frame(benchmark = bench, lang = lang, pvalue = rq3_testresult)
    rq3 = rbind(rq3, new_row)
  }
}
write.csv(rq3, "rq3_testresults.csv", row.names = TRUE)
