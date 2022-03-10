explain select   ol_number,
     sum(ol_quantity) as sum_qty,
--     sum(ol_amount) as sum_amount,
--     avg(ol_quantity) as avg_qty,
     avg(ol_amount) as avg_amount,
     count(*) as count_order
from    tpcc_100.order_line
group by ol_number order by ol_number LIMIT 10;
