qsize="1 128 256 512 1024 2048 4096 8192 16384" 
#qsize="1"
workload="rw sw"
prot_ratio=10
#loop=1
max_loop=10

for wk in $workload; do
	for qs in $qsize; do
		loop=1
		rfname=orig_"$wk"_"$qs"_"$prot_ratio"
		while [[ $loop -le $max_loop ]]; do 
			cp dawid_"$wk"_1_"$prot_ratio"_"$loop".perf "$rfname"_"$loop".perf
			
			loop=$(( loop + 1 ))	
		done
	done
done
