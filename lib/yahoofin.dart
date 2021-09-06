library yahoofin;

// Export all the required classes that are required by users.
export 'src/features/information/stock_info.dart';
export 'src/features/history/stock_history.dart';
export 'src/features/metadata/stockmetadata.dart';
export 'src/models/stockQuote.dart';

import 'package:yahoofin/src/features/history/stock_history.dart';
import 'package:yahoofin/src/features/information/stock_info.dart';
import 'package:yahoofin/src/features/metadata/stockmetadata.dart';
import 'package:yahoofin/src/models/stockChart.dart';
import 'package:yahoofin/src/models/stockMeta.dart';
import 'package:yahoofin/src/models/stockQuote.dart';

class YahooFin {
  /// returns a [StockInfo] instance for given ticker.
  /// it is required by functions handling basic single day queries.
  StockInfo getStockInfo({required ticker}) {
    return StockInfo(ticker: ticker);
  }

  /// returns a [StockHistory] instance for given ticker.
  /// it is required by functions handling basic multiple day queries.
  StockHistory initStockHistory({required ticker}) {
    return StockHistory(ticker: ticker);
  }

  /// Returns [StockQuote] instance after getting [currentPrice],
  /// [dayHigh] and [dayLow] from the given tickers. If invalid ticker
  ///  is found, returns a [StockQuote] instance with parameters
  /// initialized to null.
  Future<StockQuote> getPrice({required StockInfo stockInfo}) async {
    try {
      StockQuote stockQuote = await stockInfo.getStockPrice();
      return stockQuote;
    } catch (e) {
      return StockQuote(
        ticker: stockInfo.ticker,
      );
    }
  }

  /// Returns [StockQuote] instance after getting price change
  /// parameters including [regularMarketChange],[fiftyDayAverageChange],
  /// [fiftyTwoWeekHighChange], [fiftyTwoWeekLowChange],
  /// [twoHundredDayAverageChange], [fiftyTwoWeekLowChangePercent],
  /// [fiftyTwoWeekHighChangePercent], [fiftyDayAverageChangePercent],
  /// [twoHundredDayAverageChangePercent], [regularMarketChangePercent],
  /// from the given tickers. If invalid ticker is found, returns
  /// a [StockQuote] instance with parameters initialized to null.
  Future<StockQuote> getPriceChange({required StockInfo stockInfo}) async {
    try {
      StockQuote stockQuote = await stockInfo.getStockPriceChange();
      return stockQuote;
    } catch (e) {
      return StockQuote(
        ticker: stockInfo.ticker,
      );
    }
  }

  /// Returns [StockQuote] instance after getting [currentPrice],
  /// [dayHigh] and [dayLow] from the given tickers. If invalid ticker
  ///  is found, returns a [StockQuote] instance with parameters
  /// initialized to null.
  Future<StockQuote> getVolume({required StockInfo stockInfo}) async {
    try {
      StockQuote stockQuote = await stockInfo.getStockVolume();
      return stockQuote;
    } catch (e) {
      return StockQuote(
        ticker: stockInfo.ticker,
      );
    }
  }

  /// Returns stockChart initialized with both [chartQuotes] and
  /// [adjustedClose] prices.
  Future<StockChart> getChartQuotes(
      {required StockHistory stockHistory,
      StockInterval interval = StockInterval.oneDay,
      StockRange period = StockRange.oneMonth}) async {
    try {
      StockChart chart = await stockHistory.getChartQuotes(
        interval: interval,
        period: period,
      );
      return chart;
    } catch (e) {
      return StockChart(ticker: stockHistory.ticker);
    }
  }

  /// Checks if symbol exists or not.
  Future<bool> checkSymbol(String symbol) async {
    return await StockMetaData(ticker: symbol).checkSymbol();
  }

  Future<StockMeta> getMetaData(String symbol) async {
    return await StockMetaData(ticker: symbol).getStockMetaData();
  }
}
