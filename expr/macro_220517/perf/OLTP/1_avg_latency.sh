PERCENT="prot1 prot5 prot10 prot50 prot100"

TARGET="FIFO DAWID"

#ofile="total.rslt"
	
ofile="total.rslt"
echo "per FIFO DAWID" > $ofile
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
			cat $pe/"OLTP_"$ta"_1_16_"$per"_1.rst" |  grep "Latency" -A 3 | grep avg | awk '{print $2}' | tr "\n" " ">> $ofile
		else
			cat $pe/"OLTP_"$ta"_1_16_"$per"_1.rst" |  grep "Latency" -A 3 | grep avg | awk '{print $2}'>> $ofile
		fi
	done
done
