version="dawid orig"
workload="rw sw"
qsize="1 128 256 512 1024 2048 4096 8192 16384"
prot_ratio=10
trc_dir=./perf_result

#for vs in $version; do
for wk in $workload; do
	rfname="$wk".perf
	mv $rfname $rfname.bak
	echo "buff-size orig dawid" > $rfname

	for qs in $qsize; do
		echo "$wk $qs ..."

		#prefix=$trc_dir/"$vs"_"$wk"_"$qs"_"$prot_ratio"
		dawid_prefix=$trc_dir/dawid_"$wk"_"$qs"_"$prot_ratio"
		orig_prefix=$trc_dir/orig_"$wk"_"$qs"_"$prot_ratio"

		dawid_iops=`grep -rn "IOPS" "$dawid_prefix"*.perf | awk '{print $2}' | sort -n | head -n 5 | tail -n 1`
		orig_iops=`grep -rn "IOPS" "$orig_prefix"*.perf | awk '{print $2}' | sort -n | head -n 5 | tail -n 1`
		
		echo "$qs" "$orig_iops" "$dawid_iops" >> $rfname
	done	
	
	cat $rfname
done
#done




#while [[ $qsize -le $MAX_QSIZE ]]; do
#	rfname=iops_"$qsize".perf
#        grep -rn "IOPS" ./"$qsize"/result_VECTOREDRSET_"$qsize"_* | awk '{print $2}' | sort -n > "$rfname" 
#	#echo ./"$qsize"/result_VECTOREDRSET_"$qsize"_*
#	qsize=$(( qsize + qsize ))
#done
