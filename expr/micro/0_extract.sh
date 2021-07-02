workload="rw sw"
qsize="1 128 256 512 1024 2048"
prot_ratio=10
trc_dir=./perf_result

for wk in $workload; do
	rfname="$wk".perf
	mv $rfname $rfname.bak
	echo "buff-size dawid" > $rfname

	for qs in $qsize; do
		echo "$wk $qs ..."
		prefix=$trc_dir/dawid_"$wk"_"$qs"_"$prot_ratio"
		iops=`grep -rn "IOPS" "$prefix"*.perf | awk '{print $2}' | sort -n | head -n 5 | tail -n 1`
		echo "$qs" "$iops" >> $rfname
	done	

	cat $rfname
done




#while [[ $qsize -le $MAX_QSIZE ]]; do
#	rfname=iops_"$qsize".perf
#        grep -rn "IOPS" ./"$qsize"/result_VECTOREDRSET_"$qsize"_* | awk '{print $2}' | sort -n > "$rfname" 
#	#echo ./"$qsize"/result_VECTOREDRSET_"$qsize"_*
#	qsize=$(( qsize + qsize ))
#done
