import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

void main(List<String> arguments) async {
  late http.Response res;

  // "https://query1.finance.yahoo.com/v7/finance/quote?symbols=";
  final String baseUrl = "query1.finance.yahoo.com";
  final String apiStr = "/v7/finance/quote";
  
   res = await http.get(Uri.https(baseUrl, apiStr));
      if (res.statusCode == 200) {
          var jsonResponse = convert.jsonDecode(res.body) as Map<String, dynamic>;
          var quoteresponse = jsonResponse["quoteResponse"];
          print('Number of response: $quoteresponse.');
      }
      else {
    print('Request failed with status: ${res.statusCode}.');
  }


// https://query1.finance.yahoo.com/v8/finance/chart/tsla?interval=1d&range=1mo

final String hbaseUrl = "query1.finance.yahoo.com";
final String hapiStr = "/v8/finance/chart";
      res = await http.get(Uri.https(hbaseUrl, hapiStr));
      if (res.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(res.body) as Map<String, dynamic>;
          var chart = jsonResponse["chart"];
          print('Number of response: $chart.');
      }
      else {
    print('Request failed with status: ${res.statusCode}.');
  }



}