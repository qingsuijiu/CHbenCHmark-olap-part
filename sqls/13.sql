-- using 1365545250 as a seed to the RNG

select     c_count, count(*) as custdist
from     (select c_id, count(o_id) as c_count
     from tpcc_100.customer left outer join tpcc_100.orders on (
        c_w_id = o_w_id
        and c_d_id = o_d_id
        and c_id = o_c_id
        and o_carrier_id > 8)
     group by c_id)  c_orders
group by c_count
order by custdist desc, c_count desc LIMIT 10;
