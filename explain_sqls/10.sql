-- using 1365545250 as a seed to the RNG

explain select     c_id, c_last, sum(ol_amount) as revenue, c_city, c_phone, n_name
from     tpcc_100.customer, tpcc_100.orders, tpcc_100.order_line, tpcc_100.nation
where     c_id = o_c_id
     and c_w_id = o_w_id
     and c_d_id = o_d_id
     and ol_w_id = o_w_id
     and ol_d_id = o_d_id
     and ol_o_id = o_id
     and o_entry_d <= ol_delivery_d
     and n_nationkey = ascii(substr(c_state,1,1))
group by c_id, c_last, c_city, c_phone, n_name
order by revenue desc LIMIT 10;
