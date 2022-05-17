FILENAME=$1

sshpass -p 'femu' scp -P 8088 femu@localhost:~/sysbench/src/result/$1 .
