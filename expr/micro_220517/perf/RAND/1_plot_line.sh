
#benchs="rw sw synths synthr synthz realw realf realw_1 realf_1 reallr_1 realtpc_1"
#benchs="realw_opt_1 realf_opt_1 reallr_opt_1 realtpc_opt_1"
#benchs="realw_opt realf_opt reallr_opt realtpc_opt" 
benchs="result"

#for bench in $@;
for bench in $benchs;
do
	datafile="$bench".txt
	outfile="$bench".eps
	graphtitle="$bench"
	
	ylabel="IOPS"
	xlabel="PROTECTED_RATIO"

	ymax=$(cat "$bench".txt | awk '{print $2}'| sort -nr | head -n 1 | awk '{print $1 * 1.5}')
	#ymax=$(cat "$bench".txt | awk '{print $2}'|sort -nr | head -n 1 | awk '{print $1 * 2.0}')

	opt_list="`echo '-'``echo 'e'` `echo datafile=\'$datafile\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo outfile=\'$outfile\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo gtitle=\'$graphtitle\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo gylabel=\'$ylabel\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo gxlabel=\'$xlabel\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo gymax=\'$ymax\'`"
	
	gnuplot $opt_list perf_line.cfg && open $outfile
done



