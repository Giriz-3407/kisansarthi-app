import 'package:kisansarthi/shared/models/user.dart';

abstract class UserRepository {
  Future<User> getMe();
  Future<User> updateMe({String? name, String? email, String? phoneNumber});
}
