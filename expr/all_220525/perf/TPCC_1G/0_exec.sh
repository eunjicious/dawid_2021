WK=$1
PROT=$2
PROT='pt1 pt5 pt10 pt50 pt100'
POLICY='FIFO DAWID'
#POLICY='FIFO'
DEVICE_SZ=16

echo "PROT FIFO DAWID" > result.txt 
for PR in $PROT; do
	rsltDir=./"$PR"
	echo "$PR" | tr "\n" " " >> result.txt	

	for PL in $POLICY; do
		cat "$rsltDir"/sys_"$WK"_"$PL"* | grep 'events/s (eps)' \
			| awk '{print $3}' | tr "\n" " " >> result.txt
	done
	echo "" >> result.txt
done
