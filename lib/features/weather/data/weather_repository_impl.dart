import 'package:dio/dio.dart';
import 'package:kisansarthi/core/network/api_utils.dart';
import 'package:kisansarthi/features/weather/domain/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final Dio _dio;

  WeatherRepositoryImpl(this._dio);

  @override
  Future<Map<String, dynamic>> getWeather(double lat, double lon) async {
    final response = await _dio.get('/weather', queryParameters: {
      'lat': lat,
      'lon': lon,
    });
    return ApiUtils.extractMap(response.data);
  }
}
