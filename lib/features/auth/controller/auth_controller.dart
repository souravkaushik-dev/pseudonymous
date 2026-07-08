import '../data/auth_repository.dart';

class AuthController {
  Future<void> login({
    required String email,
    required String password,
  }) async {
    await AuthRepository.login(
      email: email,
      password: password,
    );
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    await AuthRepository.register(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    await AuthRepository.logout();
  }

  Future<void> forgotPassword(
      String email,
      ) async {
    await AuthRepository.forgotPassword(
      email,
    );
  }
}