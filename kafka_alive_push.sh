#!/bin/bash
a=`netstat -tnlp | grep 9092 | wc -l`
ts=`date +%s`;

curl -X POST -d "[{
	\"metric\": \"kafka.alive\", 
	\"endpoint\": \"sns_md_kafka-10.11.161.139\", 
	\"timestamp\": $ts,
	\"step\": 60,
	\"value\": $a,
	\"counterType\": \"GAUGE\",
	\"tags\": \"name=kafka.alive\"
	}]" http://agent.mtpc.sohu.com/v1/push

