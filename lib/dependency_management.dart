import 'package:get/instance_manager.dart';
import 'package:tranca_2_fatores/repositories/implementations/user_repository.dart';

void dependencyManagement() {
  // Repositories
  Get.put(UserRepository());
  
  // Controllers (Stores)
  
}