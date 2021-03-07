import 'package:fluchat/data/auth_repository.dart';
import 'package:fluchat/data/stream_api_repository.dart';

class LogoutUseCase {
  LogoutUseCase(this.streamApiRepository, this.authRepository);
  final StreamApiRepository streamApiRepository;
  final AuthRepository authRepository;

  Future<void> logout() async {
    await streamApiRepository.logout();
    await authRepository.logout();
  }
}
