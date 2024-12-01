# Cost of home ownership
R shiny app for calculating costs of home ownership.

I wanted to adapt the standard "mortgage calculator" that is used to calculate a monthly mortgage payment to include all the possible costs of home ownership, including strata fees, taxes, home maintenance costs, and home improvement costs. This shiny app adds these costs categories to a mortgage payment and outputs the total monthly or yearly cost of home ownership.

The mortgage payment is calculated assuming the interest rate is fixed over the amortization period and uses the formula from https://en.wikipedia.org/wiki/Mortgage_calculator.

Copy and paste the following code to the R console and run to start the app:
runGitHub( "home_costs_shiny", "lisamcq")
