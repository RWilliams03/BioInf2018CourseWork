library(ggplot2)

###Exercise 1

#Question 1
DEG_df <- read.table("DE_Genes/GM12878_Minus_HeLa_DEG.csv", sep=',', header=T, row.names=1)
nrow(DEG_df[DEG_df$padj<0.05,])

#Question 2
scatterPlot <- ggplot(data=DEG_df, 
                      mapping=aes(x=log2FoldChange, y=-log10(pvalue))) + labs(title = "Volcano Plot of GM12878 Minus HeLa")

scatterPlot + geom_point() + theme_minimal()


#Question 3
Abs_df <- read.table("DE_Genes/Expression.csv", sep=',', header=T, row.names=1)

Abs_df <- Abs_df + 1
boxplot(log10(Abs_df))

#Question 4
genes <- DEG_df[DEG_df$padj<0.05 & DEG_df$log2FoldChange>1,]
boxplot(log10(Abs_df[row.names(genes),]))

#Question 5
# My plot is slightly different, I also noticed that the absolute expression data has more entries than the differential expression?
# Should I have gotten the top 40% of the Absolute and then filtered differential genes for these?
Abs_df$RowMean <- rowMeans(Abs_df[1:4])
Forty <- quantile(Abs_df$RowMean, probs=c(0.6))
genes4 <- DEG_df[DEG_df$baseMean > Forty,]
genes4$sigOrNot <- genes4$padj<0.05

options(repr.plot.width=6, repr.plot.height=4)
MAPlot <- ggplot(data=genes4,
                 mapping = aes(x=log2(baseMean), y=log2FoldChange, color=sigOrNot))

MAPlot + geom_point(size = 1) + theme_minimal()


