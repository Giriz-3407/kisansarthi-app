abstract class WeatherRepository {
  Future<Map<String, dynamic>> getWeather(double lat, double lon);
}
