# Preprosesing data #####

# install.packages(c("devtools","qdap","tm","stopwords"))
# devtools::install_github("nurandi/katadasaR")

library(readxl)
library(dplyr)
library(stringr)
library(tm)

df <- read_excel("filecontoh.xlsx")

# A. Filter teks ####
# filter semua teks
df1 <- filter(df,klasifikasi_komentar=="kontra")
# filter sebagian teks
df2 <- filter(df,str_detect(komentar,"min"))



# B. Mutate / Penambahan kolom ####
# menambah kolom berdasarkan rumus tertentu yang dibuat
df3 <- mutate(df,engagement=jmlh_like+jmlh_reply)


# C. Kategorisasi berdasarkan kondisi ####
df4 <- mutate(df,katfoll = case_when(follower >= 1000 ~ "tinggi",
                              follower >= 100 ~ "sedang",
                              TRUE ~ "rendah"))

# Challenge 1 ####
# Ubahlah batas kategorisasi follower menjadi < 250 itu rendah, 250-1500 sedang, > 1500 itu tinggi. 
# Kemudian, cari tahu siapa saja yang memiliki kategori sedang DAN klasifikasi komentarnya netral.
dfc1 <- mutate(df,katfoll = case_when(follower >= 1500 ~ "tinggi",
                                     follower >= 250 ~ "sedang",
                                     TRUE ~ "rendah"))
dfc2 <- filter(dfc1,katfoll=="sedang" & klasifikasi_komentar=="netral")


# D. Group By / Pengelompokan (agregasi) ####
# Melihat jumlah
df5 <- df %>%
  group_by(klasifikasi_komentar) %>%
  count()

# Membuat agregasi
df6 <- df %>%
  group_by(klasifikasi_komentar) %>%
  summarise(jumlah=n(),total_like=sum(jmlh_like),total_reply=sum(jmlh_reply),total_follower=sum(follower),rata_follower=mean(follower))


# Challenge 2 ####
# Dari challenge 1, lakukan agregasi data (berdasarkan kategori yg baru), tuliskan semua dalam bentuk pipeline

dfc3 <- df %>%
  mutate(katfoll = case_when(follower >= 1500 ~ "tinggi",follower >= 250 ~ "sedang",TRUE ~ "rendah")) %>%
  group_by(katfoll) %>%
  summarise(jumlah=n(),total_like=sum(jmlh_like),total_reply=sum(jmlh_reply),total_follower=sum(follower),rata_follower=mean(follower))
  


# E. Fungsi (rumus)

fungsi_jumlah <- function(a){
  return(a + 10)
}
fungsi_kurang <- function(b){
  return(b-5)
}

fungsi_jumlah(7)
fungsi_jumlah(18)
fungsi_jumlah(22)
fungsi_kurang(78)

# F. Apply ####
# apply,lapply,sapply,vapply,dll
# mengaplikasikan suatu fungsi/rumus dalam dataframe, list, atau vector
# contoh
coba <- df[c("follower","jmlh_like")]
sapply(coba,mean)

# misal buat kolom baru berisi follower x 10
# menggunakan mutate biasa
df7 <- mutate(df,baru = follower*10)
# menggunakan sapply
fungsi_kali <- function(a){
  return(a*10)
}
df8 <- mutate(df,baru = sapply(follower,fungsi_kali))


####################

# G. Prapemrosesan teks ####
# - casefolding
# - hapus angka (tm::removeNumbers)
# - hapus tanda baca (tm::removePunctuation)
# - (belum) normalisasi kata
# - (belum) stopwords
# - (belum) hapus kata irrelevan 
# - (belum) stemming dan lemmatization

# G.1. Membuat fungsi pemrosesan
fungsi_proses <- function(a){
  a %>%
    casefold() %>%
    removeNumbers() %>%
    removePunctuation()
}
# G.2. Menampilkan hasil di kolom baru
df9 <- mutate(df,komentar_bersih=sapply(komentar,fungsi_proses))


# Tugas ####
# Aplikasikan prapemrosesan teks (cleansing) berupa casefolding, hapus angka, dan hapus tandabaca pada dataset yang lain. Dataset bebas, asal berupa teks.
# Isi dari skripnya: import file, lakukan prapemrosesannnya.
