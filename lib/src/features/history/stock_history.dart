// https://query1.finance.yahoo.com/v8/finance/chart/tsla?interval=1d&range=1mo

import 'dart:convert';

import 'package:yahoofin/src/models/stockChart.dart';
import 'package:http/http.dart' as http;
import 'package:yahoofin/src/models/yahoo_exception.dart';

enum StockRange {
  oneDay,
  fiveDay,
  oneMonth,
  threeMonth,
  sixMonth,
  oneYear,
  twoYear,
  fiveYear,
  tenYear,
  ytd,
  maxRange,
}

enum StockInterval {
  oneMinute,
  twoMinute,
  fiveMinute,
  fifteenMinute,
  thirtyMinute,
  sixtyMinute,
  ninetyMinute,
  oneDay,
  fiveDay,
  oneWeek,
  oneMonth,
  threeMonth,
}

class StockHistory {
  http.Response res;
  bool _isInitialized = false;
  final String ticker;
  final String baseUrl = "https://query1.finance.yahoo.com/v8/finance/chart/";
  final StockInterval interval;
  final StockRange range;

  // valid range : 1d, 5d, 1mo, 3mo, 6mo, 1y, 2y, 5y, 10y, ytd, max
  // valid interval : 1m, 2m,5m,15m,30m,60m,90m,1h,1d,5d,1wk,1mo,3mo

  final Map<StockRange, String> rangeMap = {
    StockRange.oneDay: "1d",
    StockRange.fiveDay: "5d",
    StockRange.oneMonth: "1mo",
    StockRange.threeMonth: "3mo",
    StockRange.sixMonth: "6mo",
    StockRange.oneYear: "1y",
    StockRange.twoYear: "2y",
    StockRange.fiveYear: "5y",
    StockRange.tenYear: "10y",
    StockRange.ytd: "ytd",
    StockRange.maxRange: "max",
  };

  // valid interval : 1m, 2m,5m,15m,30m,60m,90m,1h,1d,5d,1wk,1mo,3mo
  final Map<StockInterval, String> intervalMap = {
    StockInterval.oneMinute: "1m",
    StockInterval.twoMinute: "2m",
    StockInterval.fiveMinute: "5m",
    StockInterval.fifteenMinute: "15m",
    StockInterval.thirtyMinute: "30m",
    StockInterval.sixtyMinute: "60m",
    StockInterval.ninetyMinute: "90m",
    StockInterval.oneDay: "1d",
    StockInterval.fiveDay: "5d",
    StockInterval.oneWeek: "1wk",
    StockInterval.oneMonth: "1mo",
    StockInterval.threeMonth: "3mo",
  };

  StockHistory({
    this.ticker,
    this.interval = StockInterval.oneDay,
    this.range = StockRange.oneMonth,
  });

  bool _isBodyValid(decoded) {
    try {
      if (decoded["chart"]["result"] != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw YahooApiException(statusCode: 404, message: "Some Error Occured");
    }
  }

  Future _init() async {
    try {
      res = await http.get(baseUrl + ticker);
      if (res.statusCode == 200) {
        _isInitialized = true;
      }
    } catch (e) {
      throw YahooApiException(statusCode: 404, message: "$ticker not found");
    }
  }

  Future<StockChart> getHistory() async {
    if (!_isInitialized) {
      await _init();
    }
    final decoded = jsonDecode(res.body);
    if (_isBodyValid(decoded)) {
      print(decoded["chart"]["result"]);
      return StockChart(ticker: ticker);
      // return stockChartFromJson(res.body).chart.result.map((e) => e.indicators);
    } else {
      throw YahooApiException(statusCode: 000, message: "Invalid Body");
    }
    // return StockChart();
  }
}
