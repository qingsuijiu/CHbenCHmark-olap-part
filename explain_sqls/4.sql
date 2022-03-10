-- using 1365545250 as a seed to the RNG

explain select    o_ol_cnt, count(*) as order_count
from    tpcc_100.orders
    where exists (select *
            from tpcc_100.order_line
            where o_id = ol_o_id
            and o_w_id = ol_w_id
            and o_d_id = ol_d_id
            and ol_delivery_d >= o_entry_d)
group    by o_ol_cnt
order    by o_ol_cnt LIMIT 10;
