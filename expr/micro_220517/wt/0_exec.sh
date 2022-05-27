WK=$1

WORKLOADS="SEQ RAND JESD"
PROT=$2
PROT='pt1 pt5 pt10 pt50 pt100'
PROT="1 5 10 50 100"
POLICY='FIFO DAWID'
#POLICY='FIFO'
DEVICE_SZ=16
BS=524288


for WK in $WORKLOADS; do
	echo "PROT FIFO DAWID" > "$WK"_result.txt 
	for PR in $PROT; do
		echo "$PR" | tr "\n" " " >> "$WK"_result.txt	
	
		for PL in $POLICY; do
			#cat "$rsltDir"/fio_"$WK"_"$PL"* | grep 'IOPS' \
			#	| awk -F "=" '{print $2}' | awk -F "k" '{print $1}' \
			#	| awk -F "\t" '{x+=$1} END {print x/3}' \
			#	| tr "\n" " " >> result.txt	
			if [[ $PL == FIFO ]]; then
				cat result/pt"$PR"_fio_"$WK"_"$PL"_1_16_2.wt | awk '{x=$3+$6+$9+$12} END {print x*4096/1024/1024/1024}' \
					| tr "\n" " " >> "$WK"_result.txt
			elif [[ $PL == DAWID ]]; then
				cat result/pt"$PR"_fio_"$WK"_"$PL"_1_16_2.wt | awk '{x=$3+$6+$9+$12} END {print x*4096/1024/1024/1024}' \
					| tr "\n" " " >> "$WK"_result.txt
			fi
			#cat "$rsltDir"/fio_"$WK"_"$PL"*_1.wt | awk '{x=$3+$6+$9+$12} END {print x*4096/1024/1024/1024}' \
			#	| tr "\n" " " >> "$WK"_result.txt
		done
		echo "" >> "$WK"_result.txt
	done
done
