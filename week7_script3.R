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