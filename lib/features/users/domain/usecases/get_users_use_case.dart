import 'package:hw3_app/features/users/domain/entities/user.dart';
import 'package:hw3_app/features/users/domain/repositories/users_repository.dart';

/// Main business operation: load users from repository.
class GetUsersUseCase {
  const GetUsersUseCase(this._repository);

  final UsersRepository _repository;

  Future<List<User>> call() => _repository.getUsers();
}
