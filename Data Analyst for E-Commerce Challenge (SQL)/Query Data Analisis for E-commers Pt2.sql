# Q = Buatlah SQL query untuk mencari pembeli yang 
# sudah bertransaksi lebih dari 5 kali, dan setiap transaksi lebih dari 2,000,000.
select 
	nama_user as nama_pembeli,
	count(1) as jumlah_transaksi,
	sum(total) as total_nilai_transaksi,
	min(total) as min_nilai_transaksi
from orders 
join users 
on buyer_id = user_id
group by user_id, nama_user
having count(1) > 5 and min(total) > 2000000
order by 3 desc
#------------------------------------------------
# Q = buatlah SQL query untuk mencari pembeli dengan 10 kali transaksi 
# atau lebih yang alamat pengiriman transaksi selalu berbeda setiap transaksi.
select
	nama_user as nama_pembeli,
	count(1) as jumlah_transaksi,
	count(distinct(a.kodepos)) as distinct_kodepos,
	sum(total) as total_nilai_transaksi,
	avg(total) as avg_nilai_transaksi
from orders as a
inner join users b
on a.buyer_id = b.user_id
group by 1, user_id
having count(1) >= 10 and count(1) = count(distinct(a.kodepos))
order by 2 desc
#-------------------------------------------------
# Q = buatlah SQL query untuk mencari pembeli yang punya 8 atau lebih 
# transaksi yang alamat pengiriman transaksi sama dengan alamat pengiriman utama, 
# dan rata-rata total quantity per transaksi lebih dari 10.
select 
	nama_user as nama_pembeli,
	count(1) as jumlah_transaksi,
	sum(total) as jumlah_nilai_transaksi,
	avg(total) as avg_nilai_transaksi,
	avg(total_quantity) as avg_quantity_per_transaksi
from orders as a
inner join users as b
on a.buyer_id = b.user_id
inner join 
	(select order_id, 
	 	sum(quantity) as total_quantity 
	 from order_details 
	 group by 1) as summary_orders 
	 using(order_id)
where a.kodepos = b.kodepos
group by nama_user , user_id
having count(1) >= 8 and avg(total_quantity) > 10
order by 3 desc
#-------------------------------------------------
# Q = buatlah SQL query untuk mencari penjual yang 
# juga pernah bertransaksi sebagai pembeli minimal 7 kali.
select
	nama_user as nama_pengguna,
	jumlah_transaksi_beli,
	jumlah_transaksi_jual
from users 
join (select buyer_id,
	  count(1) as jumlah_transaksi_beli
	  from orders
	  group by 1
	 ) as pembeli on buyer_id = user_id
join (select seller_id,
	  count(1) as jumlah_transaksi_jual
	  from orders
	  group by 1
	 ) as penjual on seller_id = user_id
where jumlah_transaksi_beli >= 7
order by 1 
-----------------------------------------------
# Q = Buatlah SQL Query untuk menghitung rata-rata 
# lama waktu dari transaksi dibuat sampai dibayar, dikelompokkan per bulan.
select 
	extract(YEAR_MONTH from created_at) as tahun_bulan,
	count(1) as jumlah_transaksi,
	avg(datediff(paid_at, created_at)) as avg_lama_dibayar,
	min(datediff(paid_at, created_at)) as min_lama_dibayar,
	max(datediff(paid_at, created_at)) as max_lama_dibayar
from orders
where paid_at is not null
group by 1
order by 1


