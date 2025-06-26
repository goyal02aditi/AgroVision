class Weather {
  final String location;
  final int temperature;
  final int minTemp;
  final int maxTemp;
  final int humidity;
  final double pressure;
  final int windSpeed;
  final int clouds;
  final String condition;
  final String icon;

  Weather({
    required this.location,
    required this.temperature,
    required this.minTemp,
    required this.maxTemp,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
    required this.clouds,
    required this.condition,
    required this.icon,
  });
}

class WeatherForecast {
  final String day;
  final String date;
  final int temperature;
  final String condition;
  final String icon;

  WeatherForecast({
    required this.day,
    required this.date,
    required this.temperature,
    required this.condition,
    required this.icon,
  });
}
