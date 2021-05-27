# suspicious_transactions

## Model the data
[Schema](https://github.com/jdfwsp/suspicious_transactions/blob/main/Files/Code/schema.sql)

## Create views for analysis
[Queries](https://github.com/jdfwsp/suspicious_transactions/blob/main/Files/Code/queries.sql)
### - Isolate the transactions of each cardholder:
```
create view by_cardholder as
select cardholder_id, transaction_id, date, amount
from full_data
order by cardholder_id, date;
```
### - Count transactions less than $2 for each cardholder:
|num_small_tx|name|
|------------|----|
|7|Austin Johnson|
|6|Beth Hernandez|
|22|Brandon Pineda|
|19|Crystal Clark|
|4|Dana Washington|
|16|Danielle Green|
|3|Elizabeth Sawyer|
|9|Gary Jacobs|
|19|John Martin|
|19|Kevin Spencer|
|12|Kyle Tucker|
|3|Laurie Gibbs|
|19|Malik Carlson|
|16|Mark Lewis|
|20|Matthew Gutierrez|
|26|Megan Price|
|4|Michael Carroll|
|16|Michael Floyd|
|16|Nancy Contreras|
|22|Peter Mckay|
|10|Robert Johnson|
|14|Sara Cooper|
|18|Sean Taylor|
|11|Shane Shaffer|
|22|Stephanie Dalton|

The maximum amount that any particular cardholder could've been hacked for is $52, if the hacker is using the small transaction method.  There is much better evidence for a hacked card with transactions over a few hundred dollars.
### - Top 100 transactions between 7 & 9 AM

|transaction_id|amount|time|merch_type|
|--------------|------|----|----------|
|3163|1894.0000000000002|07:22:03|bar|
|2451|1617.0000000000002|08:26:08|bar|
|2840|1334.0|07:18:09|bar|
|1442|1131.0|08:07:03|restaurant|
|968|1060.0|08:48:40|restaurant|
|1368|1017.0|08:28:55|bar|
|1620|1009.0|07:41:59|coffee shop|
|208|748.0|08:51:41|pub|
|774|100.0|07:17:21|coffee shop|
|2540|23.13|07:15:18|food truck|
|2523|20.71|07:17:14|coffee shop|
|3005|20.44|08:16:54|food truck|
|2677|19.86|07:16:04|pub|
--snip--
|1251|11.73|07:06:20|food truck|
|1843|11.72|08:33:49|coffee shop|
|1797|11.7|07:45:28|food truck|
|1356|11.68|07:37:03|pub|
|887|11.65|08:21:59|pub|

There are two reasons this view seems to be better evidence of fraud, one is the amount of transactions greater than $200, the other is transactions with tiny fractions of a cent.  They both seem out of place.
### - Transactions over $200 by hour
|Tx > $200|Hour|
|-----|---------|
|7|6|
|7|23|
|7|15|
|7|13|
|5|11|
|5|8|
|5|1|
|5|2|
|4|16|
|4|19|
|4|18|
|4|21|
|4|17|
|4|5|
|4|10|
|4|3|
|4|22|
|3|7|
|3|9|
|3|20|
|2|14|
|2|4|
|2|12|
|1|0|

The hours of 7 & 9 are low on the list of hours in which there were high dollar transactions.
### - Top 5 merchants prone to being hacked by small transactions
|Merchant Name|Small Transactions|
|----------|------------|
|Wood-Ramirez|7|
|Hood-Phillips|6|
|Baker Inc|6|
|Mcdaniel, Hines and Mcfarland|5|
|Hamilton-Mcfarland|5|

[Visual Analysis](https://github.com/jdfwsp/suspicious_transactions/blob/main/Files/Code/visual_data_analysis.ipynb)

![Cardholder 2](https://github.com/jdfwsp/suspicious_transactions/blob/main/Files/Images/cardholder_2.png)


![Cardholder 18](https://github.com/jdfwsp/suspicious_transactions/blob/main/Files/Images/cardholder_18.png)

![Combined Plot 2 & 18](https://github.com/jdfwsp/suspicious_transactions/blob/main/Files/Images/2_and_18.png)

![Cardholder 25 January - June](https://github.com/jdfwsp/suspicious_transactions/blob/main/Files/Images/boxplot.png)

[Challenge](https://github.com/jdfwsp/suspicious_transactions/blob/main/Files/Code/challenge.ipynb)

