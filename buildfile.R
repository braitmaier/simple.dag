
### this file controls the compilation of the simple.dag R package

### I'm following the instructions on
### https://tinyheero.github.io/jekyll/update/2015/07/26/making-your-first-R-package.html

### required packages
library(devtools)
library(roxygen2)

### directory to store the package
if (Sys.getenv("COMPUTERNAME") == "PAC210") {
  pkg.dir <- "H:/Documents/old structure/Persönliche Unterlagen"
} else {
  pkg.dir <- "C:/Users/Braitmaier/files/documents/jobs/2018 BIPS/BIPS home office/developement/My code"
}
setwd(pkg.dir)

### initialze the package
# devtools::create("simple.dag") ### run only in the beginning

### set working directory inside the package
setwd(file.path(pkg.dir, "simple.dag"))


### generate documentation for functions stored in ../R
devtools::document()

### install the local package to R 
devtools::install(build_vignettes = T)

### build the vignette 
# devtools::build_vignettes()

library(simple.dag)
?define.arrow
