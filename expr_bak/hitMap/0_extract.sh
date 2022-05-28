version="FIFO LRU OPT" 
#workload="blk_linkbench blk_filebench" 
#workload="fileserver webserver"
policy="FIFO DAWID"
workload="SEQ RAND JESD OLTP"
ratio="0.10 0.20 0.30 0.40 0.50 0.60 0.70 0.80 0.90 1"
#ratio="0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.10"
#ratio="0.001 0.002 0.003 0.004 0.005 0.006 0.007 0.008 0.009"
#start_rt=0.10
rst_dir=./trace_midx/rslt

for pl in $policy; do
	for wk in $workload; do
	        rfname="$wk"_"$pl".dat
	        #mv $rfname $rfname.bak
	        echo "POLICY FIFO LRU OPT" > $rfname
	
	        for rt in $ratio; do  
	                #fifo_prefix="$wk"_FIFO_"$start_rt"
	                #lru_prefix="$wk"_LRU_"$start_rt"
	                #opt_prefix="$wk"_OPT_"$start_rt"
			fifo_prefix=./FIFO/"$wk"_"$pl"
			echo $fifo_prefix
			lru_prefix=./LRU/"$wk"_"$pl"
			opt_prefix=./OPT/"$wk"_"$pl" 
				
	                fifo_rt=`grep -rn "FIFO ratio = $rt" "$fifo_prefix".rst | awk '{print $10}'`
	                lru_rt=`grep -rn "LRU ratio = $rt" "$lru_prefix".rst | awk '{print $10}'`
	                opt_rt=`grep -rn "OPT ratio = $rt" "$opt_prefix".rst | awk '{print $10}'`
		
        	        echo "$rt" "$fifo_rt" "$lru_rt" "$opt_rt" >> $rfname    
       	 	done

       	 	cat $rfname
	done 
done
