import 'package:get/instance_manager.dart';
import 'package:tranca_2_fatores/controllers/authentication_controller.dart';
import 'package:tranca_2_fatores/repositories/implementations/auth_repository.dart';
import 'package:tranca_2_fatores/repositories/implementations/log_repository.dart';

void dependencyManagement() {
  // Repositories
  Get.put(LogRepository());
  Get.put(AuthRepository(Get.find<LogRepository>()));

  // Controllers (Stores)
  Get.put(AuthenticationController(userRepository: Get.find<AuthRepository>()));
}
