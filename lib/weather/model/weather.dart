class Weather {
  final double temperatureC;
  final int temperatureF;
  final String condition;

  Weather({
    this.temperatureC = 0,
    this.temperatureF = 0,
    this.condition = "Sunny",
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperatureC: json['current']['temp_c'],
      temperatureF: json['current']['humidity'],
      condition: json['current']['condition']['text'],
    );
  }
}