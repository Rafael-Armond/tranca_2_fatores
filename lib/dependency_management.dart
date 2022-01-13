import 'package:get/instance_manager.dart';
import 'package:tranca_2_fatores/controllers/authentication_controller.dart';
import 'package:tranca_2_fatores/repositories/implementations/user_repository.dart';

void dependencyManagement() {
  // Repositories
  Get.put(UserRepository());

  // Controllers (Stores)
  Get.put(AuthenticationController(userRepository: Get.find<UserRepository>()));
}
