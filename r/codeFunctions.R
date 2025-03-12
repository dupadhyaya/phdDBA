#functions & Libraries

library(codetools)
find_functions_in_script <- function(script_path) {
  expr <- parse(script_path)  # Parse the R script
  functions_used <- codetools::findGlobals(expr, merge = FALSE)$functions  # Extract function calls
  return(unique(functions_used))
}
# Example usage
functions_used <- find_functions_in_script("./r/wdd/08-sampling.R")
print(functions_used)
