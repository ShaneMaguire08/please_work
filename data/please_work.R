## Shane Maguire

library(readxl)
library(tidyverse)

# Read the Excel file into R
data <- read_excel("data/ZOOV212-prac-4-data.xlsx", sheet = "RawData", range = "A1:D10")

# Print the first few rows of the data to check its structure
head(data)

# Get the column index for "Pool_number"
pool_number_col <- which(names(data) == "Pool_number")
 
# Reshape the data into tidy format
tidy_data <- data %>%
  pivot_longer(cols = c(Pool_number), names_to = "Variable", values_to = "Value")

# Checking stucture
head(tidy_data)


tidy_data$Pool_classification <- factor(tidy_data$Pool_classification, levels = c("Small", "Medium", "Large"))  

mean_species <- tidy_data %>%
  group_by(Pool_classification) %>%
  summarize(mean_species = mean(`#species`))


ggplot(mean_species, aes(x = Pool_classification, y = mean_species, fill = Pool_classification)) +
  geom_bar(stat = "identity") +
  labs(x = "Pool Classification", y = "Mean Number of Species", title = "Mean Number of Species by Pool Classification") +
  theme_minimal()    

