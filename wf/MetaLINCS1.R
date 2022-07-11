#PUT MY LIBRARIES HERE
install.packages("rmarkdown")
library(rmarkdown)

#Good code snippet
dir.create("/root/results", showWarnings = FALSE)
setwd("/root/results")

#delete this but wanna see what happens
# df <- data.frame(a=1:4, b=4:1)
# write.table(df, file="my.csv", sep=",", row.names=FALSE, append=TRUE)
# print(list.files('/root'))
#end test

args <- commandArgs(trailingOnly=TRUE)

metabolomics_meta <- read.csv(args[1]) #I wasnt reading before...
samples_meta <- read.csv(args[2])
metabolomics_data <- read.csv(args[3])


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
#can possibily knit image here
rmarkdown::render("MetaLINCS1.Rmd", output_format="html_document", params=list(out1=out1))

# height=8
# width=8
# print("loop start")

# for (gene in geneList)
# {
#   print(gene)
#   print(matrix)

#   gene1_plot=plotEmbedding(
#     ArchRProj = savedArchRProject,
#     colorBy = matrix,
#     #continuousSet = "yellowBlue",
#     name = args[3],
#     embedding = "UMAP",
#     imputeWeights = getImputeWeights(savedArchRProject))

#   png(file = paste0(gene,".png"), width = width, height = height,units="in",res = 1000)
#   print(gene1_plot)
#   dev.off()
# }

# --------------------------------------------------------------------

# install.packages("rmarkdown")
# library(rmarkdown)
# # install.packages("knitr")
# # Load the data into MetaLINCS1.Rmd and knit the Rmd file
# # library(knitr)
# # library(rlang)
# # library(rjson)
# # library(data.table)
# # library(dplyr)

# #Load args into the rmd when knitting the Rmd file.... maybe do all computation here and then send output to rmd to be knitted
# rmarkdown::render("MetaLINCS1.Rmd", output_format="html_document", params=list(out1=out1))

# #return path of MetaLINCS1.html file
# MetaLINCS1.html