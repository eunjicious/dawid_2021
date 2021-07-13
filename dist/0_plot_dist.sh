#benchs="rw sw synths synthr synthz realw realf realw_1 realf_1"


#for bench in $@;
#for bench in $benchs;
#do
#datafile=temp.res
datafile=./linkbench/linkbench_r_dist.dat
#datafile=./filebench/webserver_dist.dat
outfile=linkbench_test.eps
graphtitle="$bench"

#ylabel="IOPS"
#xlabel="Buff-Size(KB)"

#ymax=$(cat "$bench".dat | awk '{print $2}'| sort -nr | head -n 1 | awk '{print $1 * 1.5}')

opt_list="`echo '-'``echo 'e'` `echo datafile=\'$datafile\'`"
opt_list="$opt_list `echo '-'``echo 'e'` `echo outfile=\'$outfile\'`"
opt_list="$opt_list `echo '-'``echo 'e'` `echo gtitle=\'$graphtitle\'`"
opt_list="$opt_list `echo '-'``echo 'e'` `echo gylabel=\'$ylabel\'`"
opt_list="$opt_list `echo '-'``echo 'e'` `echo gxlabel=\'$xlabel\'`"
opt_list="$opt_list `echo '-'``echo 'e'` `echo gymax=\'$ymax\'`"

gnuplot $opt_list perf_iops.cfg && open $outfile
#done



