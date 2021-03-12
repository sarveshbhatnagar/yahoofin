# yahoofin

Enables you to fetch yahoo finance data using yahoo finance api.

## Getting Started

To work with this package, initialize a yahoofin object first.

```
final yfin = YahooFin();
```

## Get latest single day data

To get single day data for a given stock get StockInfo object using getStockInfo method of yfin.

```
StockInfo info = yfin.getStockInfo(ticker: "msft");
```

based on this info object you can call different methods such as getPrice, getPriceChange and getVolume of yfin. Each of these functions are async functions that returns price, price change and volume of the stock which StockInfo object is specified with.

```
StockQuote price = yfin.getPrice(stockInfo: info)
StockQuote priceChange = yfin.getPriceChange(stockInfo: info)
StockQuote volume = yfin.getVolume(stockInfo: info)
```

Stock Quote contains several params including
mode that tells what mode it was initialized in 0 indicates price parameters was initialized 1 indicates change parameters was initialized 2 indicates that volume parameters was initialized and 3 indicates that all the values were initialized.

It contains [ticker], [mode] for meta data [currentPrice], [dayHigh], [dayLow] for price variables

[regularMarketChange], [fiftyTwoWeekLowChange], [fiftyTwoWeekHighChange], [twoHundredDayAverageChangePercent], [regularMarketChangePercent], [fiftyTwoWeekLowChangePercent], [fiftyTwoWeekHighChangePercent], [fiftyDayAverageChangePercent], [twoHundredDayAverageChangePercent], [regularMarketChangePercent] for change variables

and [regularMarketVolume], [averageDailyVolume3Month], [averageDailyVolume10Day] for volume variables.

## Getting Stock history

Coming soon. Want to contribute? contact me.
