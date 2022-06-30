args <- commandArgs(trailingOnly = TRUE)

install.packages("rmarkdown")
library(rmarkdown)
# install.packages("knitr")
# Load the data into MetaLINCS1.Rmd and knit the Rmd file
# library(knitr)
# library(rlang)
# library(rjson)
# library(data.table)
# library(dplyr)

 # hve to open the file here, otherwise it will not work
metabolomics_meta <- args[1]
samples_meta <- args[2]
metabolomics_data <- args[3]

int.mat <- metabolomics_data
rowNms <- rownames(int.mat)
colNms <- colnames(int.mat)
naNms <- sum(is.na(int.mat))
num.mat <- suppressWarnings(apply(int.mat, 2, as.numeric))

out1 <- ""
if (sum(is.na(num.mat)) > naNms) {
    num.mat <- apply(int.mat, 2, function(x) as.numeric(gsub(",", "", x)))
    if (sum(is.na(num.mat)) > naNms) {
        out1 <- ("Non-numeric values were found and replaced by NA.")
    }
    else {
        out1 <- ("All data values are numeric.")
    }
} 
#Load args into the rmd when knitting the Rmd file.... maybe do all computation here and then send output to rmd to be knitted
rmarkdown::render("MetaLINCS1.Rmd", output_format="html_document", params=list(out1=out1))

#return path of MetaLINCS1.html file
MetaLINCS1.html