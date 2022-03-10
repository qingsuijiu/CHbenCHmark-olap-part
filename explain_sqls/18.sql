-- using 1365545250 as a seed to the RNG

explain select     c_last, c_id o_id, o_entry_d, o_ol_cnt, sum(ol_amount)
from     tpcc_100.customer, tpcc_100.orders, tpcc_100.order_line
where     c_id = o_c_id
     and c_w_id = o_w_id
     and c_d_id = o_d_id
     and ol_w_id = o_w_id
     and ol_d_id = o_d_id
     and ol_o_id = o_id
group by o_id, o_w_id, o_d_id, c_id, c_last, o_entry_d, o_ol_cnt
having     sum(ol_amount) > 200
order by sum(ol_amount) desc, o_entry_d LIMIT 10;
