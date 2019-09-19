#!/bin/bash

module purge
module load anaconda/colsa
source activate snp-sites

#this step will make a vcf from a fasta file
snp-sites -v *fasta

conda deactivate
module purge
module load linuxbrew/colsa
#https://samtools.github.io/bcftools/bcftools.html#convert

#this will make a gneotype file and split multi-allelic sites
bcftools norm -m -any *.vcf > $1'split.vcf'
bcftools convert --haplegendsample $1 $1'split.vcf'
gunzip *gz
sed -i 's/ - //g' $1'.hap'
sed -i 's/ -//g' $1'.hap'
cp $1'.hap' $1'.geno'

