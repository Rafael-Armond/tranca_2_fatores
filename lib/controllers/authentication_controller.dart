import 'package:get/get.dart';
import 'package:tranca_2_fatores/models/user.dart';
import 'package:tranca_2_fatores/repositories/implementations/auth_repository.dart';
import 'package:tranca_2_fatores/utils/snackbar_util.dart';

class AuthenticationController extends GetxController {
  final AuthRepository userRepository;
  // final UserModel userModel;

  AuthenticationController({
    required this.userRepository,
  });

  Rx<String> fullName = ''.obs;
  Rx<String> email = ''.obs;
  Rx<String> password = ''.obs;
  Rx<String> confirmPassword = ''.obs;

  clearController() {
    fullName.value = '';
    email.value = '';
    password.value = '';
    confirmPassword.value = '';
  }

  Future<void> logInUser() async {
    await userRepository.logInUser(email.value, password.value);
  }

  Future<bool> registerUser() async {
    if (password != confirmPassword) {
      SnackbarUtil.showErrorSnackbar(
        title: 'Senhas não conferem',
        message: 'As senhas não conferem, por favor, verifique.',
      );

      return false;
    }

    try {
      bool? isUserRegistered = await userRepository.registerUser(
          fullName: fullName.value,
          email: email.value,
          password: password.value);
      if (isUserRegistered) {
        clearController();
        return isUserRegistered;
      }
    } catch (e) {
      print(e);
      SnackbarUtil.showErrorSnackbar(
        title: 'Erro ao registrar usuário',
        message:
            'Ocorreu um erro ao registrar o usuário, por favor, tente novamente.',
      );
    }

    return false;
  }

  Future<void> logOut() async {
    try {
      await userRepository.logOutUser();
    } catch (e) {
      SnackbarUtil.showErrorSnackbar(
        title: 'Erro ao deslogar',
        message: 'Ocorreu um erro ao deslogar, por favor, tente novamente.',
      );
    }
  }
}
