-- using 1365545250 as a seed to the RNG
explain select    sum(ol_amount) as revenue
from tpcc_100.order_line
where ol_quantity between 1 and 100000 LIMIT 10;
