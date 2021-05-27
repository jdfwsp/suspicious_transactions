# suspicious_transactions

## Model the data
[Schema](https://github.com/jdfwsp/suspicious_transactions/blob/main/Files/Code/schema.sql)

## Create views for analysis
[Queries](https://github.com/jdfwsp/suspicious_transactions/blob/main/Files/Code/queries.sql)
### - Isolate the transactions of each cardholder:
```
create view by_cardholder as
select cardholder_id, transaction_id, date
from full_data
order by cardholder_id, date;

create view num_tx as
select name, count(*) as "num_tx"
from full_data 
group by name
order by name;
```
### - Count transactions less than $2 for each cardholder:
```
create view num_small as
select count(*) as "num_small_tx", name
from full_data fd 
where amount <= 2
group by name
order by name;
```
Conclusion: More than half of cardholders had more than 15 transactions less than $2.

[Visual Analysis](https://github.com/jdfwsp/suspicious_transactions/blob/main/Files/Code/visual_data_analysis.ipynb)
[Challenge](https://github.com/jdfwsp/suspicious_transactions/blob/main/Files/Code/challenge.ipynb)

