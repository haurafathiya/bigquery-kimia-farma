# bigquery-kimia-farma  

Repository ini berisi query BigQuery untuk analisis transaksi di Kimia Farma.  

## Deskripsi  
Query ini dibuat sebagai bagian dari **Final Task Internship** dan dirancang untuk menghitung:  
- **Persentase Gross Laba** berdasarkan harga obat  
- **Harga setelah diskon**  
- **Keuntungan bersih** Kimia Farma setelah diskon dan laba kotor  

## Struktur File  
- `kimia_farma_query.sql` → Berisi query utama untuk analisis  

## Penggunaan  
Query ini dibuat khusus untuk keperluan tugas internship dan dapat digunakan sebagai referensi. Jika ingin menggunakannya untuk keperluan lain, harap berikan kredit yang sesuai.  

## Lisensi  
⚠️ Repository ini hanya untuk dokumentasi tugas internship dan **tidak untuk penggunaan komersial**.


## Cara Menggunakan

1. **Persiapan**  
   - Pastikan Anda memiliki akses ke Google Cloud Platform (GCP) dan sudah mengaktifkan BigQuery.  
   - Pastikan dataset transaksi Kimia Farma sudah tersedia di BigQuery.  

2. **Mengimpor Query**  
   - Buka [Google BigQuery Console](https://console.cloud.google.com/bigquery).  
   - Pilih project yang sesuai.  
   - Buka tab **Editor** dan unggah file `kimia_farma_query.sql`.
   - [Lihat kode query di sini](https://github.com/haurafathiya/bigquery-kimia-farma/blob/main/kimia_farma_query.sql)

3. **Menjalankan Query**  
   - Copy-paste query dari `kimia_farma_query.sql` ke dalam editor BigQuery.  
   - Sesuaikan nama dataset dan tabel jika diperlukan.  
   - Klik tombol **Run** untuk mengeksekusi query.  

4. **Menganalisis Hasil**  
   - Setelah query selesai dieksekusi, hasil analisis akan muncul di panel **Results**.  
