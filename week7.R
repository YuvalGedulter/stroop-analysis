# R course for beginners
# Week 7
# Assignment by Yuval Gedulter, ID 315668301
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
# script 2
count(raw_data, subject)
filtered_data <- na.omit(raw_data)
filtered_data <- filter(raw_data, 300 <= rt & rt <= 3000) |>
  group_by(subject) |>
  summarise(
    trial_percentage = 1 - n()/400,
  )
print(filtered_data)
trial_data <- filtered_data |>
  summarise(
    mean_trial_percentage = mean(trial_percentage),
    sd_trial_percentage = sd(trial_percentage)
  )
print(trial_data)
View(filtered_data)
save(filtered_data, file = "C:/Users/97250/Documents/R_Projects/filtered_data.rdata")
# script 3
task_raw_data <- raw_data |>
  group_by(task) |>
  summarise(
    mean_rt = mean(rt),
    sd_rt = sd(rt),
    ymin = mean_rt - sd_rt,
    ymax = mean_rt + sd_rt
  )
print(task_raw_data)
library(ggplot2)
ggplot(task_raw_data, aes(x = task, y = mean_rt)) +
  geom_errorbar(aes(ymin = ymin, ymax = ymax), width = 0.1) +
  xlab("Task") +
  ylab("Mean RT") +
  theme_minimal()
# script 4
install.packages("lme4")
library(lme4)
model <- lmer(rt ~ task + (1 | subject), data = raw_data)
summary(model)