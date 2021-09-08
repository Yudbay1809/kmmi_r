library(ggplot2)
library(plotly)
library(lubridate)
library(dplyr)
library(readr)
df <- read_csv("dataanime.csv")
View(dataanime)

df$Start.airing <- ymd(df$Start.airing)
df$End.airing <- ymd(df$End.airing)

plot_ly(df,x = ~Studios, type = "histogram")

plot_ly(df,x = ~Starting.season, type = "histogram")

plot_ly(df,x = ~Sources, type = "histogram")
