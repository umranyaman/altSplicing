library(testthat)

# Define test data
count_data <- data.frame(
  sample_1 = c(10, 20, 30, 40),
  sample_2 = c(20, 30, 40, 50)
)
transcript_assembly <- data.frame(
  transcript_id = c("transcript_1", "transcript_2", "transcript_3", "transcript_4"),
  gene_id = c("gene_1", "gene_1", "gene_2", "gene_2"),
  exon_start = c(1, 11, 21, 31),
  exon_end = c(10, 20, 30, 40),
  transcript_length = c(10, 10, 10, 10)
)

# Define expected results
expected_results <- data.frame(
  row.names = c("transcript_1", "transcript_2", "transcript_3", "transcript_4"),
  baseMean = c(15, 25, 35, 45),
  log2FoldChange = c(1.169925, 0.5849625, -0.5849625, -1.169925),
  lfcSE = c(0.5910564, 0.5910564, 0.5910564, 0.5910564),
  pvalue = c(0.025, 0.25, 0.75, 0.025),
  padj = c(0.1, 1, 1, 0.1),
  event_type = c("exon_inclusion", "exon_inclusion", "exon_skipping", "exon_skipping"),
  event_extent = c(1.169925, 0.5849625, 0.5849625, 1.169925),
  translation_effect = c("no", "no", "no", "yes")
)

# Define unit test
test_that("detect_alt_splicing returns correct results", {
  res <- detect_alt_splicing(count_data, transcript_assembly)
  expect_identical(res, expected_results)
})
