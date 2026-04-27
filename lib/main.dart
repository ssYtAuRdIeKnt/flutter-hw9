import 'package:flutter/material.dart';
import 'package:hw3_app/features/users/data/datasources/users_remote_data_source.dart';
import 'package:hw3_app/features/users/data/repositories/users_repository_impl.dart';
import 'package:hw3_app/features/users/domain/usecases/get_company_stats_use_case.dart';
import 'package:hw3_app/features/users/domain/usecases/get_users_use_case.dart';
import 'package:hw3_app/features/users/presentation/bloc/users_bloc.dart';
import 'package:hw3_app/features/users/presentation/screens/users_screen.dart';

void main() {
  // Task part: dependency wiring for layered architecture.
  final dataSource = UsersRemoteDataSource();
  final repository = UsersRepositoryImpl(remoteDataSource: dataSource);
  final getUsersUseCase = GetUsersUseCase(repository);
  final getCompanyStatsUseCase = GetCompanyStatsUseCase();
  final usersBloc = UsersBloc(getUsersUseCase: getUsersUseCase);

  runApp(
    Project10App(
      usersBloc: usersBloc,
      getCompanyStatsUseCase: getCompanyStatsUseCase,
    ),
  );
}

class Project10App extends StatelessWidget {
  const Project10App({
    required this.usersBloc,
    required this.getCompanyStatsUseCase,
    super.key,
  });

  final UsersBloc usersBloc;
  final GetCompanyStatsUseCase getCompanyStatsUseCase;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UsersScreen(
        usersBloc: usersBloc,
        getCompanyStatsUseCase: getCompanyStatsUseCase,
      ),
    );
  }
}
