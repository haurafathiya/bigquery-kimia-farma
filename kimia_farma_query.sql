CREATE OR REPLACE TABLE `kimia_farma.kf_analisa` AS
WITH transaksi AS (
    SELECT
        t.transaction_id,
        t.date,
        t.branch_id,
        c.branch_name,
        c.kota,
        c.rating AS branch_rating,
        t.customer_name,
        t.product_id,
        p.product_name,
        t.price,
        t.discount_percentage,

        -- Persentase Gross Laba berdasarkan harga obat
        CASE
            WHEN t.price <= 50000 THEN 0.10
            WHEN t.price BETWEEN 50001 AND 100000 THEN 0.15
            WHEN t.price BETWEEN 100001 AND 300000 THEN 0.20
            WHEN t.price BETWEEN 300001 AND 500000 THEN 0.25
            WHEN t.price > 500000 THEN 0.30
        END AS persentase_gross_laba,

        -- Harga setelah diskon
        t.price * (1 - t.discount_percentage / 100) AS nett_sales,

        -- Keuntungan Kimia Farma
        t.price * (1 - t.discount_percentage / 100) * 
        (
            CASE
                WHEN t.price <= 50000 THEN 0.10
                WHEN t.price BETWEEN 50001 AND 100000 THEN 0.15
                WHEN t.price BETWEEN 100001 AND 300000 THEN 0.20
                WHEN t.price BETWEEN 300001 AND 500000 THEN 0.25
                WHEN t.price > 500000 THEN 0.30
            END
        ) AS nett_profit,

        t.rating
    FROM `kimia_farma.kf_final_transaction` t
    LEFT JOIN `kimia_farma.kf_kantor_cabang` c ON t.branch_id = c.branch_id
    LEFT JOIN `kimia_farma.kf_product` p ON t.product_id = p.product_id
)
