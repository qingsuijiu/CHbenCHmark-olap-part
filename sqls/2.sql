-- using 1365545250 as a seed to the RNG
-- set table.exec.use-olap-mode=false;set table.exec.shuffle-mode=ALL_EDGES_PIPELINED;set pipeline.operator-chaining=true;
select      su_suppkey, su_name, n_name, i_id, i_name, su_address, su_phone, su_comment
from     tpcc_100.item, tpcc_100.supplier, tpcc_100.stock, tpcc_100.nation, tpcc_100.region,
     (select s_i_id as m_i_id,
         min(s_quantity) as m_s_quantity
     from     tpcc_100.stock, tpcc_100.supplier, tpcc_100.nation, tpcc_100.region
     where     mod((s_w_id*s_i_id),10000)=su_suppkey
          and su_nationkey=n_nationkey
          and n_regionkey=r_regionkey
          and r_name like 'Europ%'
     group by s_i_id) m
where      i_id = s_i_id
     and mod((s_w_id * s_i_id), 10000) = su_suppkey
     and su_nationkey = n_nationkey
     and n_regionkey = r_regionkey
     and i_data like '%b'
     and r_name like 'Europ%'
     and i_id=m_i_id
     and s_quantity = m_s_quantity
order by n_name, su_name, i_id LIMIT 10;
