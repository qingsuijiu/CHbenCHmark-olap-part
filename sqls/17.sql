-- using 1365545250 as a seed to the RNG

select    sum(ol_amount) / 2.0 as avg_yearly
from tpcc_100.order_line, (select   i_id, avg(ol_quantity) as a
            from     tpcc_100.item, tpcc_100.order_line
            where    i_data like '%b'
                 and ol_i_id = i_id
            group by i_id) t
where ol_i_id = t.i_id
    and ol_quantity < t.a LIMIT 10;
