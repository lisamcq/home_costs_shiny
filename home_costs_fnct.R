
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
