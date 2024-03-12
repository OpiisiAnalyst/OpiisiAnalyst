# Q = Buatlah query untuk mencari top 5 produk yang dibeli 
# di bulan desember 2019 berdasarkan total quantity
select 
	desc_product,
	sum(quantity) as total_quantity
from order_details a
join products as b
on b.product_id = a.product_id
join orders as c 
on a.order_id = c.order_id
where created_at between '2019-12-01' and '2019-12-31'
group by 1
order by 2 desc
limit 5
#-------------------------------------------===
# Q = Buatlah Query agar menampilkan 5 Kategori dengan total quantity 
# terbanyak di tahun 2020, hanya untuk transaksi yang sudah terkirim ke pembeli
select 
	category, 
	sum(quantity) as total_quantity, 
    sum(price) as total_price
from orders
inner join order_details using(order_id)
inner join products using(product_id)
where created_at>='2020-01-01'
and delivery_at is not null
group by 1
order by 2 desc
limit 5
#============================
# Q = buatlah query agar menampilkan 10 transaksi dari 
# pembelian dari pengguna dengan user_id 12476
select 
	seller_id, buyer_id, 
    total as nilai_transaksi, 
    created_at as tanggal_transaksi
from orders
where buyer_id = 12476
order by 3 desc
limit 10
#=========================
# Q = buatlah query agar menampilkan 10 pembeli dengan 
# rata-rata nilai transaksi terbesar yang bertransaksi minimal 2 kali di Januari 2020.
select buyer_id, 
	count(1) as jumlah_transaksi, 
    avg(total) as avg_nilai_transaksi
from orders 
where created_at>='2020-01-01' and 
	created_at<'2020-02-01'
group by 1
having count(1)>= 2
order by 3 desc
limit 10
#==========================
# Q = buatlah query  agar menampilkan semua 
# nilai transaksi minimal 20,000,000 di bulan Desember 2019
select 
	nama_user as nama_pembeli, 
    total as nilai_transaksi, 
    created_at as tanggal_transaksi
from orders
inner join users on buyer_id = user_id
where created_at>='2019-12-01' and 
	created_at<'2020-01-01'
and total >=20000000
order by 1
