#OP="THREAD_NUM"
WORKLOAD="rand-iops jesd-iops"
WORKLOAD="all-iops"
#WORKLOAD="2016021616-LUN3.csv_w.trc 2016021616-LUN4.csv_w.trc 2016021618-LUN3.csv_w.trc fileserver_map.trc linkbench_r_map.trc ssdtrace-00.blk_w.trc ssdtrace-01.blk_w.trc webserver_map.trc"


#for op in $OP
for wk in $WORKLOAD
do
#	datafile=perf_"$op".rslt
	datafile=./$wk.dat
	outfile=$wk.eps
	
	ylabel="IOPS(x1000)"
	xlabel=""

#	ymax=`(cat $datfile | tail -n 1 | tr " " "\n"| sort -nr | head -n 1 | awk '{print $1 * 1.3}')`
#	ymax=$`(cat ycsb_8_"$bench".dat | tail -n 1 | tr " " "\n" | sort -nr | head -n 1 | awk '{print $1 * 1.3}')`
#ymax=$(cat ycsb_8_"$bench".dat | awk '{print $2}'| sort -nr | head -n 1 | awk '{print $1 * 1.3}')
#	ymax=cat $data | tail -n 1 | awk '{print $4 * 1.3}'
	ymax=`(cat $datafile | awk '{print $3}' | sort -nr | head -n 2 | tail -n 1 | awk '{print $1 * 1.2}')`
#	ymax=$max * 1.3

	opt_list="`echo '-'``echo 'e'` `echo datafile=\'$datafile\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo outfile=\'$outfile\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo gtitle=\'$graphtitle\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo gylabel=\'$ylabel\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo gxlabel=\'$xlabel\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo gymax=\'$ymax\'`"

	gnuplot $opt_list perf_iops.cfg 
	open $outfile
done
