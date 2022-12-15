# Install the `cffr` library if you don't have it installed already. 
# https://cran.r-project.org/web/packages/cffr/index.html
# It is a helpful R library to generate CITATION files for GitHub to parse.
#
# If you are converting a citation from BibTeX format, you need an additional package: `bibtex`.
# https://cran.r-project.org/web/packages/bibtex/index.html
#
# Load the libraries.

install.packages("cffr")
install.packages("bibtex")

library(cffr)
library(bibtex)

# Create a minimal file following the CITATION file format (CFF) specifications.
# Learn about CFF files here: https://citation-file-format.github.io/
cff_min <- cff()

# display the minimal CFF file
cff_min
#> authors:
#> - family-names: Doe
#>   given-names: John
#> cff-version: 1.2.0
#> message: If you use this software, please cite it using these metadata.
#> title: My Research Software


# Create a list of papers you want to cite in BibTeX format. Store it in a variable, `x`.
if (requireNamespace("bibtex", quietly = TRUE)) {
  x <- c(
    "@article{garcia2022moving,
  title={Moving towards FAIR practices in epidemiological research},
  author={Garcia-Closas, Montserrat and Ahearn, Thomas U and Gaudet, Mia M and Hurson, Amber N and Balasubramanian, Jeya Balaji and Choudhury, Parichoy Pal and Gerlanc, Nicole M and Patel, Bhaumik and Russ, Daniel and Abubakar, Mustapha and others},
  journal={arXiv preprint arXiv:2206.06159},
  year={2022}
}"
  )
}

# Create CFF object from BibTeX
article <- cff_from_bibtex(x)

# View the CFF object
article

# type: article
# title: Moving towards FAIR practices in epidemiological research
# authors:
#   - family-names: Garcia-Closas
# given-names: Montserrat
# - family-names: Ahearn
# given-names: Thomas U
# - family-names: Gaudet
# given-names: Mia M
# - family-names: Hurson
# given-names: Amber N
# - family-names: Balasubramanian
# given-names: Jeya Balaji
# - family-names: Choudhury
# given-names: Parichoy Pal
# - family-names: Gerlanc
# given-names: Nicole M
# - family-names: Patel
# given-names: Bhaumik
# - family-names: Russ
# given-names: Daniel
# - family-names: Abubakar
# given-names: Mustapha
# - name: others
# journal: arXiv preprint arXiv:2206.06159
# year: '2022'


# Modify the fields in the minimalist CFF file.
# Override values instantiated by the minimal CFF file or add new keys
# Here, we modify the author name for the software, project title, and 
# message to our users on how to cite the project.
# We also add a field "preferred-citation", which will allow us to cite academic papers.
# We plug in the CFF form of the citation we just generated in the variable `article`.
cff_valid <- cff_create(cff_min, keys = list(
  message = "If you use this project, please cite the paper below.",
  title = "A demo project for the FAIR GitHub workshop.",
  authors = list(cff_parse_person("Jeya Balaji Balasubramanian")),
  `preferred-citation` = article
))


# Validate if the modified CFF file is valid.
cff_validate(cff_valid)

# cff_validate results-----
#   Congratulations! This cff object is valid


# Write the CFF file
cff_write(cff_valid, "CITATION.cff")

# CITATION.cff generated
# 
# cff_validate results-----
#   Congratulations! This .cff file is valid

