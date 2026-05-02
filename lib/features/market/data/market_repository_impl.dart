import 'package:dio/dio.dart';
import 'package:kisansarthi/core/network/api_utils.dart';
import 'package:kisansarthi/features/market/domain/market_repository.dart';
import 'package:kisansarthi/shared/models/market_price.dart';
import 'dart:developer' as dev;

class MarketRepositoryImpl implements MarketRepository {
  final Dio _dio;

  MarketRepositoryImpl(this._dio);

  @override
  Future<List<MarketPrice>> getMarketPrices({String? crop, String? location, String? lang}) async {
    try {
      final response = await _dio.get('/market/prices', queryParameters: {
        if (crop != null) 'crop': crop,
        if (location != null) 'location': location,
        if (lang != null) 'lang': lang,
      });

      dev.log("RAW RESPONSE: ${response.data}", name: 'MarketRepository');
      print("RAW RESPONSE: ${response.data}");

      final records = ApiUtils.extractWrappedList(response.data, keys: ['records']);
      return records
          .whereType<Map<String, dynamic>>()
          .map((e) => MarketPrice.fromJson(e))
          .toList();
    } catch (e) {
      dev.log("Error fetching market prices: $e", name: 'MarketRepository', error: e);
      rethrow;
    }
  }
}
