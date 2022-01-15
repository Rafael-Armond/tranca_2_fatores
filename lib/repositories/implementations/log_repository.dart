import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tranca_2_fatores/repositories/interfaces/i_log_repository.dart';
import 'package:tranca_2_fatores/utils/enums.dart';
import 'package:tranca_2_fatores/utils/snackbar_util.dart';

class LogRepository implements ILogRepository {
  final db = FirebaseFirestore.instance;

  @override
  Future<void> signInLog(
      {required String email, required LogActions logAction}) async {
    try {
      db.collection('logs').doc().set({
        'email': email,
        'action': LogActions.loginUser.toString(),
        'created_at': DateTime.now(),
      });
    } catch (e) {
      SnackbarUtil.showErrorSnackbar(
        title: "Erro ao registrar log",
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> signOutLog(
      {required String email, required LogActions logAction}) async {
    try {
      db.collection('logs').doc(email).set({
        'email': email,
        'action': LogActions.logoutUser.toString(),
        'created_at': DateTime.now(),
      });
    } catch (e) {
      SnackbarUtil.showErrorSnackbar(
        title: "Erro ao registrar log",
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> signUpLog(
      {required String email, required LogActions logAction}) async {
    try {
      db.collection('logs').doc(email).set({
        'email': email,
        'action': LogActions.createUser.toString(),
        'created_at': DateTime.now(),
      });
    } catch (e) {
      SnackbarUtil.showErrorSnackbar(
        title: "Erro ao registrar log",
        message: e.toString(),
      );
    }
  }
}
