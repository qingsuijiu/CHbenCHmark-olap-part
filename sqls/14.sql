-- using 1365545250 as a seed to the RNG

select    100.00 * sum(case when i_data like 'PR%' then ol_amount else 0 end) / (1+sum(ol_amount)) as promo_revenue
from tpcc_100.order_line, tpcc_100.item
where ol_i_id = i_id
    LIMIT 10;
