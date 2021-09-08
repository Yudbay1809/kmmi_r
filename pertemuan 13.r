# cleansing lanjutan
# persiapan data network

# A. Cleansing lanjutan ####

df <- read.csv("pariwisata.csv")

# proses
# - casefold
# - hapus url
# - hapus tag (menggunakan kode regex)
# - hapus mention (menggunakan kode regex)
# - hapus non alfabet (angka, tandabaca, dll)
# - hapus non-ascii teks
# - normalisasi
# - hapus stopwords
# - hapus kata tertentu
# - steming (kalau perlu)

library(tm)
library(dplyr)
library(stopwords)
library(katadasaR)
library(stringi)
library(qdapRegex)

# kata normalisasi
old <- c(" jogja "," klo "," ya ")
new <- c(" yogyakarta "," kalau "," iya ")

# kata yang butuh dihapus
hapus <- c("pariwisata","yogyakarta")

fungsi_proses <- function(a){
  a %>%
    casefold() %>%
    rm_url(pattern = pastex("@rm_twitter_url","@rm_url")) %>%
    gsub('#\\S+','',.) %>%
    gsub('@\\S+','',.) %>%
    gsub('[^[:alpha:] ]','',.) %>%
    stri_trans_general("latin-ascii") %>%
    stri_replace_all_fixed(old,new,vectorize_all = FALSE) %>%
    removeWords(stopwords(language = "id",source = "nltk")) %>%
    removeWords(hapus)
  #strsplit(" ") %>% # membuat kalimat jadi kumpulan kata
  #unlist() %>%
  #sapply(katadasaR) %>%
  #paste(collapse = " ")
}

dfnew <- mutate(df,komentar_bersih=sapply(full_text,fungsi_proses))

# analisis eksplorasi sederhana
# - kata yg sering muncul
library(tidytext)
dftoken <- dfnew %>%
  select(komentar_bersih) %>%
  unnest_tokens(kata,komentar_bersih) %>%
  count(kata) %>%
  top_n(30)

# visualisasi sederhana
library(ggplot2)
ggplot(dftoken,aes(x=reorder(kata,n),y=n)) + geom_col() + coord_flip()

library(wordcloud2)
wordcloud2(dftoken,size=0.3)



# B. Persiapan data network ####

# B.1. ambil kolom user dan teks
df1 <- df %>% select(user_name,full_text)

# B.2. tambah @ ke username
df1$user_name <- paste0('@',df1$user_name)

# B.3. gabungkan 2 kolom
library(tidyr)
df2 <- df1 %>%
  unite(teks,user_name,full_text,sep=" ")

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
plot(ig,layout=layout_with_kk,vertex.size=3,vertex.label=NA)

library(networkD3)
simpleNetwork(df6)