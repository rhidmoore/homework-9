########
# Shiny app to create a dynamically-filterable visualization of the diamonds app
########

# These bits get run before any of the rest of the code
# Note: contrary to what I told you on Monday, the use of the global.R file is no longer recommended.
# At present, I'm not sure why.
library(shiny)
library(tidyverse)


# Run the application 
shinyApp(ui = ui, server = server)