library yahoofin;

import 'package:flutter/material.dart';
import 'package:yahoofin/src/features/history/stock_history.dart';
import 'package:yahoofin/src/features/information/stock_info.dart';
import 'package:yahoofin/src/models/stockQuote.dart';

class YahooFin {
  StockInfo getStockInfo({@required ticker}) {
    /// returns a [StockInfo] instance for given ticker.
    /// it is required by functions handling basic single day queries.
    return StockInfo(ticker: ticker);
  }

  StockHistory getStockHistory({@required ticker}) {
    /// returns a [StockHistory] instance for given ticker.
    /// it is required by functions handling basic multiple day queries.
    return StockHistory(ticker: ticker);
  }

  Future<StockQuote> getPrice({@required StockInfo stockInfo}) async {
    /// Returns [StockQuote] instance after getting [currentPrice],
    /// [dayHigh] and [dayLow] from the given tickers. If invalid ticker
    ///  is found, returns a [StockQuote] instance with parameters
    /// initialized to null.

    try {
      StockQuote stockQuote = await stockInfo.getStockPrice();
      return stockQuote;
    } catch (e) {
      return StockQuote(
        ticker: stockInfo.ticker,
      );
    }
  }

  Future<StockQuote> getPriceChange({@required StockInfo stockInfo}) async {
    /// Returns [StockQuote] instance after getting price change
    /// parameters including [regularMarketChange],[fiftyDayAverageChange],
    /// [fiftyTwoWeekHighChange], [fiftyTwoWeekLowChange],
    /// [twoHundredDayAverageChange], [fiftyTwoWeekLowChangePercent],
    /// [fiftyTwoWeekHighChangePercent], [fiftyDayAverageChangePercent],
    /// [twoHundredDayAverageChangePercent], [regularMarketChangePercent],
    /// from the given tickers. If invalid ticker is found, returns
    /// a [StockQuote] instance with parameters initialized to null.

    try {
      StockQuote stockQuote = await stockInfo.getStockPriceChange();
      return stockQuote;
    } catch (e) {
      return StockQuote(
        ticker: stockInfo.ticker,
      );
    }
  }

  Future<StockQuote> getVolume({@required StockInfo stockInfo}) async {
    /// Returns [StockQuote] instance after getting [currentPrice],
    /// [dayHigh] and [dayLow] from the given tickers. If invalid ticker
    ///  is found, returns a [StockQuote] instance with parameters
    /// initialized to null.

    try {
      StockQuote stockQuote = await stockInfo.getStockVolume();
      return stockQuote;
    } catch (e) {
      return StockQuote(
        ticker: stockInfo.ticker,
      );
    }
  }
}
