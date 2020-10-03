#! /bin/bash
echo "PLINK to VCF"
if [ "$1" != "" ]; then
    echo "Processing"
else
	echo "Usage: ptovcf <bfile without extension>"
	echo "Requires PLINK 1.9 to be in path"
	echo "and named plink."
	exit
fi

family=( $(awk '{print $1}' $1.fam) )
indiv=( $(awk '{print $2}' $1.fam) )
loppu="${#family[@]}"
for i in $(seq 0 $loppu)
do 
	place="${family[$i]}"
	echo "${family[$i]}" "${indiv[$i]}" > filter.txt
	plink --bfile $1 --keep filter.txt --recode vcf --out "${indiv[$i]}"
done
rm filter.txt
