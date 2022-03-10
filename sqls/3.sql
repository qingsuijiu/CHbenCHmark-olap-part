-- using 1365545250 as a seed to the RNG
select   ol_o_id, ol_w_id, ol_d_id,
     sum(ol_amount) as revenue, o_entry_d
from      tpcc_100.customer, tpcc_100.new_orders, tpcc_100.orders, tpcc_100.order_line
where      c_state like 'A%'
     and c_id = o_c_id
     and c_w_id = o_w_id
     and c_d_id = o_d_id
     and no_w_id = o_w_id
     and no_d_id = o_d_id
     and no_o_id = o_id
     and ol_w_id = o_w_id
     and ol_d_id = o_d_id
     and ol_o_id = o_id
group by ol_o_id, ol_w_id, ol_d_id, o_entry_d
order by revenue desc, o_entry_d LIMIT 10;
