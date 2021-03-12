import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yahoofin/src/models/stockQuote.dart';
import 'package:yahoofin/src/models/yahoo_exception.dart';

class StockInfo {
  final String ticker;
  http.Response res;
  final String baseUrl = "query1.finance.yahoo.com";
  final String apiStr = "/v7/finance/quote";
  // "https://query1.finance.yahoo.com/v7/finance/quote?symbols=";

  bool _isInitialized = false;
  StockInfo({this.ticker});

  bool _isBodyValid(decoded) {
    if (decoded["quoteResponse"]["result"].length != 0) {
      return true;
    } else {
      return false;
    }
  }

  Future _init() async {
    try {
      var params = {
        "symbols": ticker,
      };
      res = await http.get(Uri.https(baseUrl, apiStr, params));
      if (res.statusCode == 200) {
        _isInitialized = true;
      }
    } catch (e) {
      print(e);
      throw YahooApiException(statusCode: 404, message: "$ticker not found");
    }
  }

  Future<StockQuote> getStockPrice() async {
    if (!_isInitialized) {
      await _init();
    }
    final decoded = jsonDecode(res.body);
    if (_isBodyValid(decoded)) {
      return StockQuote.fromJsonLoadPrice(
          decoded["quoteResponse"]["result"][0]);
    } else {
      throw YahooApiException(statusCode: 404, message: "$ticker not found");
    }
  }

  Future<StockQuote> getStockPriceChange() async {
    if (!_isInitialized) {
      await _init();
    }
    final decoded = jsonDecode(res.body);
    if (_isBodyValid(decoded)) {
      return StockQuote.fromJsonLoadChange(
          decoded["quoteResponse"]["result"][0]);
    } else {
      throw YahooApiException(statusCode: 404, message: "$ticker not found");
    }
  }

  Future<StockQuote> getStockVolume() async {
    if (!_isInitialized) {
      await _init();
    }
    final decoded = jsonDecode(res.body);
    if (_isBodyValid(decoded)) {
      return StockQuote.fromJsonLoadVolume(
          decoded["quoteResponse"]["result"][0]);
    } else {
      throw YahooApiException(statusCode: 404, message: "$ticker not found");
    }
  }

  Future<StockQuote> getStockData() async {
    if (!_isInitialized) {
      await _init();
    }
    final decoded = jsonDecode(res.body);
    if (_isBodyValid(decoded)) {
      return StockQuote.fromJson(decoded["quoteResponse"]["result"][0]);
    } else {
      throw YahooApiException(statusCode: 404, message: "$ticker not found");
    }
  }
}
