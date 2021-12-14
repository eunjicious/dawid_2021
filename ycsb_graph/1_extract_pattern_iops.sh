#!/bin/bash 

engines=("lmdb" "leveldb" "wiredtiger" "rocksdb" "jellyfish")
engines="lmdb leveldb wiredtiger rocksdb jellyfish"
names=("LMDB" "LevelDB" "Wiredtiger" "RocksDB" "JFDB")
names="LMDB LevelDB Wiredtiger RocksDB JFDB"

thread="16"
benchs="a b c d e f"
benchs="load_a run_a run_b run_c run_d run_e run_f"
benchs="run_a run_b run_c run_d run_e run_f"

for bench in $benchs
do
	fname="ycsb_16"_"$bench".dat
	rm $fname
	ben=$(echo $bench | tr '[a-z]' '[A-Z]')
	echo "$ben $names" > $fname
	str="$ben " 
	for en in $engines
	do
		str+=$(cat "$en"_"$bench"_th16.txt | grep "Throughput" | awk '{printf("%.2f\n", $3/1000)}' )
		str+=" "
	done
	echo $str >> $fname
done


