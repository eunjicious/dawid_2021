#!/bin/bash -x  

engines=("lmdb" "leveldb" "wiredtiger" "rocksdb" "jellyfish")
engines="lmdb leveldb wiredtiger rocksdb jellyfish"
names=("LMDB" "LevelDB" "Wiredtiger" "RocksDB" "JFDB")
names="LMDB LevelDB Wiredtiger RocksDB JFDB"
#engines=("rocksdb" "jellyfish")
#names=("RocksDB" "JFDB")

thread="16"
benchs="a b c d e f"
benchs="load_a run_a run_b run_c run_d run_e run_f"
benchs="run_a run_b run_c run_d run_e run_f"

fname="ycsb_16.dat"
echo "work $names" > $fname
for bench in $benchs
do
	ben=$(echo $bench | tr '[a-z]' '[A-Z]')
	str="$ben "
	for en in $engines
	do
		str+=$(cat "$en"_"$bench"_th16.txt | grep "Throughput" | awk '{printf("%.2f\n", $3/1000)}' )
		str+=" "	
	done
	echo $str >> $fname
done
	

#./2_plot_iops.sh $benchs
