# FROM 812206152185.dkr.ecr.us-west-2.amazonaws.com/wf-base:fbe8-main

FROM 812206152185.dkr.ecr.us-west-2.amazonaws.com/latch-base:02ab-main

# Its easy to build binaries from source that you can later reference as
# subprocesses within your workflow.
# RUN curl -L https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.4.4/bowtie2-2.4.4-linux-x86_64.zip/download -o bowtie2-2.4.4.zip &&\
#     unzip bowtie2-2.4.4.zip &&\
#     mv bowtie2-2.4.4-linux-x86_64 bowtie2

# Or use managed library distributions through the container OS's package
# manager.
# RUN apt-get update -y &&\
#     apt-get install -y autoconf samtools


# You can use local data to construct your workflow image.  Here we copy a
# pre-indexed reference to a path that our workflow can reference.
# COPY data /root/reference
# ENV BOWTIE2_INDEXES="reference"

# RUN docker pull rpy2/rpy2
# RUN python3 -m pip install rpy2 - would have to install pip too
# RUN apt-get update &&\
#     apt-get install -y software-properties-common &&\
#     add-apt-repository "deb http://cloud.r-project.org/bin/linux/debian buster-cran40/" &&\
#     apt-get install -y r-base r-base-dev libxml2-dev libcurl4-openssl-dev libssl-dev wget


#Install R
RUN apt install -y dirmngr apt-transport-https ca-certificates software-properties-common gnupg2
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key '95C0FAF38DB3CCAD0C080A7BDC78B2DDEABC47B7'
RUN add-apt-repository 'deb https://cloud.r-project.org/bin/linux/debian buster-cran40/'
RUN apt update
RUN apt install -y r-base

# Install system dependencies for R
RUN apt-get update -qq && \
        DEBIAN_FRONTEND=noninteractive apt-get install -y \
        apt-transport-https \
        build-essential \
        curl \
        gfortran \
        libatlas-base-dev \
        libbz2-dev \
        libcairo2 \
        libcurl4-openssl-dev \
        libicu-dev \
        liblzma-dev \
        libpango-1.0-0 \
        libpangocairo-1.0-0 \
        libpcre3-dev \
        libtcl8.6 \
        libtiff5 \
        libtk8.6 \
        libx11-6 \
        libxt6 \
        locales \
        tzdata \
        zlib1g-dev

# Install system dependencies for devtools
RUN apt-get update -qq && \
        DEBIAN_FRONTEND=noninteractive apt-get install -y \
        # git \
        # libssl-dev \
        # libicu-dev \
        # libxml2-dev \
        # make \
        # libgit2-dev \
        pandoc
        # libgsl-dev


#Install R packages
# RUN R -e 'install.packages("devtools",repo="https://cloud.r-project.org",dependencies = TRUE)'
RUN R -e 'install.packages("BiocManager",repo="https://cloud.r-project.org",dependencies = TRUE)'
# RUN R -e 'BiocManager::install("DESeq2")'

RUN R -e 'install.packages("rmarkdown",repo="https://cloud.r-project.org",dependencies = TRUE)'
# RUN R -e 'install.packages("glmnet",repo="https://cloud.r-project.org",dependencies = TRUE)'
# RUN R -e 'install.packages("ggplot2",repo="https://cloud.r-project.org",dependencies = TRUE)'
# RUN R -e 'install.packages("scales",repo="https://cloud.r-project.org",dependencies = TRUE)'
# RUN R -e 'install.packages("pheatmap",repo="https://cloud.r-project.org",dependencies = TRUE)'
RUN R -e 'install.packages("tidyverse",repo="https://cloud.r-project.org",dependencies = TRUE)'
RUN R -e 'BiocManager::install(c("impute"))'
# RUN R -e 'install.packages(c("dplyr", "devtools", "BiocManager", "plot3D"))'
# RUN R -e 'install.packages("impute",repo="https://cloud.r-project.org",dependencies = TRUE)'

# RUN R -e 'install.packages("reshape2",repo="https://cloud.r-project.org",dependencies = TRUE)'
# RUN R -e 'install.packages("magrittr",repo="https://cloud.r-project.org",dependencies = TRUE)'
# RUN R -e 'install.packages("ggpubr",repo="https://cloud.r-project.org",dependencies = TRUE)'
# RUN R -e 'install.packages("lsmeans",repo="https://cloud.r-project.org",dependencies = TRUE)'
# RUN R -e 'install.packages("multcomp",repo="https://cloud.r-project.org",dependencies = TRUE)'
# RUN R -e 'install.packages("corrplot",repo="https://cloud.r-project.org",dependencies = TRUE)'
# RUN R -e 'install.packages("Hmisc",repo="https://cloud.r-project.org",dependencies = TRUE)'
# RUN R -e 'install.packages("ComplexHeatmap",repo="https://cloud.r-project.org",dependencies = TRUE)'
# RUN R -e 'install.packages("circlize",repo="https://cloud.r-project.org",dependencies = TRUE)'
# RUN R -e 'devtools::install_github("GreenleafLab/ArchR", ref="master", repos = BiocManager::repositories())'

#get shiny
RUN R -e 'install.packages("shiny",repo="https://cloud.r-project.org",dependencies = TRUE)'
RUN R -e 'install.packages("shinydashboard",repo="https://cloud.r-project.org",dependencies = TRUE)'
RUN R -e 'install.packages("shinyjs",repo="https://cloud.r-project.org",dependencies = TRUE)'
RUN R -e 'install.packages("shinyWidgets",repo="https://cloud.r-project.org",dependencies = TRUE)'
RUN R -e 'install.packages("shinyalert",repo="https://cloud.r-project.org",dependencies = TRUE)'
RUN R -e 'install.packages("shinycssloaders",repo="https://cloud.r-project.org",dependencies = TRUE)'
# #Install wget
# RUN apt-get update -qq && \
#         DEBIAN_FRONTEND=noninteractive apt-get install -y \
#         wget
#install latest version of Pandoc
# RUN wget -qO - https://raw.githubusercontent.com/jgm/pandoc/master/misc/install.sh | bash

COPY wf /root/wf

# STOP HERE:
# The following lines are needed to ensure your build environement works
# correctly with latch.
ARG tag
ENV FLYTE_INTERNAL_IMAGE $tag
RUN  sed -i 's/latch/wf/g' flytekit.config
RUN python3 -m pip install --upgrade latch
WORKDIR /root
