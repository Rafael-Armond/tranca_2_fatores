import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranca_2_fatores/controllers/authentication_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final AuthenticationController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Text('Home ${authController.email}'),
      ),
    );
  }
}
