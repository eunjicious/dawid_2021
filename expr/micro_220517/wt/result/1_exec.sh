PERCENT="pt1 pt5 pt10 pt50 pt100"

OPERATION="JESD RAND SEQ"

TARGET="FIFO DAWID"

ofile="total.rslt"

echo target ud md gud gmd > $ofile	
for pe in $PERCENT; do
	for op in $OPERATION; do
		for ta in $TARGET; do
			echo $ta"_"$op"_"$pe | tr "\n" " ">> $ofile
			cat $pe"_fio_"$op"_"$ta"_1_16_2.wt" | awk '{print $3,$6,$9,$12}' >> $ofile
		done
	done
done
