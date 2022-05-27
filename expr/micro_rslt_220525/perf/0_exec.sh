WK=$1
PROT=$2
WORKLOAD="RAND JESD SEQ" 
BUFF_SIZE='40 1' 
PROT='1 5 10 50 100'
POLICY='FIFO DAWID'
#POLICY='FIFO'
DEVICE_SZ=16

for WK in $WORKLOAD; do
	echo "PROT F64M F1G D64M D1G" > "$WK"_result.txt 
	#for PR in $PROT; do
	for PR in $PROT; do
		#rsltDir=./"$PR"
		echo "$PR"% | tr "\n" " " >> "$WK"_result.txt	

		for PL in $POLICY; do
			for BS in $BUFF_SIZE; do
				#cat "$rsltDir"/fio_"$WK"_"$PL"* | grep 'IOPS' \
				#	| awk -F "=" '{print $2}' | awk -F "k" '{print $1}' \
				#	| tr "\n" " " >> result.txt	
				cat ./result/fio_"$WK"_"$BS"_"$PR"_"$PL"_"$DEVICE_SZ".perf \
					| grep 'IOPS' | awk -F "=" '{print $2}' \
					| awk -F "k" '{print $1}' \
					| tr "\n" " " >> "$WK"_result.txt
			done
		done
		echo "" >> "$WK"_result.txt
	
	done
done
