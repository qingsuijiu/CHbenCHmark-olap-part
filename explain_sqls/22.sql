-- using 1365545250 as a seed to the RNG

explain select     substr(c_state,1,1) as country,
     count(*) as numcust,
     sum(c_balance) as totacctbal
from     tpcc_100.customer
where     substr(c_phone,1,1) in ('1','2','3','4','5','6','7')
     and c_balance > (select avg(c_balance)
              from      tpcc_100.customer
              where  c_balance > 0.00
                  and substr(c_phone,1,1) in ('1','2','3','4','5','6','7'))
     and not exists (select *
             from    tpcc_100.orders
             where    o_c_id = c_id
                     and o_w_id = c_w_id
                    and o_d_id = c_d_id)
group by substr(c_state,1,1)
order by substr(c_state,1,1) LIMIT 10;
