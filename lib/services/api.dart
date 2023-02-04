import 'dart:convert';

import 'package:crypto_app/services/models.dart';
import 'package:http/http.dart' as http;

List<String> xRapidApiKey = [
  '28a44625a5mshd4811739fd9dc5dp1016c7jsnbbb92a6e1959',
  'e3e910496bmshbc2fbb65e5dda77p1c6d65jsn5d078a5e16c2',
  '95da98a3damshc54ba5896a417dep1c6732jsn54c550fd894c'
];
String url = 'https://alpha-vantage.p.rapidapi.com/';

Future<CryptoExchange> getCurrentExchangeRate(
    String cryptoCode, String exchangeCurrency) async {
  Map<String, dynamic> data = {};
  http.Response response = await http.get(
    Uri.parse(
      url +
          'query?function=CURRENCY_EXCHANGE_RATE&from_currency=$cryptoCode&to_currency=$exchangeCurrency',
    ),
    headers: {
      'x-rapidapi-key': xRapidApiKey[0],
      'x-rapidapi-host': 'alpha-vantage.p.rapidapi.com',
    },
  );
  if (response.statusCode == 200) {
    // print(response.body);
    Map tempData = jsonDecode(response.body)['Realtime Currency Exchange Rate'];
    for (var key in tempData.keys) {
      data[key.split('.')[1].trim()] = tempData[key];
    }
  } else {
    print(response.statusCode);
  }
  return CryptoExchange.fromJson(data);
}

int call = 0;
Future<CryptoTimeSeries> getLastTenTimeExchangeRate(String cryptoCode,
    {String timeType = 'DAILY'}) async {
  call++;
  List data = [];
  Map<String, dynamic> metaData = {};
  try {
    http.Response response = await http.get(
      Uri.parse(
        url +
            'query?function=DIGITAL_CURRENCY_$timeType&symbol=$cryptoCode&market=INR',
      ),
      headers: {
        'x-rapidapi-key': xRapidApiKey[call % 3],
        'x-rapidapi-host': 'alpha-vantage.p.rapidapi.com',
      },
    );
    if (response.statusCode == 200) {
      // print(response.body);
      Map tempMetaData = jsonDecode(response.body)['Meta Data'];
      for (var key in tempMetaData.keys) {
        metaData[key.split('.')[1].trim()] = tempMetaData[key];
      }
      String timeSeries = timeType == 'DAILY'
          ? 'Time Series (Digital Currency Daily)'
          : timeType == 'WEEKLY'
              ? 'Time Series (Digital Currency Weekly)'
              : 'Time Series (Digital Currency Monthly)';
      Map tempData =
          jsonDecode(response.body)[timeSeries];
      int count = 0;
      for (var key in tempData.keys) {
        count++;
        Map temp = {};
        for (var key2 in tempData[key].keys) {
          temp[key2.split('.')[1].trim()] = tempData[key][key2];
        }
        temp['date'] = key;
        data.add(temp);
        if (count == 10) {
          break;
        }
      }
    } else {
      print(response.statusCode);
    }
    metaData['dailyData'] = data;
    return CryptoTimeSeries.fromJson(metaData);
  } catch (e) {
    print(e);
    return cryptoTimeSeriesFromJson(
        '{"Information":"Daily Prices and Volumes for Digital Currency","Digital Currency Code":"BTC","Digital Currency Name":"Bitcoin","Market Code":"CNY","Market Name":"Chinese Yuan","Last Refreshed":"2023-02-04 00:00:00","Time Zone":"UTC","dailyData": [{"open (INR)":"1936225.47190000","open (USD)":"23489.33000000","high (INR)":"1954885.15100000","high (USD)":"23715.70000000","low (INR)":"1912756.82660000","low (USD)":"23204.62000000","close (INR)":"1931491.51700000","close (USD)":"23431.90000000","volume":"332571.02904000","market cap (USD)":"332571.02904000"},{"open (INR)":"1936225.47190000","open (USD)":"23489.33000000","high (INR)":"1954885.15100000","high (USD)":"23715.70000000","low (INR)":"1912756.82660000","low (USD)":"23204.62000000","close (INR)":"1931491.51700000","close (USD)":"23431.90000000","volume":"332571.02904000","market cap (USD)":"332571.02904000"},{"open (INR)":"1936225.47190000","open (USD)":"23489.33000000","high (INR)":"1954885.15100000","high (USD)":"23715.70000000","low (INR)":"1912756.82660000","low (USD)":"23204.62000000","close (INR)":"1931491.51700000","close (USD)":"23431.90000000","volume":"332571.02904000","market cap (USD)":"332571.02904000"},{"open (INR)":"1936225.47190000","open (USD)":"23489.33000000","high (INR)":"1954885.15100000","high (USD)":"23715.70000000","low (INR)":"1912756.82660000","low (USD)":"23204.62000000","close (INR)":"1931491.51700000","close (USD)":"23431.90000000","volume":"332571.02904000","market cap (USD)":"332571.02904000"},{"open (INR)":"1936225.47190000","open (USD)":"23489.33000000","high (INR)":"1954885.15100000","high (USD)":"23715.70000000","low (INR)":"1912756.82660000","low (USD)":"23204.62000000","close (INR)":"1931491.51700000","close (USD)":"23431.90000000","volume":"332571.02904000","market cap (USD)":"332571.02904000"},{"open (INR)":"1936225.47190000","open (USD)":"23489.33000000","high (INR)":"1954885.15100000","high (USD)":"23715.70000000","low (INR)":"1912756.82660000","low (USD)":"23204.62000000","close (INR)":"1931491.51700000","close (USD)":"23431.90000000","volume":"332571.02904000","market cap (USD)":"332571.02904000"},{"open (INR)":"1936225.47190000","open (USD)":"23489.33000000","high (INR)":"1954885.15100000","high (USD)":"23715.70000000","low (INR)":"1912756.82660000","low (USD)":"23204.62000000","close (INR)":"1931491.51700000","close (USD)":"23431.90000000","volume":"332571.02904000","market cap (USD)":"332571.02904000"},{"open (INR)":"1936225.47190000","open (USD)":"23489.33000000","high (INR)":"1954885.15100000","high (USD)":"23715.70000000","low (INR)":"1912756.82660000","low (USD)":"23204.62000000","close (INR)":"1931491.51700000","close (USD)":"23431.90000000","volume":"332571.02904000","market cap (USD)":"332571.02904000"},{"open (INR)":"1936225.47190000","open (USD)":"23489.33000000","high (INR)":"1954885.15100000","high (USD)":"23715.70000000","low (INR)":"1912756.82660000","low (USD)":"23204.62000000","close (INR)":"1931491.51700000","close (USD)":"23431.90000000","volume":"332571.02904000","market cap (USD)":"332571.02904000"},{"open (INR)":"1936225.47190000","open (USD)":"23489.33000000","high (INR)":"1954885.15100000","high (USD)":"23715.70000000","low (INR)":"1912756.82660000","low (USD)":"23204.62000000","close (INR)":"1931491.51700000","close (USD)":"23431.90000000","volume":"332571.02904000","market cap (USD)":"332571.02904000"}]}');
  }
}
