
#benchs="rw sw synths synthr synthz realw realf realw_1 realf_1 reallr_1 realtpc_1"
#benchs="realw_opt_1 realf_opt_1 reallr_opt_1 realtpc_opt_1"
#benchs="realw_opt realf_opt reallr_opt realtpc_opt" 
benchs="JESD_1 JESD_40 RAND_1 RAND_40 SEQ_1 SEQ_40"


#for bench in $@;
for bench in $benchs;
do
	datafile="$bench".rslt
	outfile="$bench".eps
	graphtitle="$bench"
	
	ylabel="Write-traffic(GB)"
#	xlabel="Target"

#ymax=$(cat "$bench".txt | awk '{print $2}'| sort -nr | head -n 1 | awk '{print $1 * 1.5}')
	if [[ $bench == "JESD" ]] ; then
		ymid=$(cat "$bench".rslt | awk '{print $2}'|sort -nr | head -n 1 | awk '{print $1 * 1.15}')
		ymax=$(cat "$bench".rslt | awk '{print $4}'|sort -nr | head -n 1 | awk '{print $1 * 1.15}')
	elif [[ $bench == "RAND" ]] ; then
		ymid=$(cat "$bench".rslt | awk '{print $2}'|sort -nr | head -n 1 | awk '{print $1 * 1.15}')
		ymax=$(cat "$bench".rslt | awk '{print $3}'|sort -nr | head -n 1 | awk '{print $1 * 2.5}')
	elif [[ $bench == "SEQ" ]] ; then
		ymid=$(cat "$bench".rslt | awk '{print $2}'|sort -nr | head -n 1 | awk '{print $1 * 1.15}')
#ymax=$(cat "$bench".rslt | awk '{print $3}'|sort -nr | head -n 1 | awk '{print $1 * 1.15}')
	fi		
	
	echo $ymax
	opt_list="`echo '-'``echo 'e'` `echo datafile=\'$datafile\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo outfile=\'$outfile\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo gtitle=\'$graphtitle\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo gylabel=\'$ylabel\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo gxlabel=\'$xlabel\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo gymax=\'$ymax\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo gymid=\'$ymid\'`"
	gnuplot $opt_list perf_wt_nosep.cfg && open $outfile

done



