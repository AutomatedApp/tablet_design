import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tablet_design/weather/model/weather.dart';

class WeatherService {
  Future<Weather> getWeatherData(String place) async {
    try {
      final queryParameters = {
        'key': '13fc24a3ec1644b7a56112849232504',
        'q': place,
      };
      final uri = Uri.http('api.weatherapi.com', '/v1/current.json', queryParameters);
      final response = await http.get(uri);
      if(response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Can not get weather");
      }
    } catch(e) {
      rethrow;
    }
  }
}