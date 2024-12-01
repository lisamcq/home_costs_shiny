######################################################################
#Title: app.R
#Author: Lisa McQuarrie
#Date: Dec. 1, 2024
#Purpose: Shiny app code for calculating home ownership costs
#####################################################################



#setwd()
source("~/home_costs_fnct.R")

library(shiny)

# Define UI for application
ui <- fluidPage(

    # Application title
    titlePanel("Home Ownership Costs"),

    # slider input 
    fluidRow(
      column(3, sliderInput("homeprice",
                                 "Total cost of home:",
                                 min = 0,
                                 max = 2000000,
                                 value = 600000)),
      
      column(3, sliderInput("downpayment",
                                "Downpayment:",
                                min = 0,
                                max = 2000000,
                                value = 200000)),
                    
      column(3, sliderInput("amortization",
                                "Amortization period:",
                                min = 1,
                                max = 30,
                                value = 25)),
      column(3, sliderInput("interest",
                                "Interest rate (%):",
                                min = 0.025,
                                max = 10,
                                value = 5))
    ),
    fluidRow(
      column(6, sliderInput("strata",
                                "Strata monthly fee:",
                                min = 0,
                                max = 2000,
                                value = 500)),
      column(6, sliderInput("taxes",
                                "Yearly taxes:",
                                min = 0,
                                max = 10000,
                                value = 2500))
    ),
    fluidRow(
      column(6, numericInput("maintenance",
                                "Maintenance costs (yearly):",
                                min = 0,
                                max = 500000,
                                value = 0)),
      column(6, numericInput("improvement",
                                "Home improvement costs (yearly):",
                                min = 0,
                                max = 500000,
                                value = 0))
    ),
    fluidRow(column(12, radioButtons("monthly", "Costs for one", c("month", "year")))),
    mainPanel(span(textOutput("Costs"), style = "font-size: 20px"),
              h3(textOutput("results"))
              )
)

# Define server logic required
server <- function(input, output) {
  
  output$Costs <- renderText(
                            print(paste0("Home ownership costs for one ", input$monthly, ":\n"))
                            )
  
  output$results <- renderText({
    mthly_costs(home_price = input$homeprice, downpayment = input$downpayment, 
                amortization = input$amortization, 
                interest_rate_pct = input$interest,
                strata_mthly = input$strata, taxes_yrly = input$taxes,
                maintenance_yrly = input$maintenance, 
                improvement_yrly = input$improvement,
                outputmth = input$monthly
    )
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
