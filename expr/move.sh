workload="rand_w seq_w"
bsize="1 128 256 512 1024 2048 4096 8192 16384"


for wk in $workload; do
	for bs in $bsize; do
#		sdir=./$wk/$bs
		sdir=~/dawid_2021/FlashFTLDriver/eval/"$wk"/"$bs"
		ddir=./micro/perf_result

		echo "mv $sdir/*.perf $ddir"
		mv $sdir/*.perf $ddir

	done
done
