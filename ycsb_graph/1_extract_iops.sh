#!/bin/bash 

engines=("lmdb" "leveldb" "wiredtiger" "rocksdb" "jellyfish")
names=("LMDB" "LevelDB" "Wiredtiger" "RocksDB" "JFDB")
#engines=("rocksdb" "jellyfish")
#names=("RocksDB" "JFDB")

color=("7" "7" "7" "7" "8")
color=("8" "8" "8" "8" "8")
thread="16"
benchs="a b c d e f"
benchs="load_a run_a run_b run_c run_d run_e run_f"


for bench in $benchs; do
	fname="ycsb_16_"$bench".dat"
	#echo "work" $names > $fname
	echo "# engine" "$bench" "color" > $fname
	echo ${engines[0]}

	#str="$bench "
	j=1
	for (( i = 0 ; i < ${#engines[@]} ; i++, j++));
	do
		if [[ "${engines[$i]}" == "rocksdb" ]] ||  [[ "${engines[$i]}" == "jellyfish" ]];then
			echo "" > tmp
			for (( j = 1 ; j <= 4 ; j++));
			do
				cd mem_256m_th16_t$j
				cat "${engines[$i]}"_"$bench"_th"$thread".txt | grep "Throughput" | awk '{printf("%.2f\n", $3/1000)}' >> ../tmp
				cd ..
			done
			str=$(cat tmp | sort -r | tail -n 2 | head -n 1)
			rm tmp
		else
			str=$(cat "${engines[$i]}"_"$bench"_th"$thread".txt | grep "Throughput" | awk '{printf("%.2f\n", $3/1000)}')
		fi	
		#str=$(cat "${engines[$i]}"_"$bench"_th"$thread".txt | grep "Throughput" | awk '{print $3}')
		echo ${names[$i]} $str ${color[$i]} >> $fname
		#echo $j $str $j >> $fname
	done

	echo "$fname"
	cat $fname
done
	

./2_plot_iops.sh $benchs
