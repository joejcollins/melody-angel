# R package list
.libPaths(".R/library")
install.packages(c(
    "base64enc",
    "devtools",
    "digest",
    "evaluate",
    "glue",
    "here",
    "highr",
    "htmltools",
    "httpgd",  # Enhances the experience of using R in VS Code.
    "jsonlite",
    "knitr",
    "languageserver",  # Provides code completion and linting in VS Code.
    "lintr",
    "Rcpp",
    "readr",
    "magrittr",
    "markdown",
    "mime",
    "R6",
    "rlang",
    "rmarkdown",
    "stringi",
    "stringr",
    "testthat",
    "tidyverse",
    "tinytex",
    "xfun"), lib = ".R/library")
# Install R debugger for VS Code.
devtools::install_github("ManuelHentschel/vscDebugger")
