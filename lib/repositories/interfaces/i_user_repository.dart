abstract class IUserRepository {
  Future<void> logInUser(String email, String password);
  Future<void> logOutUser();
  Future<bool> registerUser(String email, String password);
}
