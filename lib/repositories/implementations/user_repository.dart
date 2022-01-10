import 'package:tranca_2_fatores/models/user.dart';

abstract class IUserRepository {
  Future<void> logInUser(String email, String password);
  Future<void> logOutUser();
  Future<bool> registerUser({user = UserModel});
}