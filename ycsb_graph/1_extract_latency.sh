#!/bin/bash
engines="leveldb wiredtiger rocksdb jellyfish"
engine="LevelDB WiredTiger RocksDB JFDB"
thread="16"
benchs="a b c d e f"

for bench in $benchs
do
	fname="ycsb_16_"$bench"_lat.dat"
	echo "work" $engine > $fname

	case $bench in
		a) detail="READ UPDATE";;
		b) detail="READ UPDATE";;
		c) detail="READ";;
		d) detail="INSERT READ";;
		e) detail="INSERT SCAN";;
		f) detail="READ UPDATE READ-MODIFY-WRITE";;
	esac

	ben=$(echo $bench | tr '[a-z]' '[A-Z]')
	echo "$ben $engine" > $fname


	for de in $detail
	do	
		str="$ben"_
		if [[ $de == "READ-MODIFY-WRITE" ]]; then
			str+="RMW "
		else
			str+="$de "
		fi
		for en in $engines
		do
			str+=$(cat "$en"_run_"$bench"_th"$thread".txt | grep "$de"] |grep "AverageLatency" | awk '{print $3}')
			str+=" "
		done
		echo $str >> $fname

	done
done

