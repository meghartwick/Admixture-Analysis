library(LEA)
library(ggplot)
#run structure analysis
all.snmf = snmf("all.geno", K = 1:20, ploidy = 1, entropy = T,alpha = 100, project = "new")

#or load project
project = load.snmfProject("core.snmfProject")

#make stress plot(entropy) and pick K
pdf.('allstress.pdf')
plot(obj.snmf, col = "blue4", cex = 1.4, pch = 19)
dev.off()
#construct ancestry plot and extract order

pdf.('allbar.pdf')
barchart(obj.snmf, K = 10, border = NA, space = 0,xlab = "Individuals",ylab = "Ancestry proportions",main = "Ancestry matrix")
dev.off()
barchart(obj.snmf, K = 10, border = NA, space = 0,xlab = "Individuals",ylab = "Ancestry proportions",main = "Ancestry matrix") -> bp

pop_graphic(core, 8) -> q_melt
ggplot(q_melt, aes(x=reorder(sample,axis_order), y=value, fill = variable)) + geom_bar(stat= 'identity', width =1) + scale_fill_brewer(palette = 'Set3') + theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = -0.09, size = 6, color = 'black')) + scale_y_continuous(expand = c(0,0))+ theme(legend.position = "none")
ggsave('core_k8_6_10.pdf', height = 7, width = 13, un='in') 

pop_graphic <- function(obj,x){
  library(RColorBrewer)
  library(reshape2)
  barchart(obj, K = x, border = NA, space = 0,xlab = "Individuals",ylab = "Ancestry proportions",main = "Ancestry matrix") -> bp
  bp$order -> fifteen
  as.data.frame(fifteen)-> fifteen
  cbind(order= rownames(fifteen), fifteen) -> fifteen
  lapply(fifteen[1:2], as.character)-> fifteen[1:2]
  colnames(fifteen)<- c('axis_order', 'order')
  
  #extract Q matrix, this is the realtive ancestry and is ordered as genotype file
  Q(obj, K= x)-> q
  as.data.frame(q)-> q
  cbind(order= rownames(q), q) -> q
  as.character(q$order)-> q$order
  
  #add sample identifiers
  read.delim('core.samples', sep=" ", header=TRUE)-> names
  subset(names, select = 'sample') -> n
  as.data.frame(n) -> n
  as.character(n$sample) -> n$sample
  as.data.frame(n) -> n
  cbind(order = rownames(n), n) -> n
  
  #merge the axis order with the relative ancestry
  as.numeric(as.character(fifteen$order))-> fifteen$order
  as.numeric(as.character(q$order))-> q$order
  as.numeric(as.character(n$order))-> n$order
  merge(n, fifteen, by = 'order')-> info
  merge(info, q, by = 'order')-> q
  
  #make df for plotting
  as.numeric(as.character(q$axis_order))-> q$axis_order
  melt(q, id.vars = c('order', 'axis_order', 'sample')) -> q_melt
  
  return(q_melt)}

