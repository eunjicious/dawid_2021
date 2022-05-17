OP="JESD"

for op in $OP 
do
#       datafile=perf_"$op".rslt
        datafile=result.txt
        outfile=perf_"$op".eps
    
        ylabel="IOPs"
        xlabel="PROTECT_RATIO"

#       ymax=`(cat perf_$op.rslt | tail -n 1 | tr " " "\n"| sort -nr | head -n 1 | awk '{print $1 * 1.3}')`
#       ymax=$`(cat ycsb_8_"$bench".dat | tail -n 1 | tr " " "\n" | sort -nr | head -n 1 | awk '{print $1 * 1.3}')`
#ymax=$(cat ycsb_8_"$bench".dat | awk '{print $2}'| sort -nr | head -n 1 | awk '{print $1 * 1.3}')
#       ymax=cat $data | tail -n 1 | awk '{print $4 * 1.3}'


        opt_list="`echo '-'``echo 'e'` `echo datafile=\'$datafile\'`"
        opt_list="$opt_list `echo '-'``echo 'e'` `echo outfile=\'$outfile\'`"
        opt_list="$opt_list `echo '-'``echo 'e'` `echo gtitle=\'$graphtitle\'`"
        opt_list="$opt_list `echo '-'``echo 'e'` `echo gylabel=\'$ylabel\'`"
        opt_list="$opt_list `echo '-'``echo 'e'` `echo gxlabel=\'$xlabel\'`"
        opt_list="$opt_list `echo '-'``echo 'e'` `echo gymax=\'$ymax\'`"

        gnuplot $opt_list perf_hist.cfg
        open $outfile
done        

