class YahooApiException implements Exception {
  final int statusCode;
  final String message;

  const YahooApiException({this.statusCode, this.message});
}
