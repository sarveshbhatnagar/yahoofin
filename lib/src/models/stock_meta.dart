import 'package:equatable/equatable.dart';

/// Class for some of the meta data of a stock
/// params: [shortName], [longName], [displayName],
/// [regularMarketDayRange], [averageAnalystRating],
/// [currency],[fiftyTwoWeekRange].
class StockMeta extends Equatable {
  final String? shortName;
  final String? longName;
  final String? displayName;
  final String? regularMarketDayRange;
  final String? averageAnalystRating;
  final String? currency;
  final String? fiftyTwoWeekRange;
  final String? quoteType;
  final String? exchange;
  final String? fullExchangeName;

  StockMeta({
    this.shortName,
    this.averageAnalystRating,
    this.currency,
    this.displayName,
    this.fiftyTwoWeekRange,
    this.longName,
    this.regularMarketDayRange,
    this.quoteType,
    this.exchange,
    this.fullExchangeName,
  });

  factory StockMeta.fromJson(Map<String, dynamic> json) {
    return StockMeta(
      shortName: json["shortName"],
      longName: json["longName"],
      displayName: json["displayName"],
      regularMarketDayRange: json["regularMarketDayRange"],
      averageAnalystRating: json["averageAnalystRating"],
      currency: json["currency"],
      fiftyTwoWeekRange: json["fiftyTwoWeekRange"],
      quoteType: json["quoteType"],
      exchange: json["exchange"],
      fullExchangeName: json["fullExchangeName"],
    );
  }

  @override
  List<Object?> get props => [displayName];
}
