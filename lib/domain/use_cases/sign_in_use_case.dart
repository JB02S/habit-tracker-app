import 'package:task_manager_app/domain/repositories/user_repository.dart';
import 'package:task_manager_app/domain/entities/user.dart';

class SignInUseCase {
  final UserRepository userRepository;

  SignInUseCase(this.userRepository);

  Future<User> signIn(String email, String password) async {
    // You might want to add validation or error handling here
    return await userRepository.signIn(email, password);
  }
}
// TODO Implement this library.