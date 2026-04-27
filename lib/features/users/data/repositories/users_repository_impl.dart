import 'package:hw3_app/features/users/data/datasources/users_remote_data_source.dart';
import 'package:hw3_app/features/users/domain/entities/user.dart';
import 'package:hw3_app/features/users/domain/repositories/users_repository.dart';

/// Data layer implementation of the domain repository.
class UsersRepositoryImpl implements UsersRepository {
  const UsersRepositoryImpl({required this.remoteDataSource});

  final UsersRemoteDataSource remoteDataSource;

  @override
  Future<List<User>> getUsers() async {
    final dtos = await remoteDataSource.fetchUsers();
    return dtos.map((dto) => dto.toEntity()).toList();
  }
}
