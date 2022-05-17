PERCENT="pt1 pt5 pt10 pt50 pt100"

OPERATION="JESD RAND SEQ"

TARGET="FIFO DAWID"

ofile="total.rslt"

echo target ud md gud gmd > $ofile	
for pe in $PERCENT; do
	for op in $OPERATION; do
		for ta in $TARGET; do
			echo $ta"_"$op"_"$pe | tr "\n" " ">> $ofile
			#cat $pe"_fio_"$op"_"$ta"_1_16_2.wt" | awk '{print $3,$6,$9,$12}' >> $ofile
			cat $pe"_fio_"$op"_"$ta"_1_16_2.wt" | awk '{printf("%d %d %d %d\n"), $3/262144,$6/262144,$9/262144,$12/262144}' >> $ofile
		done
	done
done
