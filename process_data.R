data <- read_csv("data/life_expectancy_data.csv")
data <- data %>%
  rename("Life_expectancy" = "Life expectancy", "Adult_Mortality" = "Adult Mortality", "infant_deaths" = "infant deaths", "percentage_expenditure" = "percentage expenditure", "Hepatitis_B" = "Hepatitis B", "under_five_deaths" = "under-five deaths", "Total_expenditure" = "Total expenditure", "thinness_1_19_years" = "thinness  1-19 years", "thinness_5_9_years" = "thinness 5-9 years", "Income_composition_of_resources" = "Income composition of resources", "HIV_or_AID" = "HIV/AIDS")

NA_columns <- sapply(data, function(x) sum(is.na(x)))
names(NA_columns[NA_columns > 0])

for (i in names(NA_columns[NA_columns > 0])) {
  data[, i][is.na(data[, i])] <- as.numeric(lapply(data[, i], mean, na.rm = TRUE))
}

data <- data %>%
  mutate(developed = ifelse(Status == 'Developed', 1, 0))

data <- data %>%
  select(-Status)

normalize <- function(x){
  round((x-min(x))/(max(x)-min(x)), 4)
}

data[3:21] <- as.data.frame(lapply(data[3:21], normalize))

long_data <- gather(data, parameter, value, Adult_Mortality:developed, factor_key=TRUE)
long_data_2 <- gather(data, parameter, value, Life_expectancy:developed, factor_key=TRUE)
