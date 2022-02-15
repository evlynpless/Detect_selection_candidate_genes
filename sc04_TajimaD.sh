#Calculate Tajima's D for genes of interest

export DATA=/share/hennlab/users/espless/PAFC1/DataProcess/50kBuffer
export OUT=/share/hennlab/users/espless/PAFC1/Analysis/TajimasD

module load vcftools


for P in BEB CHB CLM GIH ITU JPT PEL PJL IBS GBR PJL KHV LWK NKS

do

    for no in 1 11 15 19
    do

	nice vcftools --vcf $DATA/PAFC1_chr${no}_${P}.recode.vcf --out $OUT/PAFC1_chr${no}_${P}_tajimasd --TajimaD 10000

    done

done

export DATA=/share/hennlab/users/espless/PAFC1/DataProcess/NegativeControl
export OUT=/share/hennlab/users/espless/PAFC1/Analysis/TajimasD

module load vcftools

#for P in BEB CHB CLM GIH ITU JPT PEL PJL IBS GBR PJL KHV LWK NKS
    
do

    for no in 1 11 15 19

    do

	nice vcftools --vcf $DATA/justGenes_chr${no}_${P}.recode.vcf --out $OUT/justGenes_chr${no}_${P}_tajimasd --TajimaD 10000

    done

done