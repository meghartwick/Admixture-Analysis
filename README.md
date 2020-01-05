# Admixture-Analysis
A pipeline to produce population admixture analysis and visualizations

![alt text](https://github.com/meghartwick/Population-Analysis/blob/master/pop.jpg)

# Introduction 
Population Admixture Plots help us visualize relationships between organisms by applying structure to genetic variation as it may have been contributed by hypothetical ancestors (see: coalescence)

There are a number of great programs available for Population structure analysis.
This pipeline creates the input file for STRUCTURE-like analysis by the [R package LEA](https://www.rdocumentation.org/packages/LEA/versions/1.4.0). The `make_genotypes.sh` script produces a split vcf file, a genotype file and an ordered list of sample names.

The genotype file is analyzed for population structure using [LEA](https://www.rdocumentation.org/packages/LEA/versions/1.4.0) `snmf`.
A stress plot can be produced for selecting K and a custom function `pop_graphic` integrates the LEA `barplot` function with [ggplot2](https://ggplot2.tidyverse.org/) to allow for customization and incorporation of meta data layers.

Many great tutorials for LEA are available, including [ this resource ](http://membres-timc.imag.fr/Olivier.Francois/LEA/tutorial.htm), if you would like to explore your data beyond the scripts provided here 

# Usage
This pipeline is currently coded for a shared computing environment between collaborators, some adjustments to the script may be necessary 
## Input File
`make_genotypes.sh` uses [snp-sites](https://github.com/sanger-pathogens/snp-sites) and [bcftools](https://samtools.github.io/bcftools/bcftools.html). 

The input file for `make_genotypes.sh` is a fasta matrix file from [kSNP](https://sourceforge.net/projects/ksnp/). This script is written so that the input fasta is the only fasta file in the folder, otherwise modify the script to specify the file name. Provide the `make_genotype.sh` with the name that you would like assigned to your output files. If you already have a VCF file then modify `make_genotypes.sh` by eliminating lines 3-10. 

```
sh make_genotype.sh <name>
```

## Analysis and Admixture Plots
See LEA documentation and tutorials for alternative input file formats and compatability.

 `Pop_Admixture.R` *is currently used as a series of individual scripts and has not been automated to be a fully executable script, but this is in progress...*

Currently all steps below are also in `Pop_Admixture.R`

Import and analyze the genotype file produced by `make_genotype.sh`

*(if you have a lot of variation and/or lots of samples this could be memory and time intense, consider smaller K or a job manager if that's an option)*

```
#run structure analysis
all.snmf <- snmf("all.geno", K = 1:20, ploidy = 1, entropy = T,alpha = 100, project = "new")
```

If you've run LEA previously and already have a population structure project:

```
#or load project
project <- load.snmfProject("core.snmfProject")
```

Next produce stress plots and preliminary visualizations

```
#make stress plot(entropy) and pick K
pdf.('allstress.pdf')
plot(obj.snmf, col = "blue4", cex = 1.4, pch = 19)
dev.off()
#construct ancestry plot and extract order

pdf.('allbar.pdf')
barchart(obj.snmf, K = 10, border = NA, space = 0,xlab = "Individuals",ylab = "Ancestry proportions",main = "Ancestry matrix")
dev.off()
barchart(obj.snmf, K = 10, border = NA, space = 0,xlab = "Individuals",ylab = "Ancestry proportions",main = "Ancestry matrix") -> bp
bp
```

Once you have determined the number of hypothetical ancestors (K) for your data, the admixture bar chart can be customized using the custom function `pop_graphic` after it has been imported into your global environment. This function will also look for the list of file names produced by `make_genotypes.sh`. This is just a tab-delimited list of the sample identifiers in your population in the same order as they appear in your genotype file. It can be made outside of `make_genotypes.sh` in a text editor or excel, or remove it from the function if you don't want to use identifiers.

`pop_graphic` is used by providing the name of the object from the initial structure analysis and the # of K.

In the example below, the structure analysis object is named *core* and *8* K were selected

```
pop_graphic(core, 8) -> q_melt
ggplot(q_melt, aes(x=reorder(sample,axis_order), y=value, fill = variable)) + geom_bar(stat= 'identity', width =1) + scale_fill_brewer(palette = 'Set3') + theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = -0.09, size = 6, color = 'black')) + scale_y_continuous(expand = c(0,0))+ theme(legend.position = "none")
ggsave('core_k8_6_10.pdf', height = 7, width = 13, un='in')

```
Meta data can be easily incorporated into the output graphic by relating the output dataframe from `pop_graphic` to a meta data frame and adding these specifications to the graphics code

**So, that's it, I hope some of this helps make your structure analysis and visualizations a little easier!**

