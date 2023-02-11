#' Extract splice junctions from a GTF file
#'
#' @param gtf_file Path to the GTF file
#' @return A data frame with columns for the start and end coordinates of each splice junction
#' @export
#'
extract_junc <- function(gtf_file) {
  library(dplyr)

  # Load the GTF file into R
  gtf_data <- read.table(gtf_file, header = F, stringsAsFactors = F)

  # Filter the GTF data to only include exon annotations
  exons <- gtf_data %>%
    filter(V3 == "exon")

  # Extract the start and end coordinates of each exon
  exon_coordinates <- exons %>%
    select(V4, V5)

  # Combine the start and end coordinates of consecutive exons to create a list of splice junctions
  splice_junctions <- exon_coordinates %>%
    group_by(exons$V1) %>%
    summarize(start = first(V4), end = last(V5))

  return(splice_junctions)
}
