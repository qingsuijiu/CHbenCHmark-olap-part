#!/bin/bash

function arrayRandomSort()
{
	oldArray=$1
	newArray=()
	# 原数组长度
	oriLen=${#oldArray[*]}
	for i in $(seq 0 ${oriLen-1})
	do   
	    # 每次随机取出一个值后的长度是否为0
		len=${#oldArray[*]}
		if [ ${len} -eq 0 ];then
			echo ${newArray[*]}
			exit 0
		fi
		# 在数组长度范围内取一个下标
		randomNum=$((RANDOM%${len}))
		# echo ${oldArray[$randomNum]}
		# 将取出的值赋予新数组
		newArray[$i]=${oldArray[$randomNum]}
		# 删除取出的数组中的值
        unset oldArray[$randomNum]
		# 将数组重新保存，刷新下标
		oldArray=(${oldArray[*]})
    done
}

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

oldArray=($(seq 1 22))
# 调用arrayRandomSort方法
newArray=$(arrayRandomSort ${oldArray})
# 数组转为字符串

echo $(date +%F%n%T) >> res.log
for loop in ${newArray[*]}
do
    echo "test${loop}"
    start=$(date +%s.%N)
    mysql -h10.224.158.165 -P3311 -uroot -p123456 tpcc_100 -t < sqls/${loop}.sql > logs/${loop}.log
    # sleep 2
    end=$(date +%s.%N)

    latency=${timediff $start $end}
    echo "${loop}" >> res_${thread_num}.log
    echo "${lantency}" >> res_${thread_num}.log
done

