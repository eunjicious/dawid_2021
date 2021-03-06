PERCENT="pt1 pt5 pt10 pt50 pt100"

TARGET="FIFO DAWID"

#ofile="total.rslt"
DIR="../"
	
ofile="total.rslt"
rm $ofile
for pe in $PERCENT; do
	for ta in $TARGET; do
#echo $ta"_"$pe | tr "\n" " ">> $ofile
		if [[ $ta == "FIFO" ]]; then
			key="F"
		else
			key="D"
		fi
		if [[ $pe == "pt1" ]] ; then
			echo $key"1%" | tr "\n" " " >> $ofile
		elif [[ $pe == "pt5" ]] ; then
			echo $key"5%" | tr "\n" " " >> $ofile
		elif [[ $pe == "pt10" ]] ; then
			echo $key"10%" | tr "\n" " " >> $ofile
		elif [[ $pe == "pt50" ]] ; then
			echo $key"50%" | tr "\n" " " >> $ofile
		elif [[ $pe == "pt100" ]] ; then
			echo $key"100%" | tr "\n" " " >> $ofile
		fi

		#cat $pe"_fio_"$op"_"$ta"_1_16_2.wt" | awk '{print $3,$6,$9,$12}' >> $ofile
		cat $DIR/$pe/"sys_OLTP_"$ta"_1_16_1.wt" | awk '{printf("%.4f %.4f %.4f %.4f\n"), $3/262144,$6/262144,$9/262144,$12/262144}' >> $ofile
	done
	echo "target ud md gud gmd" >> $ofile
done
