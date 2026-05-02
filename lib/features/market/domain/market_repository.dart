import 'package:kisansarthi/shared/models/market_price.dart';

abstract class MarketRepository {
  Future<List<MarketPrice>> getMarketPrices({String? crop, String? location, String? lang});
}
