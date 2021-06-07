import 'package:equatable/equatable.dart';

class StockMeta extends Equatable {
  String? shortName;
  String? longName;
  String? displayName;
  String? regularMarketDayRange;
  String? averageAnalystRating;
  String? currency;
  String? fiftyTwoWeekRange;

  StockMeta({
    this.shortName,
    this.averageAnalystRating,
    this.currency,
    this.displayName,
    this.fiftyTwoWeekRange,
    this.longName,
    this.regularMarketDayRange,
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
    );
  }

  @override
  List<Object?> get props => [displayName];
}
