import 'dart:convert';

import 'package:yahoofin/src/models/yahoo_exception.dart';
import 'package:http/http.dart' as http;

/// Class for interacting with metadata of a stock.
class StockMetaData {
  final String ticker;
  http.Response res;
  bool _isInitialized = false;
  final String baseUrl = "query1.finance.yahoo.com";
  final String apiStr = "/v7/finance/quote";
  StockMetaData({this.ticker});
  bool _isBodyValid(decoded) {
    if (decoded["quoteResponse"]["result"].length != 0) {
      print("HERE TRUE");
      return true;
    } else {
      print("HERE FALSE");
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

  ///Checks if [ticker] is valid or invalid.
  ///If valid, returns [true]
  ///If invalid, returns [false]
  Future<bool> checkSymbol() async {
    if (!_isInitialized) {
      await _init();
    }
    final decoded = jsonDecode(res.body);
    if (_isBodyValid(decoded)) {
      return true;
    } else {
      return false;
    }
  }
}
