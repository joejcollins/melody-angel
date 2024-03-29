# Test using the plymouth libraries dataset

library(readr)
library(ggplot2)
library(tibble)
library(dplyr)
library(tidyverse)

plymouth <- read_csv("~/melody-angel/data/raw/plymouth.csv")


transpose_df <- function(df) {
  t_df <- data.table::transpose(df)
  colnames(t_df) <- rownames(df)
  rownames(t_df) <- colnames(df)
  tibble::as_tibble(t_df)
  return(t_df)
}

crap <- transpose_df(plymouth)
colnames(crap) <- plymouth$Library
crap <- crap[-1,]

crap <- tibble::rownames_to_column(crap, "Age")

for (i in colnames(crap)){
  if(i != "Age"){
    crap[, i] <- as.numeric(crap[, i])
  }
}

ggplot(data = crap, aes(x = factor(Age, Age), y = Crownhill, group = 1)) +
  geom_line() +
  geom_point() +
  labs(x = "Age", y = "Number of Active Users")

# Reshape the data into a longer format
crap_long <- crap %>%
  pivot_longer(cols = -Age, names_to = "Location", values_to = "Value")

age_order <- c("Age0-4", "Age5-11", "Age12-17", "Age18-59", "Age60-100")

crap_long$Age <- factor(crap_long$Age, levels = age_order)

# Plot the line plot
ggplot(data = crap_long, aes(x = Age, y = Value, group = Location, color = Location)) +
  geom_line() +
  geom_point() +
  labs(x = "Age", y = "Number of Active Users")

  

