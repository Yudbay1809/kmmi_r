# Penggunaan library
# install tidyverse
# bisa di dalam script atau di console

# Silakan install library tidyverse di console
# perintahnya: install.packages("tidyverse"), kemudian enter
# install.packages("readxl")

# A. Membaca file excel ####
# 2 cara penulisan penggunaan library di R
# Cara 1
library(readxl)
df_data <- read_excel("filecontoh.xlsx",sheet="Data")
# Cara 2
df_data <- readxl::read_excel("filecontoh.xlsx",sheet="Data")

# Melihat rangkuman dari data
summary(df_data)

# B. Menyimpan dalam file excel ####
library(xlsx)
write.xlsx(df_data,"filecontohbaru.xlsx")



# C. Pengolahan data frame lanjutan menggunakan library ####
library(dplyr) # ada di tidyverse

# C.1. Pengambilan kolom ####
# select(dataframe,kolom,kolom,..)
select(df_data,nama_pengguna,follower)
# select(dataframe,rentang urutan)
select(df_data,3:5)

# C.2. Pengambilan baris ####
# Metode slice
dfslice <- slice(df_data,11:15)
# Metode filter
# misal ambil baris yang jumlah like > 0
df1 <- filter(df_data,jmlh_like > 0)
# misal ambil baris yang jumlah like > 0 dan jumlah reply > 0
df2 <- filter(df_data,jmlh_like>0 & jmlh_reply>0)

# C.3. Mengurutkan data ####
# kecil ke besar (ascending)
df3 <- arrange(df_data,follower)
# besar ke kecil (descending)
df4 <- arrange(df_data,desc(follower))

# Tantangan singkat
# Dari data yang ada, Canggih ingin tahu komentar siapa saja yang memiliki like dan reply (mendapatkan engagement) dan tunjukkan siapa 3 orang diantaranya yang paling populer. Bantulah Canggih untuk mendapatkan data yang diinginkan.

# Solusi
# 1. filter, ambil komentar yang ada like dan reply
dfsolusi1 <- filter(df_data,jmlh_like>0 & jmlh_reply>0)
# 2. diurutkan berdasarkan jumlah follower
dfsolusi2 <- arrange(dfsolusi1,desc(follower))
# 3. seleksi kolom nama pengguna
dfsolusi3 <- select(dfsolusi2,nama_pengguna)

# C.4. Penggunaan pipeline di R ####
# %>% notasi pipeline
dfsolusi4 <- df_data %>%
  filter(jmlh_like>0 & jmlh_reply>0) %>%
  arrange(desc(follower)) %>%
  select(nama_pengguna)


