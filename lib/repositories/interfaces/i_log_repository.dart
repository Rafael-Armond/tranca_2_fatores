import 'package:tranca_2_fatores/utils/enums.dart';

abstract class ILogRepository {
  Future<void> signInLog(
      {required String email, required LogActions logAction});
  Future<void> signOutLog(
      {required String email, required LogActions logAction});
  Future<void> signUpLog(
      {required String email, required LogActions logAction});
}
