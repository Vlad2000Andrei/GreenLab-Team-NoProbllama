# Define path names
folder_path <- "/Users/damlaural/Documents/vrijeuniversiteit/MASTER/Year 2/period 1/green lab/r-studio/energy-data/"
library(dplyr)
library(ggplot2)
library(patchwork)

llama_path <- paste(folder_path,"llama.csv",sep = '')
human_path <- paste(folder_path,"human.csv",sep = '')

# Import files
llama <- read.csv(llama_path)
human <- read.csv(human_path)


relative_change_percentage <- function(prev, new) {
  relative_change <- ((new - prev) / prev) * 100
  return(round(relative_change, 3))
}

non_energy <- llama %>% filter(efficient == "False")

group_and_calculate_mean <- function(df, group_cols, mean_col) {
  grouped_df <- df %>% group_by(!!!syms(group_cols))
  result <- grouped_df %>% summarize(mean_llama = mean(!!sym(mean_col)))
  return(result)
}

result <- group_and_calculate_mean(non_energy, c("algorithm", "language"), "mean")

rq1 <- merge(human[, c("algorithm", "language", "mean")], result, by = c("algorithm", "language"))
rq1$change <- mapply(relative_change_percentage, rq1["mean"], rq1["mean_llama"])

plot_rq1 <- function(alg) {
  pl <- ggplot(data = rq1 %>% filter(algorithm == alg), aes(x = language, y = change[, "mean", drop = TRUE], fill = language)) +
    geom_bar(stat = "identity", width = 0.5) + labs(x = "Language", y= "Change Percentage") +
    geom_text(aes(label = paste(round(change[, "mean"], 2), "%"), vjust = -0.5), position = position_dodge(width = 0.5)) +
    ggtitle(paste("Difference Human vs. Llama for ", alg))+
    theme(plot.title = element_text(hjust = 0.5))
  return(pl)
}

plot_cn <- plot_rq1("CN")
plot_ts <- plot_rq1("TS")
plot_sr <- plot_rq1("SR")
plot_cn
################### RQ2 ####################
group_and_reshape <- function(alg) {
  algo_df <- llama %>% filter(algorithm == alg)
  eff <- algo_df %>% filter(efficient == "True")
  non_eff <- algo_df %>% filter(efficient == "False")
  merged_data <- merge(eff[, c("language", "temperature", "mean")], non_eff[, c("language", "temperature", "mean")], by = c("language", "temperature"))
}

cn <- group_and_reshape("CN")
sr <- group_and_reshape("SR")
ts <- group_and_reshape("TS")

plot_rq2 <- function(alg, name) {
  ggplot(alg, aes(fill = language, x = mean.x, y = mean.y, color = language)) +
    geom_point(size = 3) +
    labs(
      x = "Normal Prompt Energy Consumption (mJ)",
      y = "Efficient Prompt Energy Consumption (mJ)",
      title = paste("Llama Default Prompt vs Llama Energy Efficient Prompt for", name)
    ) +
    scale_color_manual(values = c("C++" = "red", "JavaScript" = "blue", "Python" = "green")) +
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5))+
    geom_abline(intercept = 0, slope = 1, color = "black", linetype = "dashed")
}

plot_rq2(cn, "CN")



################### RQ3 ####################
plot_rq3 <- function(df, alg) {
  df$temperature <- factor(df$temperature)
  
  ggplot(df, aes(fill = temperature, y = mean.x, x = language)) +
    geom_bar(position = "dodge", stat = "identity") +
    geom_text(aes(label = round(mean.x, 2), vjust = -0.5), position = position_dodge(width = 0.9)) +
    ggtitle(paste("Temperature Differences for ", alg))+
    labs(x = "Language", y= "Mean Energy Consumption") +
    theme(plot.title = element_text(hjust = 0.5))
}

#plot_rq3(ts, "TS")

