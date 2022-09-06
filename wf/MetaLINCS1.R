# Find a way to not have this happen every time maybe put in dockerfile?
# install.packages("rmarkdown")

#PUT MY LIBRARIES HERE
library(rmarkdown)
# library(impute)

#Good code snippet
dir.create("results", showWarnings = FALSE)
# setwd("results")

#delete this but wanna see what happens
# df <- data.frame(a=1:4, b=4:1)
# write.table(df, file="my.csv", sep=",", row.names=FALSE, append=TRUE)
# print(list.files('/root'))
#end test

args <- commandArgs(trailingOnly=TRUE)

metabolomics_meta <- read.csv(args[1]) #I wasnt reading before...
samples_meta <- read.csv(args[2])
metabolomics_data <- read.csv(args[3])







# int.mat <- metabolomics_data
# rowNms <- rownames(int.mat)
# colNms <- colnames(int.mat)
# naNms <- sum(is.na(int.mat))
# num.mat <- suppressWarnings(apply(int.mat, 2, as.numeric))

# out1 <- ""
# if (sum(is.na(num.mat)) > naNms) {
#     num.mat <- apply(int.mat, 2, function(x) as.numeric(gsub(",", "", x)))
#     if (sum(is.na(num.mat)) > naNms) {
#         out1 <- ("Non-numeric values were found and replaced by NA.")
#     }
#     else {
#         out1 <- ("All data values are numeric.")
#     }
# }

# out2 <- ""
# int.mat <- num.mat
# rownames(int.mat) <- rowNms
# colnames(int.mat)[-1] <- colNms
# varCol <- suppressWarnings(apply(int.mat, 2, var, na.rm = T))
# constCol <- (varCol == 0 | is.na(varCol))
# constNum <- sum(constCol, na.rm = T)
# #print(constNum)
# if (constNum > 0) {
#     int.mat <- int.mat[, !constCol]
#     # paste(constNum)
#     out2<-paste("<b>", constNum, "</b>", " features with a constant or single value across samples were found and deleted.")     ####FEATURES, METABOLITES, VARIABLES,,, SAME THING
    
# } else {out2<-paste("<b>0</b> metabolites with constant or single values were found across your sample.")}

# out3 <- ""
# totalCount <- nrow(int.mat) * ncol(int.mat)
# naCount <- sum(is.na(int.mat))
# naPercent <- round(100 * naCount/totalCount, 1)
# out3<-paste("A total of ", naCount, " (", naPercent, "%) missing values were detected.", sep = "")

# out4 <- ""
# good.inx <- apply(is.na(int.mat), 2, sum)/nrow(int.mat) < 0.5
# int.mat1 <- as.data.frame(int.mat[,good.inx])
# out4 <- paste(sum(!good.inx), "variables were removed for threshold", round(100 * 0.5, 2), "percent.")

# out5 <- ""
# out6 <- ""
# new.mat2 <- t(impute::impute.knn(t(int.mat1))$data)
# min.val <- min(abs(new.mat2[new.mat2 != 0]))/2
# norm.data <- log2((new.mat2 + sqrt(new.mat2^2 + min.val))/2)
# # head(norm.data)
# out5 <- paste(dim(metabolomics_data)[2]-dim(norm.data)[2] ,"is the total number of removed metaboloites")
# out6 <- paste(dim(norm.data)[2] ,"out of",dim(metabolomics_data)[2],"is kept")















# 1. Debug current version to see why output doesnt match
# 2. Finish downward processing and Machine learning, and output the images and csv files
# 3. Case and fix up markdown. 

#Will work on Latch open source worklfow chaining cuz compete r shiny.....SEE HOW THEY MADE IT DYNAMIC IN LATCH VERIFIED
#maybe use curl api in shiny? # ... and then we can use the shiny app to do the rest of the work.
#4. pay

#accepted abstract
#have ideas for csv and correct directory -- r studo code

#Need stuff to appear in new file without code appearing
#Share stuff on twitter, figure out ssh and github



# #generate plot in markdown

# # #save ploits to out7 and out8
# par(mfrow=c(2,2)) 
#    plot(density(apply(new.mat2, 2, mean, na.rm = TRUE)), 
#         col = "darkblue", las = 2, lwd = 2, main = "", xlab = "", 
#         ylab = "")
    
#     mtext("Before Normalization", 3, 1)
#     plot(density(apply(norm.data, 2, mean, na.rm = TRUE)), 
#         col = "darkblue", las = 2, lwd = 2, main = "", xlab = "", 
#         ylab = "")
#    mtext("After Normalization", 3, 1)

#     rangex.pre <- range(new.mat2[, 1:20], na.rm = T)
#     rangex.norm <- range(norm.data[, 1:20], na.rm = T)
    
#    boxplot(new.mat2[, 1:20], names = colnames(new.mat2[, 1:20]), 
#         ylim = rangex.pre, las = 2, col = "lightgreen", horizontal = T)
#    mtext("Before Normalization", 3, 1)

#   boxplot(norm.data[, 1:20], names = colnames(norm.data[, 1:20]), 
#         ylim = rangex.norm, las = 2, col = "lightgreen", horizontal = T)
#    mtext("After Normalization", 3, 1)







# out7 <- ""
# out8 <- ""
# out9 <- ""
# out10 <- ""
# out7 <- plot(density(apply(new.mat2, 2, mean, na.rm = TRUE)), 
#         col = "darkblue", las = 2, lwd = 2, main = "", xlab = "", 
#         ylab = "")
# out8 <- plot(density(apply(norm.data, 2, mean, na.rm = TRUE)),
#         col = "darkblue", las = 2, lwd = 2, main = "", xlab = "", 
#         ylab = "")
# rangex.pre <- range(new.mat2[, 1:20], na.rm = T)
# rangex.norm <- range(norm.data[, 1:20], na.rm = T)
# out9 <- boxplot(new.mat2[, 1:20], names = colnames(new.mat2[, 1:20]), 
#         ylim = rangex.pre, las = 2, col = "lightgreen", horizontal = T)
# out10 <- boxplot(norm.data[, 1:20], names = colnames(norm.data[, 1:20]),
#         ylim = rangex.norm, las = 2, col = "lightgreen", horizontal = T)

# #create rmarkdown parameters with mtext on the plots
# #save plots to out7 and out8
# out7 <- mtext("Before Normalization", 3, 1)
# out8 <- mtext("After Normalization", 3, 1)


# out11 <- ""
# out12 <- ""

# # boxplot(new.mat2[1:20,1:20], names = rownames(new.mat2[1:20,1:20]), 
# #         ylim = rangex.pre, las = 2, col = "lightgreen", horizontal = T)
# #    mtext("Samples Before Normalization", 3, 1)

# #   boxplot(norm.data[1:20,1:20 ], names = rownames(norm.data[1:20,1:20 ]), 
# #         ylim = rangex.norm, las = 2, col = "lightgreen", horizontal = T)
# #    mtext("Samples After Normalization", 3, 1)
# #same thing
# out11 <- boxplot(new.mat2[1:20,1:20], names = rownames(new.mat2[1:20,1:20]), 
#         ylim = rangex.pre, las = 2, col = "lightgreen", horizontal = T)
# out12 <- boxplot(norm.data[1:20,1:20 ], names = rownames(norm.data[1:20,1:20 ]),
#         ylim = rangex.norm, las = 2, col = "lightgreen", horizontal = T)
# out11 <- mtext("Samples Before Normalization", 3, 1)
# out12 <- mtext("Samples After Normalization", 3, 1)


#try saving plots as static images and rendering in markdown as static
#see how they did dynamically for verified stuff
# I can look tmp file code in rstudio for tmp stuff


#Load args into the rmd when knitting the Rmd file.... maybe do all computation here and then send output to rmd to be knitted
# can possibily knit image here
# rmarkdown::find_pandoc(cache = FALSE)
rmarkdown::render("/root/wf/MetaLINCS1.Rmd", output_format="html_document", output_file = "OUTPUT FILE.html", params=list(
    metabolomics_data = metabolomics_data, samples_meta = samples_meta, metabolomics_meta, metabolomics_meta))
    # out1=out1, out2=out2, out3=out3, out4=out4, out5=out5, out6=out6, out7=out7, out8 = out8, out9 = out9, out10 = out10, out11 = out11, out12 = out12))
#    )) #output_dir = "root/wf"

# -------------------------------------------------------------------- Not mine:

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

# -------------------------------------------------------------------- My garbage:

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