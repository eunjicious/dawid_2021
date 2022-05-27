
OPERATION="JESD RAND SEQ"
PERCENT="prot1 prot5 prot10 prot50 prot100"
TARGET="FIFO DAWID"
LATENCY="99.90th 99.99th"
LATENCY="99.99th"
#ofile="total.rslt"
	
for op in $OPERATION; do
	ofile=$op".rslt"
	echo "per FIFO DAWID" > $ofile

	for la in $LATENCY; do
		if [[ $la == "99.99th" ]]; then
			AWK=3
		elif [[ $la == "99.90th" ]] ; then
			AWK=7
		fi
		for pe in $PERCENT; do
				if [[ $pe == "prot1" ]] ; then
					echo "prot_1%" | tr "\n" " " >> $ofile
					per=0.01
				elif [[ $pe == "prot5" ]] ; then
					echo "prot_5%" | tr "\n" " " >> $ofile
					per=0.05
				elif [[ $pe == "prot10" ]] ; then
					echo "prot_10%" | tr "\n" " " >> $ofile
					per=0.1
				elif [[ $pe == "prot50" ]] ; then
					echo "prot_50%" | tr "\n" " " >> $ofile
					per=0.5
				elif [[ $pe == "prot100" ]] ; then
					echo "prot_100%" | tr "\n" " " >> $ofile
					per=1
				fi
			for ta in $TARGET; do
#echo $ta"_"$pe | tr "\n" " ">> $ofile


				#cat $pe"_fio_"$op"_"$ta"_1_16_2.wt" | awk '{print $3,$6,$9,$12}' >> $ofile
				if [[ $ta == "FIFO" ]] ; then
					cat $op/$pe/"fio_"$op"_"$ta"_1_16_1.perf" |  grep $la | awk '{print $'"$AWK"'}' | awk -F ']' '{print $1}' | tr "\n" " " >> $ofile
				else
					cat $op/$pe/"fio_"$op"_"$ta"_1_16_1.perf" |  grep $la | awk '{print $'"$AWK"'}' | awk -F ']' '{print $1}' >> $ofile
				fi
			done
			if [[ $pe == "prot100" ]] ; then
				echo "per FIFO DAWID" >> $ofile
			fi

		done
	done
done
