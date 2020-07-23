# SQL Assignment on Stock Market Analysis

#### Problem Statement

The dataset provided here has been extracted from the NSE website. The Stock price data provided is from 1-Jan-2015 to 31-July-2018 for six stocks Eicher Motors, Hero, Bajaj Auto, TVS Motors, Infosys and TCS.

#### Results Expected
1. Create a new table named 'bajaj1' containing the date, close price, 20 Day MA and 50 Day MA. (This has to be done for all 6 stocks)
   Date | Close Price | 20 Day MA | 50 Day MA               

2. Create a master table containing the date and close price of all the six stocks. (Column header for the price is the name of the stock)
   The table header should appear as below:
   Date | Bajaj | TCS | TVS | Infosys | Eicher | Hero         

3. Use the table created in Part(1) to generate buy and sell signal. Store this in another table named 'bajaj2'. Perform this operation for all stocks.
   Date | Close Price | Signal        
 
4. Create a User defined function, that takes the date as input and returns the signal for that particular day (Buy/Sell/Hold) for the Bajaj stock.

5. Write a brief summary of the results obtained and what inferences you can draw from the analysis performed. (Less than 250 words to be submitted in a pdf file)
