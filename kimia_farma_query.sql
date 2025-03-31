CREATE OR REPLACE TABLE `kimia_farma.kf_analisa` AS 
WITH transaksi AS (
  SELECT 
    t.transaction_id, 
    t.date,
    EXTRACT(YEAR FROM t.date) AS tahun_transaksi, 
    c.branch_id, 
    c.branch_name, 
    c.kota,

    -- Mapping Provinsi
    CASE 
      -- Pulau Jawa
      WHEN c.kota IN ('Jakarta', 'Jakarta Selatan', 'Jakarta Barat', 'Jakarta Timur', 'Jakarta Utara', 'Jakarta Pusat') THEN 'DKI Jakarta'
      WHEN c.kota IN ('Tangerang', 'Tangerang Selatan', 'Serang', 'Cilegon', 'Lebak', 'Pandeglang') THEN 'Banten'
      WHEN c.kota IN ('Bandung', 'Bekasi', 'Depok', 'Bogor', 'Cimahi', 'Cirebon', 'Sukabumi', 'Tasikmalaya', 'Garut', 'Purwakarta', 'Karawang', 'Sumedang', 'Majalengka', 'Subang', 'Indramayu', 'Pangandaran', 'Banjar', 'Ciamis', 'Cikampek', 'Cianjur') THEN 'Jawa Barat'
      WHEN c.kota IN ('Semarang', 'Surakarta', 'Solo', 'Magelang', 'Pekalongan', 'Tegal', 'Salatiga', 'Purwokerto', 'Cilacap', 'Kudus', 'Klaten', 'Boyolali', 'Sragen', 'Brebes', 'Pemalang', 'Jepara') THEN 'Jawa Tengah'
      WHEN c.kota IN ('Yogyakarta', 'Sleman', 'Bantul', 'Gunungkidul', 'Kulon Progo') THEN 'DI Yogyakarta'
      WHEN c.kota IN ('Surabaya', 'Malang', 'Kediri', 'Blitar', 'Madiun', 'Pasuruan', 'Probolinggo', 'Jember', 'Banyuwangi', 'Sidoarjo', 'Lumajang', 'Tuban', 'Ponorogo', 'Gresik', 'Bojonegoro') THEN 'Jawa Timur'

      -- Pulau Sumatra
      WHEN c.kota IN ('Banda Aceh', 'Lhokseumawe', 'Langsa', 'Subulussalam') THEN 'Aceh'
      WHEN c.kota IN ('Medan', 'Binjai', 'Tebing Tinggi', 'Pematangsiantar', 'Sibolga', 'Gunungsitoli', 'Padang Sidempuan') THEN 'Sumatera Utara'
      WHEN c.kota IN ('Padang', 'Bukittinggi', 'Payakumbuh', 'Sawahlunto', 'Solok') THEN 'Sumatera Barat'
      WHEN c.kota IN ('Pekanbaru', 'Dumai') THEN 'Riau'
      WHEN c.kota IN ('Batam', 'Tanjungpinang') THEN 'Kepulauan Riau'
      WHEN c.kota IN ('Jambi', 'Sungai Penuh') THEN 'Jambi'
      WHEN c.kota IN ('Palembang', 'Lubuklinggau', 'Pagar Alam', 'Prabumulih') THEN 'Sumatera Selatan'
      WHEN c.kota IN ('Bengkulu') THEN 'Bengkulu'
      WHEN c.kota IN ('Bandar Lampung', 'Metro') THEN 'Lampung'
      WHEN c.kota IN ('Pangkalpinang') THEN 'Bangka Belitung'

      -- Pulau Kalimantan
      WHEN c.kota IN ('Pontianak', 'Singkawang') THEN 'Kalimantan Barat'
      WHEN c.kota IN ('Palangkaraya') THEN 'Kalimantan Tengah'
      WHEN c.kota IN ('Banjarmasin', 'Banjarbaru') THEN 'Kalimantan Selatan'
      WHEN c.kota IN ('Samarinda', 'Balikpapan', 'Bontang') THEN 'Kalimantan Timur'
      WHEN c.kota IN ('Tarakan') THEN 'Kalimantan Utara'

      -- Pulau Sulawesi
      WHEN c.kota IN ('Manado', 'Bitung', 'Tomohon', 'Kotamobagu') THEN 'Sulawesi Utara'
      WHEN c.kota IN ('Gorontalo') THEN 'Gorontalo'
      WHEN c.kota IN ('Palu') THEN 'Sulawesi Tengah'
      WHEN c.kota IN ('Makassar', 'Parepare', 'Palopo') THEN 'Sulawesi Selatan'
      WHEN c.kota IN ('Kendari', 'Baubau') THEN 'Sulawesi Tenggara'
      WHEN c.kota IN ('Mamuju') THEN 'Sulawesi Barat'

      -- Bali & Nusa Tenggara
      WHEN c.kota IN ('Denpasar', 'Singaraja') THEN 'Bali'
      WHEN c.kota IN ('Mataram', 'Bima') THEN 'Nusa Tenggara Barat'
      WHEN c.kota IN ('Kupang') THEN 'Nusa Tenggara Timur'

      -- Pulau Maluku
      WHEN c.kota IN ('Ambon', 'Tual') THEN 'Maluku'
      WHEN c.kota IN ('Ternate', 'Tidore Kepulauan') THEN 'Maluku Utara'

      -- Pulau Papua
      WHEN c.kota IN ('Jayapura') THEN 'Papua'
      WHEN c.kota IN ('Manokwari', 'Sorong') THEN 'Papua Barat'
      WHEN c.kota IN ('Nabire') THEN 'Papua Tengah'
      WHEN c.kota IN ('Wamena') THEN 'Papua Pegunungan'
      WHEN c.kota IN ('Merauke') THEN 'Papua Selatan'
      WHEN c.kota IN ('Fakfak') THEN 'Papua Barat Daya'
      ELSE 'Lainnya'
    END AS provinsi,
    
    c.rating AS branch_rating, 
    t.customer_name, 
    p.product_id, 
    p.product_name, 
    t.price AS actual_price, 
    t.discount_percentage, 

    -- Persentase Gross Laba
    CASE 
      WHEN t.price <= 50000 THEN 0.10
      WHEN t.price BETWEEN 50001 AND 100000 THEN 0.15
      WHEN t.price BETWEEN 100001 AND 300000 THEN 0.20
      WHEN t.price BETWEEN 300001 AND 500000 THEN 0.25
      WHEN t.price > 500000 THEN 0.30
    END AS persentase_gross_laba,

    -- Harga setelah diskon
    t.price * (1 - t.discount_percentage / 100) AS nett_sales,
    
    -- Keuntungan Kimia Farma (nett_profit)                                        
    (t.price * (1 - t.discount_percentage / 100)) * 
    (CASE 
      WHEN t.price <= 50000 THEN 0.10
      WHEN t.price BETWEEN 50001 AND 100000 THEN 0.15
      WHEN t.price BETWEEN 100001 AND 300000 THEN 0.20
      WHEN t.price BETWEEN 300001 AND 500000 THEN 0.25
      WHEN t.price > 500000 THEN 0.30
    END) AS nett_profit, 

    -- Rating Transaksi
    t.rating AS rating_transaksi
    
  FROM `kimia_farma.kf_final_transaction` t
  LEFT JOIN `kimia_farma.kf_kantor_cabang` c ON t.branch_id = c.branch_id
  LEFT JOIN `kimia_farma.kf_product` p ON t.product_id = p.product_id
)

SELECT * FROM transaksi;
