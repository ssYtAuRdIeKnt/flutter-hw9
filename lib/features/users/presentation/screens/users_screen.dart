import 'package:flutter/material.dart';
import 'package:hw3_app/features/users/domain/usecases/get_company_stats_use_case.dart';
import 'package:hw3_app/features/users/presentation/bloc/users_bloc.dart';
import 'package:hw3_app/features/users/presentation/screens/company_stats_screen.dart';

/// Main feature screen: users list from API.
class UsersScreen extends StatefulWidget {
  const UsersScreen({
    required this.usersBloc,
    required this.getCompanyStatsUseCase,
    super.key,
  });

  final UsersBloc usersBloc;
  final GetCompanyStatsUseCase getCompanyStatsUseCase;

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    super.initState();
    widget.usersBloc.loadUsers();
  }

  @override
  void dispose() {
    widget.usersBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: StreamBuilder<UsersState>(
        initialData: widget.usersBloc.state,
        stream: widget.usersBloc.stream,
        builder: (context, snapshot) {
          final state = snapshot.data ?? widget.usersBloc.state;

          if (state.status == UsersStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == UsersStatus.error) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Error: ${state.errorMessage}'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: widget.usersBloc.loadUsers,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final users = state.users;
          final stats = widget.getCompanyStatsUseCase(users);

          return Column(
            children: [
              // New feature entry point: open second screen.
              Padding(
                padding: const EdgeInsets.all(12),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => CompanyStatsScreen(stats: stats),
                        ),
                      );
                    },
                    icon: const Icon(Icons.analytics_outlined),
                    label: const Text('Open Company Stats'),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      leading: const Icon(Icons.person_outline),
                      title: Text(user.name),
                      subtitle: Text('${user.email}\n${user.companyName}'),
                      isThreeLine: true,
                      trailing: Text('#${user.id}'),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
