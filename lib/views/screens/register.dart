import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranca_2_fatores/controllers/authentication_controller.dart';
import 'package:tranca_2_fatores/utils/snackbar_util.dart';
import 'package:tranca_2_fatores/views/components/custom_text_form.dart';

class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);

  final AuthenticationController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    final screenWidth = Get.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: CustomTextForm(
                  label: 'Nome completo',
                  onChanged: (String text) =>
                      authController.fullName.value = text,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: CustomTextForm(
                  label: 'E-mail',
                  onChanged: (String text) => authController.email.value = text,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: CustomTextForm(
                  label: 'Senha',
                  isObscured: true,
                  onChanged: (String text) =>
                      authController.password.value = text,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: CustomTextForm(
                  label: 'Confirme sua senha',
                  isObscured: true,
                  onChanged: (String text) =>
                      authController.confirmPassword.value = text,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenWidth * 0.1),
                child: Obx(
                  () => ElevatedButton(
                    child: const Text('Registrar'),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      shadowColor: Colors.black,
                    ),
                    onPressed: authController.email.value.isNotEmpty &&
                            authController.password.value.isNotEmpty
                        ? () async {
                            try {
                              await authController.registerUser();
                            } on FirebaseAuthException catch (_) {
                              SnackbarUtil.showErrorSnackbar(
                                title: 'Erro ao registrar usuário',
                                message:
                                    'Ocorreu um erro ao registrar o usuário, por favor, tente novamente.',
                              );
                            }
                          }
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
