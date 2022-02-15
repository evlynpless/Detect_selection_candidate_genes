#This code is for extracting candidate genes and negative control genes from 1000 Genomes dataset for populations of interest (paired high and low dengue)

export POPS=/share/hennlab/users/espless/PAFC1/Pops
export DATA=/share/hennlab/users/espless/PAFC1/DataProcess
export REF=/share/hennlab/reference/1000G_Phase3_VCFs
module load vcftools

#Part 1: Extract candidate genes from 1000 Genomes dataset by population

#Extract the candidate genes from 1000 Genomes

for no in 1 11 15 19

  vcftools --gzvcf $REF/ALL.chr${no}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz --bed $DATA/PAF1Cgenes_50kbuffer_GRCh37.bed --recode --recode-INFO-all --out $DATA/50kBuffer/PAFC1_chr${no}

done

#Split candidate genes by population

for P in BEB CHB CLM GIH ITU JPT PEL PJL IBS GBR PJL KHV LWK

  do

    for no in 1 11 15 19

    do

    vcftools --vcf $DATA/50KBuffer/PAFC1_chr${no}.recode.vcf --keep $POPS/${P}.txt --recode --recode-INFO-all --out $DATA/50KBuffer/PAFC1_chr${no}_${P}

    done

done


#Part 2: Extract negative control genes from 1000 Genomes dataset by population

#Extract all the relevant populations for each chromosome from the 1000 Genomes

for P in BEB CHB CLM GIH ITU JPT PEL PJL IBS GBR PJL KHV LWK

do

    for no in 1 11 15 19

      do

       nice vcftools --gzvcf $DATA/ALL.chr${no}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz --keep $POPS/${P}.txt --recode --recode-INFO-all --out $OUT/allSNPs_chr${no}_${P}

    done

done

#Extract just SNPs which are part of known genes

for P in BEB CHB CLM GIH ITU JPT PEL PJL IBS GBR PJL KHV LWK

do

    for no in 1 11 15 19
    do

	nice vcftools --vcf $DATA/NegativeControl/allSNPs_chr${no}_${P}.recode.vcf --bed $DATA/glist-hg19.bed --recode --recode-INFO-all --out $DATA/NegativeControl/justGenes_chr${no}_${P}

    done
done
