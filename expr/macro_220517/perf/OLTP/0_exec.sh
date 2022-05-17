WK=$1
PROT=$2
PROT='prot1 prot5 prot10 prot50 prot100'
POLICY='FIFO DAWID'
#POLICY='FIFO'
DEVICE_SZ=16

echo "PROT FIFO DAWID" > result.txt 
for PR in $PROT; do
	rsltDir=./"$PR"
	echo "$PR" | tr "\n" " " >> result.txt	

	for PL in $POLICY; do
		cat "$rsltDir"/"$WK"_"$PL"* | grep 'eps' \
			| awk '{print $3}' \
			| awk -F "\t" '{x+=$1} END {print x/3}' \
			| tr "\n" " " >> result.txt	
	done
	echo "" >> result.txt
done
