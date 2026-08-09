# ------------------------------------------------------------
# 01_main.R
# ------------------------------------------------------------
# This is the main program. All it does is call the other
# programs in the correct order.
# ------------------------------------------------------------

source("programs/config.R")

# Data prep
source(file.path(dataprep_dir, "main.R"))

# Main analysis
source(file.path(analysis_dir, "main.R"))

# Appendix analysis
source(file.path(appendix_dir, "main.R"))