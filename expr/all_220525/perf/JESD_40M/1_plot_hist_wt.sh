#OP="SEQ RAND JESD"
OP="JESD_40M"

for op in $OP 
do
#       datafile=perf_"$op".rslt
        datafile=wt_result.txt
        outfile=wt.eps
    
        ylabel="Write_Traffic"
        xlabel="PROTECT_RATIO"

#       ymax=`(cat perf_$op.rslt | tail -n 1 | tr " " "\n"| sort -nr | head -n 1 | awk '{print $1 * 1.3}')`
#       ymax=$`(cat ycsb_8_"$bench".dat | tail -n 1 | tr " " "\n" | sort -nr | head -n 1 | awk '{print $1 * 1.3}')`
#ymax=$(cat ycsb_8_"$bench".dat | awk '{print $2}'| sort -nr | head -n 1 | awk '{print $1 * 1.3}')
#       ymax=cat $data | tail -n 1 | awk '{print $4 * 1.3}'
	ymax=`(cat $datafile | head -n 2 | tail -n 1 | awk '{print $2 *1.5}')`
#	echo $ymax
#	echo $datafile
	
        opt_list="`echo '-'``echo 'e'` `echo datafile=\'$datafile\'`"
        opt_list="$opt_list `echo '-'``echo 'e'` `echo outfile=\'$outfile\'`"
        opt_list="$opt_list `echo '-'``echo 'e'` `echo gtitle=\'$graphtitle\'`"
        opt_list="$opt_list `echo '-'``echo 'e'` `echo gylabel=\'$ylabel\'`"
        opt_list="$opt_list `echo '-'``echo 'e'` `echo gxlabel=\'$xlabel\'`"
        opt_list="$opt_list `echo '-'``echo 'e'` `echo gymax=\'$ymax\'`"

        gnuplot $opt_list perf_hist_wt.cfg
        open $outfile
done        

