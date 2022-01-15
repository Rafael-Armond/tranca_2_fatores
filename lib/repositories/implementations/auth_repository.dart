import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tranca_2_fatores/repositories/interfaces/i_auth_repository.dart';
import 'package:tranca_2_fatores/utils/snackbar_util.dart';

class AuthRepository implements IUserRepository {
  final auth = FirebaseAuth.instance;

  @override
  Future<void> logInUser(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }

    @override
    Future<void> logOutUser() async {
      await FirebaseAuth.instance.signOut();
    }

    @override
    Future<bool> registerUser(String email, String password) async {
      try {
        await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        // FirebaseFirestore.instance.collection('users').doc(email).set({
        //   'full_name': userController.fullName.value,
        //   'email': userController.email.value,
        //   'created_at': userController.createdAt.value,
        // });

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
              title: 'Email inválido:',
              message: 'O email informado é inválido.');
        } else {
          SnackbarUtil.showErrorSnackbar(
              title: 'Erro no cadastro:',
              message: 'Ocorreu um problema, tente novamente mais tarde.');
        }
        return false;
      }
    }
  }

  @override
  Future<void> logOutUser() {
    // TODO: implement logOutUser
    throw UnimplementedError();
  }

  @override
  Future<bool> registerUser(String email, String password) {
    // TODO: implement registerUser
    throw UnimplementedError();
  }
}
