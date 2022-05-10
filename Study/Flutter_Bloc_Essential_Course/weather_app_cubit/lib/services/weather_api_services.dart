// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app_cubit/constants/constants.dart';
import 'package:weather_app_cubit/exceptions/weather_exception.dart';
import 'package:weather_app_cubit/models/weather.dart';
import 'package:weather_app_cubit/services/http_error_handler.dart';

class WeatherApiServices {
  final http.Client httpClient;

  WeatherApiServices({
    required this.httpClient,
  });

  Future<int> getWoeid(String city) async {
    print('CALL >>> getWoeid()');
    final Uri uri = Uri(
      scheme: 'https',
      host: kHost,
      path: '/api/location/search',
      queryParameters: {
        'query': city,
      },
    );

    try {
      final http.Response response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }

      final responseBody = json.decode(response.body);

      if (responseBody.isEmpty) {
        throw WeatherException('Cannot get the woeid of $city');
      }

      if (responseBody.length > 1) {
        throw WeatherException(
            'There are multiple candidates for $city\nPlease specify further!');
      }

      return responseBody[0]['woeid'];
    } catch (e) {
      rethrow;
    }
  }

  Future<Weather> getWeather(int woeid) async {
    print('CALL >>> getWeather()');
    final Uri uri = Uri(
      scheme: 'https',
      host: kHost,
      path: '/api/location/$woeid',
    );

    try {
      final http.Response response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }

      final weatherJson = json.decode(response.body);
      final Weather weather = Weather.fromJson(weatherJson);

      return weather;
    } catch (e) {
      rethrow;
    }
  }
}
