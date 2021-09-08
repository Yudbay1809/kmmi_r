#install.packages(c("devtools","qdap","tm","stopwords"))
#devtools::install_github("nurandi/katadasaR")
library(readxl)
library(dplyr)
library(stringr)
library(tm)
df<- read_excel("Kelompok 12.xlsx")
fungsi_proses <- function(a){
  a %>%
    casefold() %>%
    removeNumbers() %>%
    removePunctuation()
}
df2 <- mutate(df,Komentar_bersih=sapply(Komentar,fungsi_proses))