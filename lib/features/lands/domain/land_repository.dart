import 'package:kisansarthi/shared/models/land.dart';

abstract class LandRepository {
  Future<List<Land>> getLandsByFarm(int farmId, {int? limit, int? offset});
  Future<Land> getLandById(int id);
  Future<Land> createLand(int farmId, String name, {String? landType, double? area, String? areaUnit});
  Future<Land> updateLand(int id, String name, {String? landType, double? area, String? areaUnit});
  Future<void> deleteLand(int id);
}
