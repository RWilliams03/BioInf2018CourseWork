library(ggplot2)
#Question 1
#Is there an easy way to extract the column names from the file? 

Colnames <- c('PeakID',	'chr',	'start',	'end', 'strand', 'Normalized Tag Count',	'region size',	'findPeaks Score',	'Total Tags',	
              'Control Tags (normalized to IP Experiment)',	'Fold Change vs Control',	'p-value vs Control',	'Clonal Fold Change')

PeakTable <- read.table("HOMER_peaks/H3K27Ac_Limb_1.txt", header=F, comment.char = "#", col.names = Colnames)
nrow(PeakTable)

#Question 2
hist(log10(PeakTable$region.size))

#Question 3
HistPlot <- ggplot(data = PeakTable, 
                   mapping = aes(x =region.size)
) + geom_density(color = "white", fill = "darkgreen") + scale_x_log10() + theme_minimal() + xlab("region sizes (log scale)") + ggtitle("Density log10 of region sizes")

HistPlot

#Question 4
HistPlot2 <- ggplot(data = PeakTable,
                    mapping = aes(x=log10(region.size))
) + geom_density(color="white", fill = "darkgreen") + facet_wrap(~chr) + ylim(0,6.0)+theme_minimal()

HistPlot2

# Question 5
Boxplot <- ggplot(data = PeakTable,
                  mapping = aes(x=chr, y=region.size, fill = chr)
                  ) + geom_boxplot(color="black") + scale_y_log10() + coord_flip()+theme_minimal()+ylab("region sizes (log scale)") + ggtitle("Boxplot log10 of region sizes")
Boxplot

#Question 6
library(rtracklayer)
library(GenomicRanges)
Intervals <- IRanges(start = PeakTable$start, end=PeakTable$end)
PeaksGRange <- GRanges(PeakTable$chr, ranges=Intervals)
PeaksGRange
export.bed(PeaksGRange, con="HOMER_Peaks.bed")

