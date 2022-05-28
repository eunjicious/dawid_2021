WK=$1
PROT=$2
PROT='prot1 prot5 prot10 prot50 prot100'
POLICY='FIFO DAWID'
#POLICY='FIFO'
DEVICE_SZ=16
BS=524288

echo "PROT FIFO DAWID" > wt_result.txt 
for PR in $PROT; do
	rsltDir=./"$PR"
	echo "$PR" | tr "\n" " " >> wt_result.txt	

	for PL in $POLICY; do
		#cat "$rsltDir"/fio_"$WK"_"$PL"* | grep 'IOPS' \
		#	| awk -F "=" '{print $2}' | awk -F "k" '{print $1}' \
		#	| awk -F "\t" '{x+=$1} END {print x/3}' \
		#	| tr "\n" " " >> result.txt	
		if [[ $PL == FIFO ]]; then
			cat "$rsltDir"/fio_"$WK"_"$PL"*_1.wt | awk '{x=$3+$6+$9+$12} END {print x*4096/1024/1024/1024}' \
				| tr "\n" " " >> wt_result.txt
		elif [[ $PL == DAWID ]]; then
			cat "$rsltDir"/fio_"$WK"_"$PL"*_1.wt | awk '{x=$3+$6+$9+$12+524288} END {print x*4096/1024/1024/1024}' \
				| tr "\n" " " >> wt_result.txt
		fi
		#cat "$rsltDir"/fio_"$WK"_"$PL"*_1.wt | awk '{x=$3+$6+$9+$12} END {print x*4096/1024/1024/1024}' \
		#	| tr "\n" " " >> "$WK"_result.txt
	done
	echo "" >> wt_result.txt
done
