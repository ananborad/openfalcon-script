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
