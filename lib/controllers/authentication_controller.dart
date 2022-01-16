import 'package:get/get.dart';
import 'package:tranca_2_fatores/controllers/local_auth_controller.dart';
import 'package:tranca_2_fatores/repositories/implementations/auth_repository.dart';
import 'package:tranca_2_fatores/utils/snackbar_util.dart';

class AuthenticationController extends GetxController {
  final AuthRepository userRepository;
  final LocalAuthController localAuthController;

  AuthenticationController({
    required this.userRepository,
    required this.localAuthController,
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

    // Impedindo que o usuário seja cadastrado quando seu dispositivo não tiver alguma forma de autenticação local
    var localAuthList = await localAuthController.getAvailableBiometrics;
    if (localAuthList.isEmpty) {
      SnackbarUtil.showInfoSnackbar(
        title: 'Autenticação local não disponível',
        message:
            'Não foi possível cadastrar o usuário, pois não há nenhuma forma de autenticação local disponível.',
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
      await userRepository.logOutUser(email.value);
    } catch (e) {
      SnackbarUtil.showErrorSnackbar(
        title: 'Erro ao deslogar',
        message: 'Ocorreu um erro ao deslogar, por favor, tente novamente.',
      );
    }
  }
}
