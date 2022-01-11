import 'package:firebase_auth/firebase_auth.dart';
import 'package:tranca_2_fatores/models/user.dart';
import 'package:tranca_2_fatores/repositories/interfaces/i_user_repository.dart';
import 'package:tranca_2_fatores/utils/snackbar_util.dart';

class UserRepository implements IUserRepository{
  
  @override
  Future<void> logInUser(String email, String password) async {
     try {
       await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
      } catch (e) {
        print(e.toString());
      }
  }

  @override
  Future<void> logOutUser() async{
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<bool> registerUser({user = UserModel}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: user.email, password: user.password);
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