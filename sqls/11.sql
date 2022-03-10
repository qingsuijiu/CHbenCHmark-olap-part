-- using 1365545250 as a seed to the RNG

select     s_i_id, sum(s_order_cnt) as ordercount
from     tpcc_100.stock, tpcc_100.supplier, tpcc_100.nation
where     mod((s_w_id * s_i_id),10000) = su_suppkey
     and su_nationkey = n_nationkey
     and n_name = 'Germany'
group by s_i_id
having   sum(s_order_cnt) >
        (select sum(s_order_cnt) * .005
        from tpcc_100.stock, tpcc_100.supplier, tpcc_100.nation
        where mod((s_w_id * s_i_id),10000) = su_suppkey
        and su_nationkey = n_nationkey
        and n_name = 'Germany')
order by ordercount desc LIMIT 10;
