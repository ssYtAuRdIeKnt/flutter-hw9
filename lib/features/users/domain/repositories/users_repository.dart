import 'package:hw3_app/features/users/domain/entities/user.dart';

/// Domain contract. Data layer implements this interface.
abstract class UsersRepository {
  Future<List<User>> getUsers();
}
