import 'package:flutter/material.dart';
import 'package:hw3_app/bloc/users_bloc.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final UsersBloc _bloc = UsersBloc();

  @override
  void initState() {
    super.initState();
    _bloc.loadUsers();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Open API')),
      body: StreamBuilder<UsersState>(
        initialData: _bloc.state,
        stream: _bloc.stream,
        builder: (context, snapshot) {
          final state = snapshot.data ?? _bloc.state;

          // Task part: keep the same 3 UI states (loading, error, loaded).
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
                    onPressed: _bloc.loadUsers,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final users = state.users;

          if (users.isEmpty) {
            return const Center(child: Text('No users found'));
          }

          return ListView.builder(
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
          );
        },
      ),
    );
  }
}
