# Test using the plymouth libraries dataset

library(readr)
library(ggplot2)
library(tibble)
library(dplyr)

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

class(crap$Central) = "integer"
class(crap$Crownhill) = "integer"
class(crap$Devonport) = "integer"
class(crap$Efford) = "integer"
class(crap$Estover) = "integer"
class(crap$`North Prospect`) = "integer"
class(crap$Peverell) = "integer"
class(crap$Plympton) = "integer"
class(crap$Plymstock) = "integer"
class(crap$Southway) = "integer"
class(crap$`St Budeaux`) = "integer"
class(crap$`West Park`) = "integer"

ggplot(data=crap, aes(x=factor(Age, Age), y=Crownhill, group=1)) +
  geom_line() +
  geom_point()

