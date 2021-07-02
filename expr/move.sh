workload="rand_w seq_w"
bsize="1 128 256 512 1024 2048"


for wk in $workload; do
	for bs in $bsize; do
		sdir=./$wk/$bs
		ddir=./micro/perf_result

		echo "mv $sdir/*.perf $ddir"
		mv $sdir/*.perf $ddir

	done
done
