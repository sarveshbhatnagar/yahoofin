import 'package:flutter_test/flutter_test.dart';
import 'package:yahoofin/src/features/history/stock_history.dart';
import 'package:yahoofin/src/features/information/stock_info.dart';
import 'package:yahoofin/src/models/stockQuote.dart';

import 'package:yahoofin/yahoofin.dart';

void main() async {
  final yfin = YahooFin();
  StockInfo nullinfo = yfin.getStockInfo(ticker: "null");
  StockInfo info = yfin.getStockInfo(ticker: "cciv");
  // TODO implement test for history
  // StockHistory hist = yfin.getStockHistory(ticker: "msft");
  // hist.getHistory();
  test("""Checks StockInfo Functions for their validity
   (YahooFin)(note: update test case for testing date)""", () async {
    StockQuote q = await yfin.getPrice(stockInfo: info);
    print(q.currentPrice);
    expectLater(
        yfin.getPrice(stockInfo: info),
        completion(StockQuote(
          ticker: "CCIV",
          mode: 0,
        )));
    expectLater(
        yfin.getPrice(stockInfo: nullinfo),
        completion(StockQuote(
          ticker: "null",
        )));
    expectLater(
        yfin.getPriceChange(stockInfo: info),
        completion(StockQuote(
          ticker: "CCIV",
          mode: 1,
        )));
    expectLater(
        yfin.getPriceChange(stockInfo: nullinfo),
        completion(StockQuote(
          ticker: "null",
        )));
    expectLater(
        yfin.getVolume(stockInfo: info),
        completion(StockQuote(
          ticker: "CCIV",
          mode: 2,
        )));
    expectLater(
        yfin.getVolume(stockInfo: nullinfo),
        completion(StockQuote(
          ticker: "null",
        )));
  });
}
