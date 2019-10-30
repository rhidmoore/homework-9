########
# Shiny app to create a dynamically-filterable visualization of the diamonds app
########

# Load libraries
library(shiny)
library(tidyverse)

# We'll limit the range of selectable carats to the actual range of carats
min.carat <- min(diamonds$carat)
max.carat <- max(diamonds$carat)

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("Diamonds viewer"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            
            # This is a range slider (i.e. there's a max and min). It is set that way by "value" (the starting value), which is a 2-element vector
            sliderInput("carat.adjuster",
                        "Carats",
                        min = min.carat,
                        max = max.carat,
                        value = c(min.carat, max.carat))
            ),
        
        # Show a plot of diamonds data frame. This output doesn't care what that plot is, only that it will be associated with output$diamonds_plot
        mainPanel(
            plotOutput("diamonds_plot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    #d_filt is an argument so you have to call it like d_fiit()
    d_filt <- reactive({
        #filter the diamonds plot so that it only contains the specified range
        low.carat <- input$carat.adjuster[1]
        high.carat <- input$carat.adjuster[2]
        
        diamonds %>%
            filter(carat >= low.carat) %>%
            filter(carat <= high.carat)
    })
    
    output$diamonds_plot <- renderPlot({
        
        ggplot(d_filt(), aes_string(x = "carat", y="y", color = "clarity")) +
            geom_point()
        
    })   
}

# Run the application 
shinyApp(ui = ui, server = server)