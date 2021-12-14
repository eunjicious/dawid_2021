
benchs="a b c d e f"
benchs="load_a run_a run_b run_c run_d run_e run_f"

#for bench in $@;
for bench in $benchs;
do
	datafile="ycsb_16"_"$bench".dat
	outfile="ycsb_16"_"$bench".eps
	graphtitle="$bench"
	
	ylabel="IOPS(x1000)"
	xlabel="KeyValueStore"
	
	#ymax=$(cat ycsb_8_"$bench".dat | tail -n 1 | tr " " "\n" | sort -nr | head -n 1 | awk '{print $1 * 1.3}')
	ymax=$(cat ycsb_16_"$bench".dat | awk '{print $2}'| sort -nr | head -n 1 | awk '{print $1 * 1.3}')
	
	opt_list="`echo '-'``echo 'e'` `echo datafile=\'$datafile\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo outfile=\'$outfile\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo gtitle=\'$graphtitle\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo gylabel=\'$ylabel\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo gxlabel=\'$xlabel\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo gymax=\'$ymax\'`"
	
	gnuplot $opt_list perf_iops.cfg && open $outfile
done



