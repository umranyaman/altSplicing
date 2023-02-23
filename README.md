# altSplicing

altSplicing is an R package for detecting alternative splicing events from long-read RNA-seq data. The package provides functions for extracting junctions from GTF files, visualizing each transcript with all the annotations, and predicting alternative splicing events based on count data per transcript.

### Note that this is an ongoing work and updates to the code and notebooks may occur.

# Installation

You can install the latest version of altSplicing from GitHub using the devtools package:

```
# install devtools if needed
install.packages("devtools")

library(devtools)

# install altSplicing from GitHub
devtools::install_github("umranyaman/altSplicing",ref="main")
```

# Usage

After installing altSplicing, you can load it into your R session with the following command:

```
library(altSplicing)
```

The package includes the following functions:

`extract_junc():` This function takes a GTF file as input and returns a data frame with the extracted junctions.

`plot_transcript():` This function visualizes each transcript with all the annotations in the GTF file.

`alt_splice_prediction():` This function takes count data per transcript as input and returns a data frame with the predicted alternative splicing events.
For more information on how to use these functions, please see the package documentation.

