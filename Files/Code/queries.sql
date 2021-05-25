
select * from card_holder ch ;
select * from credit_card cc ;
select * from merchant_category mc ;
select * from merchant m ;
select * from "transaction" t ;
drop table full_data ;
drop table "transaction" ;
SELECT
	ch.name,
	cc.card,
	cc.cardholder_id,
	t.id as transaction_id,
	t.date::date as date,
	t.date::time as time,
	t.id_merchant,
	t.amount,
	m.id,
	m.name as merch_name,
	mc.id as merchant_category,
	mc.name as merch_type
into full_data
FROM
	card_holder ch
INNER JOIN credit_card cc 
    ON cc.cardholder_id = ch.id
INNER JOIN "transaction" t 
    ON t.card = cc.card
inner join merchant m 
	on t.id_merchant = m.id 
inner join merchant_category mc 
	on m.id_merchant_category = mc.id 
order by t.id;

-- group transactions by cardholder
select name, count(*) as "num_tx"
into tx_per_person
from full_data 
group by name
order by name;

drop table small_tx_per_person;

-- count transactions < $2
select count(*) as "num_small_tx", name
into small_tx_per_person
from full_data fd 
where amount <= 2
group by name
order by name;

select count(*) as "num_tx", merch_type, name
from full_data 
where amount <= 2
group by merch_type, name
order by name, num_tx desc;

select * from tx_per_person tpp ;
select * from small_tx_per_person stpp ;

select 
	tpp.name,
	100 * stpp.num_small_tx/tpp.num_tx::float as percentage
from tx_per_person tpp 
inner join small_tx_per_person stpp 
	on tpp.name = stpp.name
order by percentage desc ;

-- top 100 highest tx between 7 & 9 am
select transaction_id, amount, time, merch_type from full_data fd 
where time between '07:00:00' and '09:00:00'
order by amount desc limit 100;

select amount, time from full_data fd 
where amount > 300
order by amount desc limit 100;

-- top 5 merchants prone to being hacked using small transactions
select merch_name, count(*) as "sus_merch_tx"
from full_data fd where amount <= 2
group by merch_name
order by sus_merch_tx desc limit 5;

-- extract hour
select count (*), extract(hour from date) from "transaction"
where amount <= 2
group by date_part
order by count desc;













