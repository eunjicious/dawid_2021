
#benchs="rw sw synths synthr synthz realw realf realw_1 realf_1 reallr_1 realtpc_1"
benchs="realw_opt realf_opt reallr_opt realtpc_opt"

#for bench in $@;
for bench in $benchs;
do
	datafile="$bench".dat
	outfile="$bench".eps
	graphtitle="$bench"
	
	ylabel="IOPS"
	xlabel="Buff-Size(KB)"

	ymax=$(cat "$bench".dat | awk '{print $2}'| sort -nr | head -n 1 | awk '{print $1 * 1.5}')
	
	opt_list="`echo '-'``echo 'e'` `echo datafile=\'$datafile\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo outfile=\'$outfile\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo gtitle=\'$graphtitle\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo gylabel=\'$ylabel\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo gxlabel=\'$xlabel\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo gymax=\'$ymax\'`"
	
	gnuplot $opt_list perf_iops.cfg && open $outfile
done



