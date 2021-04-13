import 'package:flutter_test/flutter_test.dart';
import 'package:yahoofin/src/features/information/stock_info.dart';
import 'package:yahoofin/src/models/stockChart.dart';
import 'package:yahoofin/src/models/stockQuote.dart';

import 'package:yahoofin/yahoofin.dart';

void main() async {
  final yfin = YahooFin();
  StockInfo nullinfo = yfin.getStockInfo(ticker: "null");
  StockInfo info = yfin.getStockInfo(ticker: "cciv");
  StockHistory hist = yfin.initStockHistory(ticker: "tsla");

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

  test("Stock History - getHistory()", () async {
    expectLater(yfin.getChartQuotes(stockHistory: hist),
        completion(StockChart(ticker: "TSLA", mode: 0)));
  });

  test("Check Symbol exists - true", () async {
    expectLater(yfin.checkSymbol("TSLA"), completion(true));
  });
  test("Check Symbol exists - false", () async {
    expectLater(yfin.checkSymbol("ndhdhlf"), completion(false));
  });
}
