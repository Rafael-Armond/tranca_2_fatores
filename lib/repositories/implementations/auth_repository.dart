import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tranca_2_fatores/repositories/implementations/log_repository.dart';
import 'package:tranca_2_fatores/repositories/interfaces/i_auth_repository.dart';
import 'package:tranca_2_fatores/utils/enums.dart';
import 'package:tranca_2_fatores/utils/snackbar_util.dart';

class AuthRepository implements IAuthRepository {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  LogRepository logRepository = LogRepository();

  @override
  Future<void> logInUser(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      // db.collection('logs').doc(email).set({
      //   'action': LogActions.loginUser.toString(),
      //   'created_at': DateTime.now(),
      // });
      logRepository.signInLog(email: email, logAction: LogActions.loginUser);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  @override
  Future<void> logOutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<bool> registerUser(
      {required String fullName,
      required String email,
      required String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Registrando user no firestore
      db.collection('users').doc(email).set({
        'full_name': fullName,
        'email': email,
        'created_at': DateTime.now(),
      });

      // Criando log de registro
      db.collection('logs').doc(email).set({
        'action': LogActions.createUser.toString(),
        'created_at': DateTime.now(),
      });

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        SnackbarUtil.showErrorSnackbar(
            title: 'Email já cadastrado:',
            message: 'Já existe um usuário cadastrado para esse email.');
      } else if (e.code == 'weak-password') {
        SnackbarUtil.showErrorSnackbar(
            title: 'Senha muito fraca:',
            message: 'A senha informada precisa ter no minimo 6 caracteres.');
      } else if (e.code == 'invalid-email') {
        SnackbarUtil.showErrorSnackbar(
            title: 'Email inválido:', message: 'O email informado é inválido.');
      } else {
        SnackbarUtil.showErrorSnackbar(
            title: 'Erro no cadastro:',
            message: 'Ocorreu um problema, tente novamente mais tarde.');
      }
      return false;
    }
  }
}
