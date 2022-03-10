#!/bin/bash

function timediff() {
    start_time=$1
    end_time=$2

    start_s=${start_time%.*}
    start_nanos=${start_time#*.}
    end_s=${end_time%.*}
    end_nanos=${end_time#*.}

    if [ "$end_nanos" -lt "$start_nanos" ];then
        end_s=$(( 10#$end_s - 1 ))
        end_nanos=$(( 10#$end_nanos + 10**9 ))
    fi

    time=$(( 10#$end_s - 10#$start_s )).`printf "%03d\n" $(( (10#$end_nanos - 10#$start_nanos)/10**6 ))`

    echo $time
}

thread_num=$1

echo $(date +%F%n%T) >> res.log
for loop in $(seq 1 22)
do
    echo "test${loop}"
    start=$(date +%s.%N)
    mysql -h10.224.158.165 -P3311 -uroot -p123456 tpcc_100 -t < sqls/${loop}.sql > logs/${loop}.log
    # sleep 2
    end=$(date +%s.%N)
    mysql -h10.224.158.165 -P3311 -uroot -p123456 tpcc_100 -t < explain_sqls/${loop}.sql >> logs/${loop}.log

    latency=${timediff $start $end}
    echo "${latency}" >> res_${thread_num}.log
    echo "query ${loop} done, latency: ${latency}"
done

