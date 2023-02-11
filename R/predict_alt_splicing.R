#' Predict alternative splicing events from transcript count data
#'
#' @param count_data Data frame with count data per transcript
#' @param threshold Threshold for considering a splice event to be alternative
#' @return A data frame with columns for the transcript ID, splice event type, and event frequency
#' @export
#'
predict_alt_splicing <- function(count_data, threshold) {
  library(dplyr)

  # Group the count data by transcript ID
  grouped_counts <- count_data %>%
    group_by(transcript_id)

  # Calculate the relative frequency of each splice event type
  splice_events <- grouped_counts %>%
    mutate(event_frequency = count/sum(count))

  # Filter the events to only include those above the threshold frequency
  alt_splicing_events <- splice_events %>%
    filter(event_frequency >= threshold)

  return(alt_splicing_events)
}
