# script 4
install.packages("lme4")
library(lme4)
model <- lmer(rt ~ task + (1 | subject), data = raw_data)
summary(model)
# 5 rows, regression code, Yuval, 28.12.24