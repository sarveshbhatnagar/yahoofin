// https://query1.finance.yahoo.com/v8/finance/chart/tsla?interval=1d&range=1mo

import 'dart:convert';

import 'package:yahoofin/src/models/stock_chart.dart';
import 'package:http/http.dart' as http;
import 'package:yahoofin/src/models/yahoo_exception.dart';

/// Enum to specify timeframe of required data
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

/// Enum to specify how long a single data point spans
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

/// Module required to access chart functions.
class StockHistory {
  late http.Response res;
  bool _isInitialized = false;
  final String? ticker;
  // final String baseUrl = "https://query1.finance.yahoo.com/v8/finance/chart/";
  final String baseUrl = "query1.finance.yahoo.com";
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
    /// Checks if the decoded json is valid. returns [true] if it is
    /// otherwise returns [false].
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

  Future _init(params) async {
    /// Makes an api request to initialize data.
    try {
      final String apiStr = "/v8/finance/chart/$ticker";
      res = await http.get(Uri.https(baseUrl, apiStr, params));
      if (res.statusCode == 200) {
        _isInitialized = true;
      }
    } catch (e) {
      throw YahooApiException(statusCode: 404, message: "$ticker not found");
    }
  }

  /// Returns a [StockChart] with initialized values based on the request.
  /// params:
  /// [interval] - Takes in a [StockInterval] value.
  /// It specifies span of one tick of data.
  ///
  /// [period] - Takes in a [StockRange] value.
  /// It specifies range of data items.
  Future<StockChart> getChartQuotes(
      {StockInterval interval = StockInterval.oneDay,
      StockRange period = StockRange.oneMonth}) async {
    if (!_isInitialized) {
      await _init({
        "interval": intervalMap[interval],
        "range": rangeMap[period],
      });
    }
    if (interval != StockInterval.oneDay || period != StockRange.oneMonth) {
      // If params is changed, calls init again.
      await _init({
        "interval": intervalMap[interval],
        "range": rangeMap[period],
      });
    }
    final decoded = jsonDecode(res.body);
    if (_isBodyValid(decoded)) {
      // print("HEREEE");
      // print(decoded["chart"]["result"][0]["indicators"]);
      return StockChart.fromJsonGetChart(decoded["chart"]["result"][0]);
      // return stockChartFromJson(res.body).chart.result.map((e) => e.indicators);
    } else {
      throw YahooApiException(statusCode: 000, message: "Invalid Body");
    }
    // return StockChart();
  }
}
