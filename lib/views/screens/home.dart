import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranca_2_fatores/controllers/authentication_controller.dart';
import 'package:tranca_2_fatores/utils/snackbar_util.dart';
import 'package:tranca_2_fatores/views/screens/login.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final AuthenticationController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    final screenWidth = Get.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
        leading: IconButton(
          padding: EdgeInsets.only(left: screenWidth * 0.025),
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
          onPressed: () {
            try {
              authController.logOut();
              Get.off(
                () => LoginView(),
                popGesture: true,
              );
            } on FirebaseAuthException catch (e) {
              SnackbarUtil.showErrorSnackbar(
                  title: 'Erro ao deslogar', message: '$e');
            }
          },
        ),
      ),
      body: Center(
        child: Text('Home ${authController.email}'),
      ),
    );
  }
}
