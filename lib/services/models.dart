// To parse this JSON data, do
//
//     final cryptoExchange = cryptoExchangeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CryptoExchange cryptoExchangeFromJson(String str) =>
    CryptoExchange.fromJson(json.decode(str));

String cryptoExchangeToJson(CryptoExchange data) => json.encode(data.toJson());

class CryptoExchange {
  CryptoExchange({
    required this.fromCurrencyCode,
    required this.fromCurrencyName,
    required this.toCurrencyCode,
    required this.toCurrencyName,
    required this.exchangeRate,
    required this.lastRefreshed,
    required this.timeZone,
    required this.bidPrice,
    required this.askPrice,
  });

  String fromCurrencyCode;
  String fromCurrencyName;
  String toCurrencyCode;
  String toCurrencyName;
  String exchangeRate;
  DateTime lastRefreshed;
  String timeZone;
  String bidPrice;
  String askPrice;

  factory CryptoExchange.fromJson(Map<String, dynamic> json) => CryptoExchange(
        fromCurrencyCode: json["From_Currency Code"],
        fromCurrencyName: json["From_Currency Name"],
        toCurrencyCode: json["To_Currency Code"],
        toCurrencyName: json["To_Currency Name"],
        exchangeRate: json["Exchange Rate"],
        lastRefreshed: DateTime.parse(json["Last Refreshed"]),
        timeZone: json["Time Zone"],
        bidPrice: json["Bid Price"],
        askPrice: json["Ask Price"],
      );

  Map<String, dynamic> toJson() => {
        "From_Currency Code": fromCurrencyCode,
        "From_Currency Name": fromCurrencyName,
        "To_Currency Code": toCurrencyCode,
        "To_Currency Name": toCurrencyName,
        "Exchange Rate": exchangeRate,
        "Last Refreshed": lastRefreshed.toIso8601String(),
        "Time Zone": timeZone,
        "Bid Price": bidPrice,
        "Ask Price": askPrice,
      };
}

CryptoTimeSeries cryptoTimeSeriesFromJson(String str) =>
    CryptoTimeSeries.fromJson(json.decode(str));

String cryptoTimeSeriesToJson(CryptoTimeSeries data) =>
    json.encode(data.toJson());

class CryptoTimeSeries {
  CryptoTimeSeries({
    required this.information,
    required this.digitalCurrencyCode,
    required this.digitalCurrencyName,
    required this.marketCode,
    required this.marketName,
    required this.lastRefreshed,
    required this.timeZone,
    required this.dailyData,
  });

  String information;
  String digitalCurrencyCode;
  String digitalCurrencyName;
  String marketCode;
  String marketName;
  DateTime lastRefreshed;
  String timeZone;
  List<DailyDatum> dailyData;

  factory CryptoTimeSeries.fromJson(Map<String, dynamic> json) =>
      CryptoTimeSeries(
        information: json["Information"],
        digitalCurrencyCode: json["Digital Currency Code"],
        digitalCurrencyName: json["Digital Currency Name"],
        marketCode: json["Market Code"],
        marketName: json["Market Name"],
        lastRefreshed: DateTime.parse(json["Last Refreshed"]),
        timeZone: json["Time Zone"],
        dailyData: List<DailyDatum>.from(
            json["dailyData"].map((x) => DailyDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Information": information,
        "Digital Currency Code": digitalCurrencyCode,
        "Digital Currency Name": digitalCurrencyName,
        "Market Code": marketCode,
        "Market Name": marketName,
        "Last Refreshed": lastRefreshed.toIso8601String(),
        "Time Zone": timeZone,
        "dailyData": List<dynamic>.from(dailyData.map((x) => x.toJson())),
      };
}

class DailyDatum {
  DailyDatum({
    required this.openInr,
    required this.openUsd,
    required this.highInr,
    required this.highUsd,
    required this.lowInr,
    required this.lowUsd,
    required this.closeInr,
    required this.closeUsd,
    required this.volume,
    required this.marketCapUsd,
    required this.date,
  });

  String openInr;
  String openUsd;
  String highInr;
  String highUsd;
  String lowInr;
  String lowUsd;
  String closeInr;
  String closeUsd;
  String volume;
  String marketCapUsd;
  String date;

  factory DailyDatum.fromJson(Map<dynamic, dynamic> json) => DailyDatum(
        openInr: json["open (INR)"],
        openUsd: json["open (USD)"],
        highInr: json["high (INR)"],
        highUsd: json["high (USD)"],
        lowInr: json["low (INR)"],
        lowUsd: json["low (USD)"],
        closeInr: json["close (INR)"],
        closeUsd: json["close (USD)"],
        volume: json["volume"],
        marketCapUsd: json["market cap (USD)"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "open (INR)": openInr,
        "open (USD)": openUsd,
        "high (INR)": highInr,
        "high (USD)": highUsd,
        "low (INR)": lowInr,
        "low (USD)": lowUsd,
        "close (INR)": closeInr,
        "close (USD)": closeUsd,
        "volume": volume,
        "market cap (USD)": marketCapUsd,
      };
}
