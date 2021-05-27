select
	ch.name,
	cc.card,
	cc.cardholder_id,
	t.id as transaction_id,
	t.date as date,
	t.date::time as time,
	t.id_merchant,
	t.amount,
	m.id,
	m.name as merch_name,
	mc.id as merchant_category,
	mc.name as merch_type
into full_data
from
	card_holder ch
inner join credit_card cc 
    on cc.cardholder_id = ch.id
inner join "transaction" t 
    on t.card = cc.card
inner join merchant m 
	on t.id_merchant = m.id 
inner join merchant_category mc 
	on m.id_merchant_category = mc.id 
order by t.id;

-- group transactions by cardholder
create view num_tx as
select name, count(*) as "num_tx"
from full_data 
group by name
order by name;

-- count transactions < $2
create view num_small as
select count(*) as "num_small_tx", name
from full_data fd 
where amount <= 2
group by name
order by name;

-- top 100 highest tx between 7 & 9 am
create view high_100 as
select transaction_id, amount, time, merch_type from full_data fd 
where time between '07:00:00' and '09:00:00'
order by amount desc limit 100;

-- top 5 merchants prone to being hacked using small transactions
create view top_5_merch as
select merch_name, count(*) as "sus_merch_tx"
from full_data fd where amount <= 2
group by merch_name
order by sus_merch_tx desc limit 5;

-- extract hour
create view hour_tx as
select count (*), extract(hour from date) from "transaction"
where amount <= 2
group by date_part
order by count desc;







