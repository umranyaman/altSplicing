# First, install and load the `testthat` package
install.packages("testthat")
library(testthat)

# Load the `altSplicing` package
library(altSplicing)

# Define a test context
context("altSplicing Tests")

# Test the WCGNA function
test_that("WCGNA function works correctly", {
  # Define a sample count matrix
  count_matrix = matrix(rnorm(100), ncol = 10)

  # Run the WCGNA function on the sample count matrix
  result = WCGNA(count_matrix)

  # Check that the result is a list
  expect_is(result, "list")

  # Check that the result contains the expected components
  expect_true("network" %in% names(result))
  expect_true("cell_types" %in% names(result))
})

# Test the PrismIntensity function
test_that("PrismIntensity function works correctly", {
  # Define a sample count matrix
  count_matrix = matrix(rnorm(100), ncol = 10)

  # Run the PrismIntensity function on the sample count matrix
  result = PrismIntensity(count_matrix)

  # Check that the result is a data frame
  expect_is(result, "data.frame")

  # Check that the result contains the expected number of rows and columns
  expect_equal(nrow(result), ncol(count_matrix))
  expect_equal(ncol(result), 3)
})
