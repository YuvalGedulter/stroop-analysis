# script 1
files <- dir("C:/Users/97250/Documents/R_Projects/stroop_data")
df <- data.frame()
for(file in files){
  temp_df <- read.csv(paste0("C:/Users/97250/Documents/R_Projects/stroop_data/", file))
  df <- rbind(df, temp_df)
}
View(df)
library(dplyr)
new_df <- df |>
  mutate(task = ifelse(grepl("ink_naming", condition), "ink_naming", "word_reading"),
         congruency = ifelse(grepl("incong", condition), "congruent", "incongruent"),
         accuracy = ifelse(correct_response == participant_response, 1, 0)
  )
raw_data <- new_df |>
  mutate(
    subject = as.factor(subject),
    task = as.factor(task),
    congruency = as.factor(congruency),
    block = as.numeric(block),
    trial = as.numeric(trial),
    accuracy = as.numeric(accuracy),
    rt = as.numeric(rt),
  ) |>
  select(subject, task, congruency, block, trial, accuracy, rt)
contrasts(raw_data$task)
contrasts(raw_data$congruency)
View(raw_data)
save(raw_data, file = "C:/Users/97250/Documents/R_Projects/raw_data.rdata")