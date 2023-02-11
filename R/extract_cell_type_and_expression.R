#' Perform WCGNA and gene expression deconvolution
#'
#' This function takes a count matrix as input, performs WCGNA, and then uses the BayesPrism algorithm to perform cell type and gene expression deconvolution.
#'
#' @param count_matrix A matrix of gene expression counts. Rows correspond to genes and columns correspond to samples.
#' @return A list containing the WGCNA module membership and the deconvolved cell type and gene expression information.
#' @export
#'
extract_cell_type_and_expression <- function(count_matrix) {
  library(WGCNA)
  library(BayesPrism)

  # Perform WGCNA
  data_mat <- as.data.frame(t(count_matrix))
  rownames(data_mat) <- colnames(count_matrix)
  data_mat <- scale(data_mat)
  power <- pickSoftThreshold(data_mat, powerVector = c(1:15))
  soft_threshold <- power$Threshold
  adj_mat <- adjacency(data_mat, power = soft_threshold)
  net = blockwiseModules(adj_mat, power = soft_threshold,
                         TOMType = "unsigned",
                         moduleMembership = NULL,
                         reassignThreshold = 0,
                         mergeCutHeight = 0.25,
                         numericLabels = TRUE,
                         pamRespectsDendro = FALSE,
                         saveTOMs = TRUE,
                         saveTOMFileBase = "TOM")
  module_colors <- labelColors(net$colors, net$modules)

  # Perform gene expression deconvolution with BayesPrism
  cell_type_proportions <- BayesPrism(count_matrix)

  # Return the results
  list(module_colors = module_colors, cell_type_proportions = cell_type_proportions)
}
