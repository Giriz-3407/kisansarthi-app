import 'dart:io';
import 'package:kisansarthi/shared/models/farm.dart';

abstract class FarmRepository {
  Future<List<Farm>> getFarms({int? limit, int? offset});
  Future<Farm> getFarmById(int id);
  Future<Farm> createFarm(String name, {String? location, String? address});
  Future<Farm> updateFarm(int id, String name, {String? location, String? address});
  Future<void> deleteFarm(int id);
  Future<void> uploadFarmImage(int farmId, File imageFile);
}
