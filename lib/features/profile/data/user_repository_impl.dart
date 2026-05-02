import 'package:dio/dio.dart';
import 'package:kisansarthi/core/network/api_utils.dart';
import 'package:kisansarthi/features/profile/domain/user_repository.dart';
import 'package:kisansarthi/shared/models/user.dart';

class UserRepositoryImpl implements UserRepository {
  final Dio _dio;

  UserRepositoryImpl(this._dio);

  @override
  Future<User> getMe() async {
    final response = await _dio.get('/users/me');
    print(response.data);
    return User.fromJson(ApiUtils.extractMap(response.data));
  }

  @override
  Future<User> updateMe({String? name, String? email, String? phoneNumber}) async {
    final response = await _dio.put('/users/me', data: {
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (phoneNumber != null) 'phone_number': phoneNumber,
    });
    return User.fromJson(ApiUtils.extractMap(response.data));
  }
}
