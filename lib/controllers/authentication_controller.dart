import 'package:get/get.dart';
import 'package:tranca_2_fatores/repositories/implementations/user_repository.dart';
import 'package:tranca_2_fatores/utils/snackbar_util.dart';

class AuthenticationController extends GetxController {
  final UserRepository userRepository;

  AuthenticationController({
    required this.userRepository,
  });

  Rx<String> email = ''.obs;
  Rx<String> password = ''.obs;
  Rx<String> confirmPassword = ''.obs;

  clearController() {
    email.value = '';
    password.value = '';
    confirmPassword.value = '';
  }

  Future<void> signIn() async {
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
      bool? isUserRegistered =
          await userRepository.registerUser(email.value, password.value);
      if (isUserRegistered != null) {
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