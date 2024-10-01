import 'package:task_manager_app/domain/entities/user.dart';

abstract class UserRepository {
  Future<User> signIn(String email, String password);
  Future<void> signOut();
// Add other methods like register, get user details, etc.
}
