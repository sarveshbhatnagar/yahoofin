import 'package:yahoofin/src/models/stockChart.dart';
import 'package:yahoofin/yahoofin.dart';

main()async{
  var yfin = YahooFin();
StockHistory hist = yfin.initStockHistory(ticker: "GOOG");
StockChart chart = await yfin.getChartQuotes(stockHistory: hist, interval: StockInterval.oneDay,period: StockRange.fiveYear);
print(chart.chartQuotes!.timestamp);
}