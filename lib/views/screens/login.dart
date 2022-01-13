import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranca_2_fatores/controllers/authentication_controller.dart';
import 'package:tranca_2_fatores/utils/snackbar_util.dart';
import 'package:tranca_2_fatores/views/components/custom_text_form.dart';
import 'package:tranca_2_fatores/views/components/loading_progress_indicator.dart';
import 'package:tranca_2_fatores/views/screens/home.dart';
import 'package:tranca_2_fatores/views/screens/register.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final AuthenticationController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    final screenWidth = Get.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
                padding: EdgeInsets.only(top: screenWidth * 0.1),
                child: Obx(
                  () => ElevatedButton(
                    child: const Text('Entrar'),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      shadowColor: Colors.black,
                    ),
                    onPressed: authController.email.value.isNotEmpty &&
                            authController.password.value.isNotEmpty
                        ? () async {
                            CustomLoadingProgressIndicator.show(context);
                            try {
                              await authController.signIn();
                              Get.off(() => HomeView());
                            } catch (e) {
                              print(e.toString());
                              SnackbarUtil.showErrorSnackbar(
                                  title: 'Erro ao tentar logar',
                                  message: 'Confira suas credenciais');
                            } finally {
                              CustomLoadingProgressIndicator.hide();
                            }
                          }
                        : null,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenWidth * 0.025),
                child: TextButton(
                  child: const Text('Cadastrar'),
                  onPressed: () => Get.to(() => RegisterView()),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance.collection('teste2').add({
            'teste': 'teste',
          });
        },
      ),
    );
  }
}
