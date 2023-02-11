#' Visualize transcripts with annotations from a GTF file
#'
#' @param gtf_file Path to the GTF file
#' @param transcript_id ID of the transcript to visualize
#' @return A ggplot object
#' @export
#'
plot_transcript <- function(gtf_file, transcript_id) {
  library(dplyr)
  library(ggplot2)

  # Load the GTF file into R
  gtf_data <- read.table(gtf_file, header = F, stringsAsFactors = F)

  # Filter the GTF data to only include annotations for the specified transcript
  transcript_annotations <- gtf_data %>%
    filter(V1 == transcript_id)

  # Create a data frame for plotting the annotations
  plot_data <- transcript_annotations %>%
    mutate(start = as.numeric(V4),
           end = as.numeric(V5),
           type = V3)

  # Create the plot
  ggplot(plot_data, aes(x = start, xend = end, y = type, yend = type)) +
    geom_segment(size = 3, color = "black") +
    scale_x_continuous(limits = c(min(plot_data$start), max(plot_data$end))) +
    coord_flip() +
    theme_void()

  return(ggplot_object)
}
