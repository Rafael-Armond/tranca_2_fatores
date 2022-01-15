import 'package:get/instance_manager.dart';
import 'package:tranca_2_fatores/controllers/authentication_controller.dart';
import 'package:tranca_2_fatores/models/user.dart';
import 'package:tranca_2_fatores/repositories/implementations/auth_repository.dart';

void dependencyManagement() {
  // Repositories
  Get.put(AuthRepository());

  // Controllers (Stores)
  Get.put(AuthenticationController(
      userRepository: Get.find<AuthRepository>(), userModel: UserModel()));
}
