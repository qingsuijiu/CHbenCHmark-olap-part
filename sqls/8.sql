-- using 1365545250 as a seed to the RNG

select     extract(year from o_entry_d) as l_year,
     sum(case when n2.n_name = 'Germany' then ol_amount else 0 end) / sum(ol_amount) as mkt_share
from     tpcc_100.item, tpcc_100.supplier, tpcc_100.stock, tpcc_100.order_line, tpcc_100.orders, tpcc_100.customer, tpcc_100.nation n1, tpcc_100.nation n2, tpcc_100.region
where     i_id = s_i_id
     and ol_i_id = s_i_id
     and ol_supply_w_id = s_w_id
     and mod((s_w_id * s_i_id),10000) = su_suppkey
     and ol_w_id = o_w_id
     and ol_d_id = o_d_id
     and ol_o_id = o_id
     and c_id = o_c_id
     and c_w_id = o_w_id
     and c_d_id = o_d_id
     and n1.n_nationkey = ascii(substr(c_state,1,1))
     and n1.n_regionkey = r_regionkey
     and ol_i_id < 1000
     and r_name = 'Europe'
     and su_nationkey = n2.n_nationkey
     and i_data like '%b'
     and i_id = ol_i_id
group by extract(year from o_entry_d)
order by l_year LIMIT 10;
