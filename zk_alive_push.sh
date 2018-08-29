#!/bin/bash
a=`echo ruok | nc 127.0.0.1 2181 | grep imok -c`
ts=`date +%s`;

curl -X POST -d "[{
	\"metric\": \"zookeeper.alive\", 
	\"endpoint\": \"sns_md_kafka-10.11.161.139\", 
	\"timestamp\": $ts,
	\"step\": 60,
	\"value\": $a,
	\"counterType\": \"GAUGE\",
	\"tags\": \"name=zookeeper.alive\"
	}]" http://agent.mtpc.sohu.com/v1/push

