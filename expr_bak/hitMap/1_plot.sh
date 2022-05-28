#benchs="rw sw synths synthr synthz realw realf realw_1 realf_1 reallr_1 realtpc_1"
#benchs="realw_opt_1 realf_opt_1 reallr_opt_1 realtpc_opt_1"
#benchs="realw_opt realf_opt reallr_opt realtpc_opt" 
#benchs="webserver fileserver"
#benchs="ssdtrace-01.blk_w.trc.rslt"
#benchs="2016021616-LUN3.csv_w.trc.rslt 2016021616-LUN4.csv_w.trc.rslt 2016021618-LUN3.csv_w.trc.rslt fileserver_map.trc.rslt linkbench_r_map.trc.rslt ssdtrace-00.blk_w.trc.rslt ssdtrace-01.blk_w.trc.rslt webserver_map.trc.rslt"
workload="SEQ RAND JESD OLTP" 
workload="JESD OLTP"
policy="FIFO DAWID"

#for bench in $@;
for pl in $policy;do
	for wk in $workload;do
	        datafile=./dat/"$wk"_"$pl".dat
	        #datafile=./dat/"$bench"
	        outfile=./eps/"$wk"_"$pl".eps
	#       graphtitle="$bench"
#	        graphtitle="Hit-Ratio-in-Write-Buffer"
   	 
	       	 ylabel="hit-ratio(Normalization)"
	        xlabel="Ratio(footprint)"
	
	        #ymax=$(cat "$bench".dat | awk '{print $2}'| sort -nr | head -n 1 | awk '{print $1 * 1.5}')
	        #ymax=$(cat "$datafile" | awk '{print $4}'|sort -nr | head -n 1 | awk '{print $1 * 1.001}')
			ymax=1.0
	        #ymin=$(cat "$datafile" | awk '{print $2}'|sort -nr | tail -n 2 | head -n 1 | awk '{print $1}')
			
			if [[ $wk == "JESD" ]]; then
				ymin=0.7
			else
				ymin=0.9
			fi
	#       echo $ymin
	#       echo $ymax
	
	        opt_list="`echo '-'``echo 'e'` `echo datafile=\'$datafile\'`"
	        opt_list="$opt_list `echo '-'``echo 'e'` `echo outfile=\'$outfile\'`"
	        opt_list="$opt_list `echo '-'``echo 'e'` `echo gtitle=\'$graphtitle\'`"
	        opt_list="$opt_list `echo '-'``echo 'e'` `echo gylabel=\'$ylabel\'`"
	        opt_list="$opt_list `echo '-'``echo 'e'` `echo gxlabel=\'$xlabel\'`"
	        opt_list="$opt_list `echo '-'``echo 'e'` `echo gymax=\'$ymax\'`"
	        opt_list="$opt_list `echo '-'``echo 'e'` `echo gymin=\'$ymin\'`"
	    
	        gnuplot $opt_list perf_iops.cfg && open $outfile
	done
done
