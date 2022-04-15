data <- read_csv("life_expectancy_data.csv")

data <- data %>%
  rename("Life_expectancy" = "Life expectancy", "Hepatitis_B" = "Hepatitis B", "percentage_expenditure" = "percentage expenditure",
         "total_expenditure" = "Total expenditure")

filter_data <- data %>%
  select(c("Country", "Year", "Life_expectancy", "Hepatitis_B", "Polio", "Diphtheria", "GDP", "Population", "percentage_expenditure", "total_expenditure")) %>%
  filter(Year == 2014)

NA_columns <- sapply(filter_data, function(x) sum(is.na(x)))

for (i in names(NA_columns[NA_columns > 0])) {
  filter_data[, i][is.na(filter_data[, i])] <- as.numeric(lapply(filter_data[, i], mean, na.rm = TRUE))
}

long_data <- gather(filter_data, vaccine, coverage, Hepatitis_B:Diphtheria, factor_key=TRUE)
