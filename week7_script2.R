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