#Run selection scans on chr 1, 11, 15, and 19 for the populations of interest

export MAP=/share/hennlab/reference/recombination_maps/genetic_map_HapMapII_GRCh37
export HOME=/share/hennlab/users/espless/PAFC1


module load plink/1.90p
module load selscan/1.3.0
module load shapeit/2.r904
module load vcftools

for P in BEB CHB CLM GIH ITU JPT PEL PJL IBS GBR PJL KHV LWK

do

    for no in 1 11 15 19

do

	vcftools --vcf $HOME/DataProcess/NegativeControl/allSNPs_chr${no}_${P}.recode.vcf --min-alleles 2 --max-alleles 2 --maf 0.05 --recode --recode-INFO-all --out $HOME/DataProcess/NegativeControlFilter/filterSNPs_chr${no}_${P}

	plink --vcf $HOME/DataProcess/NegativeControlFilter/filterSNPs_chr${no}_${P}.recode.vcf  --recode --make-bed --out $HOME/Selscan/MapFilesPlink/filterSNPs_chr${no}_${P}

	
	plink --bfile $HOME/Selscan/MapFilesPlink/filterSNPs_chr${no}_${P} --cm-map $MAP/chr${no}.gmap.txt ${no} --make-bed --out $HOME/Selscan/MapFilesPlink/filterSNPs_chr${no}_${P}_hapmap

	plink --bfile $HOME/Selscan/MapFilesPlink/filterSNPs_chr${no}_${P}_hapmap --recode tab --out $HOME/Selscan/MapFilesPlink/filterSNPs_chr${no}_${P}_hapmap

	selscan --ihs --vcf $HOME/DataProcess/NegativeControlFilter/filterSNPs_chr${no}_${P}.recode.vcf --map $HOME/Selscan/MapFilesPlink/filterSNPs_chr${no}_${P}_hapmap.map --out $HOME/Selscan/filterSNPs_chr${no}_${P}_hapmap --threads 4

	nice norm --ihs --bins 100 --files $HOME/Selscan/filterSNPs_chr${no}_${P}_hapmap.ihs.out

    done

done

