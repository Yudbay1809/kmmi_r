library(readr)
df <- read_csv("KMMI_R/kmmi_r/covid19_tweet.csv")
View(covid19_tweet)

library(tm)
library(dplyr)
library(stopwords)
library(katadasaR)
library(stringi)
library(qdapRegex)

#untuk tugas akhir, filter dulu berdasarkan subtema
#misal subtema: masyarakat|warga
library(stringr) #filter tergantung kebutuhan
dffilter <- filter (df,str_detect(text,"masyarakat|warga"))
df <- df %>% head (10000)

# B. Persiapan data network ####

# B.1. ambil kolom user dan teks
df1 <- dffilter %>% select(screen_name,text)

# B.2. tambah @ ke username
df1$screen_name <- paste0('@',df1$screen_name)

# B.3. gabungkan 2 kolom
library(tidyr)
df2 <- df1 %>%
  unite(teks,screen_name,text,sep=" ")

# B.4. ambil hanya user (@...)
library(stringr)
df3 <- str_extract_all(df2$teks,"(@[[:alnum:]_]*)")
df3 <- sapply(df3,paste,collapse=" ")
df3 <- data.frame(df3)

# B.5. menghitung jumlah user dalam 1 baris
df3$count <- str_count(df3$df3,"\\S+")

# B.6. menghapus baris yg berisi hanya 1 user
df4 <- df3 %>% filter(count > 1)

# B.7. membuat pasangan source-target
library(tidytext)
df5 <- df4 %>%
  select(df3) %>%
  unnest_tokens(username,df3,token = "ngrams",n=2)

# B.8. memisahkan ke dalam 2 kolom
df6 <- df5 %>%
  separate(username,into=c("source","target"),sep=" ")

# B.9. tambah @ di depan username
df6$source <- paste0('@',df6$source)
df6$target <- paste0('@',df6$target)


# Contoh visualisasi
library(igraph)
ig <- graph_from_data_frame(df6,directed=FALSE)

# export file
write_graph(ig, "covid19.graphml",format="graphml")