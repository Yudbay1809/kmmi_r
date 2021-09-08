#==== 1. Tipe Data Bawaan R
## 1.1. Atomic Vector
## 1.2. Vector
## 1.3. List
## 1.4. Data Frame

# 1.1. Atomic Vector
# ada 6: character, numeric, logical, raw, integer, complex

nama = "canggih" # Atomic Vector dengan tipe CHARACTER
nilai = 9.8 # Atomic Vector dengan tipe NUMERIC
lulus = TRUE # AV dengan tipe LOGICAL

# contoh
nilai_mat = 96.8
nilai_bhs = 87.6
total = nilai_mat + nilai_bhs

# Pengisian nilai
# keduanya sama
nilai_abc = 70.66
nilai_abc <- 70.66 # saya lebih suka ini



# 1.2. Vector
# Kumpulan atomic vector
nilai <- c(8.5,9.6,5.8,10) # Numeric Vector
nama <- c("canggih","puspo","wibowo") # Character vector

# Mengakses nilai dalam vector
# Urutan dalam R dimulai dengan 1
nama[c(1)] # nama[c(urutan)]
nilai[c(3)]

# contoh
nilai_gabungan <- nilai[c(1)] + nilai[c(4)]
nilai_gabungan

# 1.3. List
# Kumpulan dari atomic vector yang bisa berbeda tipe
orang_1 <- list(nama="canggih",nilai=99,lulus=TRUE)
orang_1
orang_2 <- list("wibowo",78,FALSE)
orang_2

# Mengakses nilai dalam List
orang_1[1]
orang_1["nilai"]
orang_1$lulus
orang_2[3]


# 1.4. Data Frame
# Intinya adalah sebuah tabel
# Bisa tersusun dari kumpulan List
# Bisa tersusun dari kumpulan Vector

# Membuat data frame
no <- c(1,2,3,4)
nama <- c("canggih","puspo","wibowo","oke")
nilai <- c(70,90,89,99)
datanilai <- data.frame(no,nama,nilai)
# 4 obs. of 3 variables
# 4 observasi (pengamatan) dan 3 variabel
# observasi -> baris
# variabel -> kolom
# next: buat dataframe dari file excel dsb


# Mengakses nilai dalam dataframe
datanilai[1]
datanilai[1:2]
datanilai[c("nama")]
datanilai[c("nama","nilai")]
datanilai$nama

# Range/rentang di R itu inklusif dua sisi
# 1:3 -> 1,2,3
datanilai[1:3,2:3] # hasilnya dataframe
datanilai[3,2] # hasilnya satu nilai (atomic vector)


# NEXT
# - Data Tidy (kerapian suatu data) -> PENTING BANGET!!!!
# - Penggunaan library/package (instalasi dan penggunaan)
# - Import/Export data
# - Pengolahan data frame lanjutan (filtering, munging, dll)
# - Fungsi-fungsi dasar dalam R
