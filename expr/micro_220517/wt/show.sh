

workloads="SEQ RAND JESD"

for wk in $workloads; do
	fname="$wk"_result.txt
	echo $fname 
	cat $fname

done
