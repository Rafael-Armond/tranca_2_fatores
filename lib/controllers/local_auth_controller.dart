import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthController extends GetxController {
  final LocalAuthentication localAuth = LocalAuthentication();
  bool? canCheckBiometrics;
  RxList<BiometricType>? availableBiometrics = <BiometricType>[].obs;
  RxBool isAuthenticated = false.obs;
  RxString authorized = 'Not Authorized'.obs;

  Future<bool> get isDeviceSupported => localAuth.canCheckBiometrics;
  Future<List<BiometricType>> get getAvailableBiometrics =>
      localAuth.getAvailableBiometrics();

  Future<bool> authenticate() async {
    try {
      final bool authenticated = await localAuth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        useErrorDialogs: true,
        stickyAuth: true,
      );
      isAuthenticated.value = authenticated;
      return authenticated;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }
}
