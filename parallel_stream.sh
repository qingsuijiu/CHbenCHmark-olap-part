#!/bin/bash

total_thread_num=$1
exec_time=3600

for thread_num in $(seq 1 ${total_thread_num})
do
    nohup bash single_stream.sh ${thread_num} &
done

sleep ${exec_time}

