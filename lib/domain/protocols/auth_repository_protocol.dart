abstract interface class AuthRepositoryProtocol {
  Future register(String email, String password);
  Future login(String email, String password);
  Future logout();
}
