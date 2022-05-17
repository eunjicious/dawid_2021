
WORKLOADS="SEQ RAND JESD"
RATIO="1 5 10 50 100"
POLICY="FIFO DAWID"
WORKLOADS="JESD"

echo "	ud md gud gmd" > COL.tmp

for wk in $WORKLOADS; do
	for rt in $RATIO; do 
		echo "$wk: protected ratio = $rt ....."
		fname=result/pt"$rt"_fio_"$wk"_FIFO_1_16_2.wt
		echo "FIFO" > FIFO.tmp
		awk '{printf("%d\n%d\n%d\n%d\n"), $3, $6, $9, $12}' $fname >> FIFO.tmp

		fname=result/pt"$rt"_fio_"$wk"_DAWID_1_16_2.wt
		echo "DAWID" > DAWID.tmp
		echo "" > COL.tmp
		awk '{printf("%d\n%d\n%d\n%d\n"), $3, $6, $9, $12}' $fname >> DAWID.tmp
		awk '{printf("%s\n%s\n%s\n%s\n"), $1, $4, $7, $10}' $fname >> COL.tmp

#		paste COL.tmp FIFO.tmp DAWID.tmp
		paste FIFO.tmp DAWID.tmp
	done
done
