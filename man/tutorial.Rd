### Introduction

Welcome to the altSplicing package! This package provides tools for analyzing alternative splicing data. The following tutorial will guide you through the installation and use of this package.

### Installation

The altSplicing package can be installed from GitHub using the devtools package. To install altSplicing, run the following code:

```
library(devtools)
install_github("umranyaman/altSplicing")
```

### Package Overview

The altSplicing package contains the following functions:

read_splice_data: This function reads in alternative splicing data from a file.
calculate_dpsi: This function calculates the delta PSI value for a given splicing event.
filter_splice_data: This function filters alternative splicing data based on delta PSI values.
plot_splice_data: This function plots alternative splicing data.

### Usage

Lets start by reading in alternative splicing data from a file. The file should contain columns for gene name, exon ID, delta PSI values for two different conditions, and a p-value for the splicing event. The read_splice_data function can be used to read in this data:

```
splice_data <- read_splice_data("splice_data.txt")
  
```

Once you have read in the data, you can use the calculate_dpsi function to calculate delta PSI values for each splicing event:

```
splice_data$delta_psi <- calculate_dpsi(splice_data$psi_condition1, splice_data$psi_condition2)

```

Next, you may want to filter the data to include only events with a significant change in splicing. The filter_splice_data function can be used for this purpose:

```
significant_splice_data <- filter_splice_data(splice_data, p_value_cutoff = 0.05)

```

Finally, you can visualize the alternative splicing data using the plot_splice_data function:

```
plot_splice_data(significant_splice_data)

```

### Conclusion

This tutorial provided an overview of the altSplicing package and how to use its functions. I hope that this package will be useful for your alternative splicing analysis

