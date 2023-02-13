#' Detect alternative splicing events
#'
#' Given count data and transcript assembly, this function identifies alternative splicing events,
#' calculates the extent of each event, and returns a table with the identified events and
#' their potential effect on translation.
#'
#' @param count_data A data.frame or matrix containing the counts of reads mapping to each transcript.
#' @param transcript_assembly A data.frame or matrix containing information about each transcript, 
#'   such as exon boundaries, intron boundaries, and transcript length.
#' @return A table with columns for the type of alternative splicing event, the extent of the event,
#'   and a flag indicating whether the event may impact translation.
#' @export
#' @examples
#' detect_alt_splicing(count_data, transcript_assembly)
#' @importFrom edgeR glmQLFTest
#' @importFrom DESeq2 results
#' @importFrom DEXSeq DEXSeqDataSetFromMatrix
#' @importFrom DEXSeq countExons
#' @importFrom rtracklayer import
#' @importFrom GenomicRanges shift

detect_alt_splicing <- function(count_data, transcript_assembly){
  
  library(edgeR)
  library(DESeq2)
  library(DEXSeq)
  library(rtracklayer)
  library(GenomicRanges)
  
  # convert count data to a DEXSeqDataSet object
  dxd <- DEXSeqDataSetFromMatrix(countData = count_data, colData = transcript_assembly, design = ~ 1)
  
  # calculate the differential exon usage using glmQLFTest
  dxd <- estimateSizeFactors(dxd)
  dxd <- estimateDispersions(dxd)
  de <- glmQLFTest(dxd, contrast = c(0, 1))
  
  # extract the results of the differential exon usage test
  res <- results(de)
  
  # add a column indicating the type of alternative splicing event
  res$event_type <- ifelse(res$log2FoldChange > 0, "exon_inclusion", "exon_skipping")
  
  # add a column indicating the extent of the event
  res$event_extent <- abs(res$log2FoldChange)
  
  # add a column indicating whether the event may impact translation
  res$translation_effect <- ifelse(res$event_type == "exon_skipping" & res$event_extent >= 1, "yes", "no")
  
  # return the results table
  return(res)
}
