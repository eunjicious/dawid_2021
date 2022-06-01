PERCENT="1 5 10 50 100"

OPERATION="OLTP"

TARGET="FIFO DAWID"

BUFF_SIZE="40 1" 

#ofile="total.rslt"

	
for op in $OPERATION; do
	#for bs in $BUFF_SIZE; do 
	ofile="$op".rslt
	rm $ofile
	for pe in $PERCENT; do
		#ofile="$op"_"$bs".rslt
		#ofile="$op".rslt
		#rm $ofile
		#for pe in $PERCENT; do
		#for bs in $BUFF_SIZE; do
		for ta in $TARGET; do
			for bs in $BUFF_SIZE; do
				if [[ $ta == "FIFO" ]]; then
					key="F$bs"
				else
					key="H$bs"
				fi

				#echo $ta"_"$pe | tr "\n" " ">> $ofile
				if [[ $pe == "1" ]] ; then
					echo $key"_1" | tr "\n" " " >> $ofile
				elif [[ $pe == "5" ]] ; then
					echo $key"_5" | tr "\n" " " >> $ofile
				elif [[ $pe == "10" ]] ; then
					echo $key"_10" | tr "\n" " " >> $ofile
				elif [[ $pe == "50" ]] ; then
					echo $key"_50" | tr "\n" " " >> $ofile
				elif [[ $pe == "100" ]] ; then
					echo $key"_100" | tr "\n" " " >> $ofile
				fi
	
				#cat $pe"_fio_"$op"_"$ta"_1_16_2.wt" | awk '{print $3,$6,$9,$12}' >> $ofile
				#cat ./result/sys_"$op"_"$bs"_"$pe"_"$ta"_16.wt | awk '{printf("%.4f %.4f %.4f %.4f\n"), $3/262144,$6/262144,$9/262144,$12/262144}' >> $ofile
				cat ./result/sys_"$op"_"$bs"_"$pe"_"$ta"_16.wt | awk '{printf("%.4f %.4f %.4f %.4f\n"), $3/262144,$6/262144,$9/262144,$12/262144}' >> $ofile
			done
			#echo "target ud md gud gmd" >> $ofile
		done
		#echo "target ud md gud gmd" >> $ofile
		echo "TARGET UD MD GUD GMD" >> $ofile
	done
done
