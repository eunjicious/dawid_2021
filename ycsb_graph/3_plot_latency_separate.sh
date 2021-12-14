benchs="a b c d e f"

for bench in $benchs
do
	datafile="ycsb_16_$bench"_lat.dat
	outfile="ycsb_16_lat_"$bench.eps
	
	ylabel="Latency(us)"
	xlabel="KeyValueStore"
	
	#ymax=$(cat ycsb_8_"$bench".dat | tail -n 1 | tr " " "\n" | sort -nr | head -n 1 | awk '{print $1 * 1.3}')
	ymax=$(cat ycsb_16_"$bench"_lat.dat | awk '{print $2}'| sort -nr | head -n 1 | awk '{print $1 * 1.3}')
		
	target_file=$(ls | grep -v lmdb | grep _th16.txt | grep -v load | grep "run_$bench")
	ymax=$(cat $target_file | grep  "AverageLatency" | awk '{print $3}' | sort -nr | head -n1 | awk '{print $1*1.5}')
	wc=$(wc -l $datafile | awk '{print $1}')	

	if [[ $wc == 2 ]] ; then
		xmin=-0.65
		xmax=0.65
	elif [[ $wc == 3 ]] ; then
		xmin=-0.55
		xmax=1.53
	elif [[ $wc == 4 ]] ; then
		xmin=-0.55
		xmax=2.5
	fi
	opt_list="`echo '-'``echo 'e'` `echo datafile=\'$datafile\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo outfile=\'$outfile\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo gtitle=\'$graphtitle\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo gylabel=\'$ylabel\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo gxlabel=\'$xlabel\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo gymax=\'$ymax\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo gxmax=\'$xmax\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo gxmin=\'$xmin\'`"

	gnuplot $opt_list perf_latency_separate.cfg 
	#gnuplot $opt_list perf_latency.cfg 
	open $outfile
done
