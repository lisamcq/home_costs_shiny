######################################################################
#Title: app.R
#Author: Lisa McQuarrie
#Date: Dec. 1, 2024
#Purpose: Shiny app code for calculating home ownership costs
#####################################################################
library(shiny)

#load the mthly_costs function
mthly_costs <- function(home_price, downpayment,
                        amortization, interest_rate_pct,
                        strata_mthly=0, taxes_yrly=0,
                        maintenance_yrly=0, improvement_yrly=0,
                        outputmth = "month"){
  #home_price - total price of home, dollars
  #downpayment - amount of downpayment, dollars
  #amortization - number of years to pay off mortgage
  #interest_rate - yearly interest rate (assumed fixed) (as percent, ie. 6.5 for 6.5%)
  #strata_mthly - monthly strata fee
  #taxes_yrly - gross taxes, yearly
  #maintenance_yrly - estimate of yearly amount to maintain home
  #improvement_yrly - estimate of yearly amount to improve/decorate home
  #outputmth - return monthly costs, if FALSE then returns yearly costs
  #returns monthly or yearly costs of home ownership
  #using mortgage calculation formula from https://en.wikipedia.org/wiki/Mortgage_calculator
  
  r = interest_rate_pct/100/12
  P = home_price - downpayment
  N = amortization*12
  
  if(r != 0) c = (r*P*(1+r)^N)/((1+r)^N - 1)
  else c=P/N
  
  monthly = c + strata_mthly + taxes_yrly/12 + maintenance_yrly/12 + improvement_yrly/12
  yearly = monthly*12
  
  if(tolower(outputmth) == "month") return(round(monthly, 2))
  else return(round(yearly,2))
}

#example execution
#mthly_costs(home_price = 600000, downpayment = 200000, 
            #amortization = 25, interest_rate_pct = 5,
           # strata_mthly = 500, taxes_yrly = 2500,
            #maintenance_yrly = 5000, improvement_yrly = 2500
           # )


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
