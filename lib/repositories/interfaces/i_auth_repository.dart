abstract class IAuthRepository {
  Future<void> logInUser(String email, String password);
  Future<void> logOutUser();
  Future<bool> registerUser(
      {required String fullName,
      required String email,
      required String password});
}
