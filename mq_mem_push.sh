#!/bin/bash
# vm_used_total value
vm_used_total=`/usr/lib/rabbitmq/bin/rabbitmqctl status | grep "memory," -A 13 | awk -F , '/total/ {print \$2}' | cut -d } -f 1`
#echo "vm_used_total : $vm_used_total"
# vm_mem_limit value
vm_mem_limit=`/usr/lib/rabbitmq/bin/rabbitmqctl status | grep "memory_limit" | awk -F , '{print \$2}' | cut -d } -f1` 
#echo "vm_mem_limit : $vm_mem_limit"
# current memory percent value
a=`awk 'BEGIN {printf "%.2f\n",('$vm_used_total'/'$vm_mem_limit')*100}'`
ts=`date +%s`;

curl -X POST -d "[{
	\"metric\": \"mq-mem-used-percent\", 
	\"endpoint\": \"sns_mq-10.11.161.136\", 
	\"timestamp\": $ts,
	\"step\": 60,
	\"value\": $a,
	\"counterType\": \"GAUGE\",
	\"tags\": \"name=rabbitmq.mem.percent\"
	}]" http://127.0.0.1:1988/v1/push
