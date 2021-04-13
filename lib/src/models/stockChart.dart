// https://query1.finance.yahoo.com/v8/finance/chart/tsla?interval=1d&range=1mo

import 'package:equatable/equatable.dart';

class ChartQuotes {
  ChartQuotes({
    this.open,
    this.low,
    this.close,
    this.volume,
    this.high,
  });

  List<num> open;
  List<num> low;
  List<num> close;
  List<num> volume;
  List<num> high;

  factory ChartQuotes.fromJson(Map<String, dynamic> json) => ChartQuotes(
        open: List<double>.from(json["open"]),
        low: List<double>.from(json["low"]),
        close: List<double>.from(json["close"]),
        volume: List<int>.from(json["volume"]),
        high: List<double>.from(json["high"]),
      );
}

class StockChart extends Equatable {
  final String ticker;
  final int mode;
  // mode 0 means only chartQuotes is initialized
  // mode 1 means only adjustedClose is initialized
  // mode 2 means both are initialized

  ChartQuotes chartQuotes;

  StockChart({this.ticker, this.chartQuotes, this.mode});

  // Will take in result.

  /// Returns StockChart with chartQuotes filled.
  /// [chartQuotes] contain high, low, open, close and volume.
  factory StockChart.fromJsonGetChart(
    Map<String, dynamic> json,
  ) {
    return StockChart(
      chartQuotes: ChartQuotes.fromJson(json["indicators"]["quote"][0]),
      mode: 0,
      ticker: json["meta"]["symbol"],
    );
  }

  @override
  List<Object> get props => [mode, ticker];
}
