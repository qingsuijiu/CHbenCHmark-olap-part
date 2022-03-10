-- using 1365545250 as a seed to the RNG

explain select     n_name,
     sum(ol_amount) as revenue
from     tpcc_100.customer, tpcc_100.orders, tpcc_100.order_line, tpcc_100.stock, tpcc_100.supplier, tpcc_100.nation, tpcc_100.region
where     c_id = o_c_id
     and c_w_id = o_w_id
     and c_d_id = o_d_id
     and ol_o_id = o_id
     and ol_w_id = o_w_id
     and ol_d_id=o_d_id
     and ol_w_id = s_w_id
     and ol_i_id = s_i_id
     and mod((s_w_id * s_i_id),10000) = su_suppkey
     and ascii(substr(c_state,1,1)) = su_nationkey
     and su_nationkey = n_nationkey
     and n_regionkey = r_regionkey
     and r_name = 'Europe'
     and o_entry_d >= '2015-01-02 00:00:00.000000'
group by n_name
order by revenue desc LIMIT 10;
