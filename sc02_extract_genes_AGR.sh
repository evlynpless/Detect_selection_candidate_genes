#This code is for extracting candidate genes and negative control genes from African Genome Resources dataset for a populations of interest which is not in 1000G (the Nama)
#Also perform Tajima's D for the Nama

export DATA=/share/hennlab/data/genomes/AGR
export DatProc=/share/hennlab/users/espless/PAFC1/DataProcess

#Create list of Nama and KS individuals in AGR
grep Nama  $DATA/AGR_vs_ADRP_relationship.txt | awk '{ print $1}' > $DatProc/Nama_KS.txt

#Extract candidate genes from AGR

vcftools --gzvcf $DATA/1.minAC1.strict_mask.without_related.vcf.gz --bed $DatProc/PAF1Cgenes_50kbuffer_GRCh37.bed --recode --recode-INFO-all --out $DatProc/50kBuffer/AGR_PAFC1_chr1

vcftools --gzvcf $DATA/11.minAC1.strict_mask.without_related.vcf.gz --bed $DatProc/PAF1Cgenes_50kbuffer_GRCh37.bed --recode --recode-INFO-all --out $DatProc/50kBuffer/AGR_PAFC1_chr11

nice vcftools --gzvcf $DATA/15.minAC1.strict_mask.without_related.vcf.gz --bed $DatProc/PAF1Cgenes_50kbuffer_GRCh37.bed --recode --recode-INFO-all --out $DatProc/50kBuffer/AGR_PAFC1_chr15

nice vcftools --gzvcf $DATA/19.minAC1.strict_mask.without_related.vcf.gz --bed $DatProc/PAF1Cgenes_50kbuffer_GRCh37.bed --recode --recode-INFO-all --out $DatProc/50kBuffer/AGR_PAFC1_chr19

#Negative control

for no in 1 11 15 19
do
    nice vcftools --gzvcf $DATA/${no}.minAC1.strict_mask.without_related.vcf.gz --keep $DatProc/Nama_KS.txt --recode --recode-INFO-all --out $DatProc/NegativeControl/allSNPs_chr${no}_NKS

    nice vcftools --vcf $DatProc/NegativeControl/allSNPs_chr${no}_NKS.recode.vcf --bed $DatProc/glist-hg19.bed --recode --recode-INFO-all --out $DatProc/NegativeControl/justGenes_chr${no}_NKS

done
