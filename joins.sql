CREATE TABLE region (
id integer PRIMARY KEY, 
name bpchar
);

CREATE TABLE sales_reps ( 
id integer PRIMARY KEY, 
name bpchar, 
region_id integer,
FOREIGN KEY (region_id) REFERENCES region(id)
) ;

CREATE TABLE accounts (
id integer PRIMARY KEY, 
name bpchar UNIQUE NOT NULL, 
website bpchar NOT NULL, 
lat numeric (11,8), 
long numeric (11,8), 
primary_poc bpchar, 
sales_rep_id integer,
FOREIGN KEY (sales_rep_id) REFERENCES sales_reps (id)
);


CREATE TABLE orders (
id integer PRIMARY KEY,
account_id integer, 
occurred_at timestamp, 
standard_qty integer, 
gloss_aty integer, 
poster_qty integer,
total integer, 
standard_amt_usd numeric(10,2), 
gloss_amt_usd numeric (10,2), 
poster_amt_usd numeric (10,2), 
total_amt_usd numeric (10,2),
FOREIGN KEY (account_id) REFERENCES accounts (id)
);

CREATE TABLE web_events (
id integer PRIMARY KEY, 
account_id integer, 
occurred_at timestamp, 
channel bpchar NOT NULL,
FOREIGN KEY (account_id) REFERENCES accounts (id)
);

SELECT accounts.primary_poc, 'Walmart' AS company_name,
web_events.occurred_at, web_events.channel
FROM accounts
JOIN web_events ON accounts.id = web_events.account_id
WHERE accounts.name = 'Walmart'
LIMIT 10;

SELECT region.name, sales_reps.name, accounts.name
FROM sales_reps
JOIN region ON region.id = sales_reps.region_id
JOIN accounts ON sales_reps.id = accounts.sales_rep_id
ORDER BY accounts.name ASC
LIMIT 10;

SELECT region.name, accounts.name, total_amt_usd/ NULLIF(total,0) + 0.01 AS unit_price
FROM orders
JOIN accounts ON accounts.id = orders.account_id
JOIN sales_reps ON sales_reps.id = accounts.sales_rep_id
JOIN region ON region.id = sales_reps.region_id
ORDER BY accounts.name ASC
LIMIT 10;

SELECT region.name, accounts.name, sales_reps.name
FROM sales_reps
JOIN region ON region.id = sales_reps.region_id
JOIN accounts ON accounts.sales_rep_id = sales_reps.id
WHERE region.name = 'Midwest'
ORDER BY accounts.name ASC
LIMIT 10;

SELECT region.name, accounts.name, sales_reps.name
FROM sales_reps
JOIN region ON region.id = sales_reps.region_id
JOIN accounts ON accounts.sales_rep_id = sales_reps.id
WHERE sales_reps.name LIKE 'S%' AND region.name = 'Midwest'
ORDER BY accounts.name ASC
LIMIT 10;

SELECT region.name, accounts.name, sales_reps.name
FROM sales_reps
JOIN region ON region.id = sales_reps.region_id
JOIN accounts ON accounts.sales_rep_id = sales_reps.id
WHERE sales_reps.name LIKE 'K%' AND region.name = 'Midwest'
ORDER BY accounts.name ASC
LIMIT 10;

SELECT region.name, accounts.name, total_amt_usd/ NULLIF(total,0) + 0.01 AS unit_price
FROM orders
JOIN accounts ON accounts.id = orders.account_id
JOIN sales_reps ON accounts.sales_rep_id = sales_reps.id 
JOIN region ON  region.id = sales_reps.region_id
WHERE standard_qty > 100
LIMIT 10;

SELECT region.name, accounts.name, total_amt_usd/ NULLIF(total,0) + 0.01 AS unit_price
FROM orders
JOIN accounts ON accounts.id = orders.account_id
JOIN sales_reps ON accounts.sales_rep_id = sales_reps.id 
JOIN region ON  region.id = sales_reps.region_id
WHERE standard_qty > 100 
AND poster_qty > 50
LIMIT 10;

SELECT DISTINCT accounts.name, web_events.channel
FROM accounts
JOIN web_events ON accounts.id = web_events.account_id
WHERE accounts.id = 1001
LIMIT 10;











































































