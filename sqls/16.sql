-- using 1365545250 as a seed to the RNG

select     i_name,
     substr(i_data, 1, 3) as brand,
     i_price,
     count(distinct (mod((s_w_id * s_i_id),10000))) as supplier_cnt
from     tpcc_100.stock, tpcc_100.item
where     i_id = s_i_id
     and i_data not like 'zz%'
     and (mod((s_w_id * s_i_id),10000) not in
        (select su_suppkey
         from tpcc_100.supplier
         where su_comment like '%bad%'))
group by i_name, substr(i_data, 1, 3), i_price
order by i_name desc LIMIT 10;

