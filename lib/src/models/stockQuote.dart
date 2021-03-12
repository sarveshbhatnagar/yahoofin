import 'package:equatable/equatable.dart';

/// Stock Quote contains several params including
/// 1. mode that tells what mode it was initialized in
/// 0 indicates price parameters was initialized
/// 1 indicates change parameters was initialized
/// 2 indicates that volume parameters was initialized and
/// 3 indicates that all the values were initialized.
///
/// It contains [ticker], [mode] for meta data
/// [currentPrice], [dayHigh], [dayLow] for price variables
///
/// [regularMarketChange], [fiftyTwoWeekLowChange], [fiftyTwoWeekHighChange],
/// [twoHundredDayAverageChangePercent], [regularMarketChangePercent],
/// [fiftyTwoWeekLowChangePercent], [fiftyTwoWeekHighChangePercent],
/// [fiftyDayAverageChangePercent], [twoHundredDayAverageChangePercent],
/// [regularMarketChangePercent] for change variables
///
/// and [regularMarketVolume], [averageDailyVolume3Month], [averageDailyVolume10Day]
/// for volume variables.
///
class StockQuote extends Equatable {
  final String ticker;

  // To compare one stock quote with other.
  // mode 0 : price, mode 1 : change, mode 2: volume
  // mode 3 : all
  final int mode;

  // Price variables
  final double currentPrice;
  final double dayHigh;
  final double dayLow;

  // Change Variables
  final double regularMarketChange;
  final double fiftyTwoWeekLowChange;
  final double fiftyTwoWeekHighChange;
  final double fiftyDayAverageChange;
  final double twoHundredDayAverageChange;

  // Change percent
  final double fiftyTwoWeekLowChangePercent;
  final double fiftyTwoWeekHighChangePercent;
  final double fiftyDayAverageChangePercent;
  final double twoHundredDayAverageChangePercent;
  final double regularMarketChangePercent;

  // Volume Variables
  final int regularMarketVolume;
  final int averageDailyVolume3Month;
  final int averageDailyVolume10Day;

  StockQuote({
    this.fiftyTwoWeekLowChangePercent,
    this.fiftyTwoWeekHighChangePercent,
    this.fiftyDayAverageChangePercent,
    this.twoHundredDayAverageChangePercent,
    this.regularMarketChangePercent,
    this.regularMarketVolume,
    this.averageDailyVolume3Month,
    this.averageDailyVolume10Day,
    this.regularMarketChange,
    this.fiftyTwoWeekLowChange,
    this.fiftyTwoWeekHighChange,
    this.fiftyDayAverageChange,
    this.twoHundredDayAverageChange,
    this.ticker,
    this.currentPrice,
    this.dayHigh,
    this.dayLow,
    this.mode,
  });

  factory StockQuote.fromJsonLoadPrice(Map<String, dynamic> json) {
    return StockQuote(
      ticker: json["symbol"],
      currentPrice: json["regularMarketPrice"],
      dayHigh: json["regularMarketDayHigh"],
      dayLow: json["regularMarketDayLow"],
      mode: 0,
    );
  }

  factory StockQuote.fromJsonLoadChange(Map<String, dynamic> json) {
    return StockQuote(
      ticker: json["symbol"],
      regularMarketChange: json["regularMarketChange"],
      fiftyDayAverageChange: json["fiftyDayAverageChange"],
      fiftyTwoWeekHighChange: json["fiftyTwoWeekHighChange"],
      fiftyTwoWeekLowChange: json["fiftyTwoWeekLowChange"],
      twoHundredDayAverageChange: json["twoHundredDayAverageChange"],
      fiftyTwoWeekLowChangePercent: json["fiftyTwoWeekLowChangePercent"],
      fiftyTwoWeekHighChangePercent: json["fiftyTwoWeekHighChangePercent"],
      fiftyDayAverageChangePercent: json["fiftyDayAverageChangePercent"],
      twoHundredDayAverageChangePercent:
          json["twoHundredDayAverageChangePercent"],
      regularMarketChangePercent: json["regularMarketChangePercent"],
      mode: 1,
    );
  }

  factory StockQuote.fromJsonLoadVolume(Map<String, dynamic> json) {
    return StockQuote(
      ticker: json["symbol"],
      regularMarketVolume: json["regularMarketVolume"],
      averageDailyVolume3Month: json["averageDailyVolume3Month"],
      averageDailyVolume10Day: json["averageDailyVolume10Day"],
      mode: 2,
    );
  }

  factory StockQuote.fromJson(Map<String, dynamic> json) {
    return StockQuote(
      ticker: json["symbol"],
      currentPrice: json["regularMarketPrice"],
      dayHigh: json["regularMarketDayHigh"],
      dayLow: json["regularMarketDayLow"],
      regularMarketChange: json["regularMarketChange"],
      fiftyDayAverageChange: json["fiftyDayAverageChange"],
      fiftyTwoWeekHighChange: json["fiftyTwoWeekHighChange"],
      fiftyTwoWeekLowChange: json["fiftyTwoWeekLowChange"],
      twoHundredDayAverageChange: json["twoHundredDayAverageChange"],
      fiftyTwoWeekLowChangePercent: json["fiftyTwoWeekLowChangePercent"],
      fiftyTwoWeekHighChangePercent: json["fiftyTwoWeekHighChangePercent"],
      fiftyDayAverageChangePercent: json["fiftyDayAverageChangePercent"],
      twoHundredDayAverageChangePercent:
          json["twoHundredDayAverageChangePercent"],
      regularMarketChangePercent: json["regularMarketChangePercent"],
      regularMarketVolume: json["regularMarketVolume"],
      averageDailyVolume3Month: json["averageDailyVolume3Month"],
      averageDailyVolume10Day: json["averageDailyVolume10Day"],
      mode: 3,
    );
  }

  @override
  List<Object> get props => [ticker, mode];
}
