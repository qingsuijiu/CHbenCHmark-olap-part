#!/bin/bash

total_thread_num=$1

declare -a sta_array
for i in {1..22}
do
    sta_array[$i]=0
done

query_num=0
for thread_num in $(seq 1 ${total_thread_num})
do
    query_num=1
    while read line
    do
        # echo ${line}
        sta_array[${query_num}]=$(expr ${sta_array[${query_num}]} + ${line})
        query_num=$(expr ${query_num} + 1)
    done < res_${thread_num}.log
done

echo $(date +%F%n%T) >> sta_res.log
for i in {1..22}
do
    avg=$(echo "scale=2; ${sta_array[$i]}/${total_thread_num}" | bc)
    echo ${avg} >> sta_res.log
done