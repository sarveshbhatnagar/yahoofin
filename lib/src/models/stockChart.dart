// https://query1.finance.yahoo.com/v8/finance/chart/tsla?interval=1d&range=1mo

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

class StockChart {
  final String ticker;

  List<num> adjustedClose;
  ChartQuotes chartQuotes;

  StockChart({this.ticker, this.chartQuotes, this.adjustedClose});

  // Will take in result.

  /// Returns StockChart with chartQuotes filled.
  /// [chartQuotes] contain high, low, open, close and volume.
  factory StockChart.fromJsonGetChart(Map<String, dynamic> json) {
    return StockChart(
        chartQuotes: ChartQuotes.fromJson(json["indicators"]["quote"]));
  }

  /// Returns StockChart with adjustedClose filled.
  /// [adjustedClose] contains adjustedClose values.
  factory StockChart.fromJsonGetAdjustedClose(Map<String, dynamic> json) {
    return StockChart(adjustedClose: json["indicators"]["adjclose"]);
  }

  /// Initializes both [chartQuotes] and [adjustedClose]
  /// [chartQuotes] contain open,close,high,low and volume data
  /// [adjustedClose] contains adjustedClose values.
  factory StockChart.fromJson(Map<String, dynamic> json) {
    return StockChart(
      chartQuotes: ChartQuotes.fromJson(json["indicators"]["quote"]),
      adjustedClose: json["indicators"]["adjclose"],
    );
  }
}
