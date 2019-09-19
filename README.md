# Population-Analysis
A pipeline to produce population admixture analysis and visualizations

#Population Admixture Plots help us visualize relationships between organisms by assigning genetic variation as it may have been contributed by hypothetical ancestors (see: coalescence)

There are a number of great programs available for Population structure analysis
This pipeline creates the input file for STRUCTURE-like analysis by the [R package LEA] (https://www.rdocumentation.org/packages/LEA/versions/1.4.0)
Many great tutorials for LEA are available including [ this resource ] (http://membres-timc.imag.fr/Olivier.Francois/LEA/tutorial.htm) 

#This pipeline is currently coded for a shared computing environment between collaborators, some adjustments to the script may be necessary 

#The input file for make_genotypes.sh is a fasta matrix file from [kSNP] (https://sourceforge.net/projects/ksnp/). If you already have a VCF then modify make_genotypes.sh by skipping lines 3-10. 

make_genotypes.sh uses [snp-sites] (https://github.com/sanger-pathogens/snp-sites) and [bcftools] (https://samtools.github.io/bcftools/bcftools.html). 

See LEA documentation and tutorials for the input file format and compatability. The 
