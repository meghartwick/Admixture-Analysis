# Population-Analysis
A pipeline to produce population admixture analysis and visualizations

# Introduction 
Population Admixture Plots help us visualize relationships between organisms by assigning genetic variation as it may have been contributed by hypothetical ancestors (see: coalescence)

There are a number of great programs available for Population structure analysis
This pipeline creates the input file for STRUCTURE-like analysis by the [R package LEA](https://www.rdocumentation.org/packages/LEA/versions/1.4.0). The make_genotypes.sh script to produces a split vcf file and a genotype file.
The genotype file is analyzed for population structure using [LEA](https://www.rdocumentation.org/packages/LEA/versions/1.4.0) *snmf*
A stress plot be produced for selecting K and a custom function *pop_function* integrates the LEA *barplot* function with [ggplot2] (https://ggplot2.tidyverse.org/) to allow for customization and incorporation of meta data layers.

Many great tutorials for LEA are available including [ this resource ](http://membres-timc.imag.fr/Olivier.Francois/LEA/tutorial.htm) if you would like to explore your data beyond the scripts provided here 

#Usage
This pipeline is currently coded for a shared computing environment between collaborators, some adjustments to the script may be necessary 
## Input File
make_genotypes.sh uses [snp-sites](https://github.com/sanger-pathogens/snp-sites) and [bcftools (https://samtools.github.io/bcftools/bcftools.html). 

The input file for make_genotypes.sh is a fasta matrix file from [kSNP](https://sourceforge.net/projects/ksnp/). The way this script is written it should be the only fasta file inthe folder, otherwise modify the script to hard code the file name. Provide the *make_genotype.sh* with the name that you like assigned to your output files. If you already have a VCF then modify make_genotypes.sh by eliminating lines 3-10. 

`sh make_genotype.sh <name>`

## Analysis and Admixture Plots
See LEA documentation and tutorials for alternative input files format and compatability.

For this example, read the output genotype provided by *make_genotype.sh* using the scripts provided in


