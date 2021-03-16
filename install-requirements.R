reqs <- read.table("r-requirements.txt", header=T)
fst <- 1
if (reqs[fst,]$package == "-update-") {
    update.packages(ask=FALSE)
    fst <- 2
}
for (i in fst:length(reqs$package)) {
    if (!require(reqs[i,]$package, character.only=TRUE, quietly=TRUE)) {
        if (reqs[i,]$bioconductor) {
            if (!requireNamespace("BiocManager", quietly=TRUE)) {
                install.packages("BiocManager")
            }
            if (is.na(reqs[i,]$version)) {
                BiocManager::install(reqs[i,]$package)
            } else {
                BiocManager::install(reqs[i,]$package, version = reqs[i,]$version)
            }
        } else {
            if (is.na(reqs[i,]$version)) {
                install.packages(reqs[i,]$package)
            } else {
                if (!require("devtools", quietly=TRUE)) {
                    install.packages("devtools")
                }
                devtools::install_version(reqs[i,]$package, version=reqs[i,]$version)
            }
        }
    }
}
