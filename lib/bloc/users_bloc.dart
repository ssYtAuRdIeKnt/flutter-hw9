import 'dart:async';

import 'package:hw3_app/models/user_profile.dart';
import 'package:hw3_app/services/user_api_service.dart';

enum UsersStatus { loading, loaded, error }

class UsersState {
  const UsersState._({
    required this.status,
    this.users = const <UserProfile>[],
    this.errorMessage,
  });

  const UsersState.loading() : this._(status: UsersStatus.loading);

  const UsersState.loaded(List<UserProfile> users)
    : this._(status: UsersStatus.loaded, users: users);

  const UsersState.error(String message)
    : this._(status: UsersStatus.error, errorMessage: message);

  final UsersStatus status;
  final List<UserProfile> users;
  final String? errorMessage;
}

class UsersBloc {
  UsersBloc({UserApiService? service}) : _service = service ?? UserApiService();

  final UserApiService _service;
  final StreamController<UsersState> _stateController =
      StreamController<UsersState>.broadcast();

  UsersState _state = const UsersState.loading();

  Stream<UsersState> get stream => _stateController.stream;
  UsersState get state => _state;

  // Task part: all async/business logic is in BLoC, not in UI.
  Future<void> loadUsers() async {
    _emit(const UsersState.loading());
    try {
      final users = await _service.fetchUsers();
      _emit(UsersState.loaded(users));
    } catch (error) {
      _emit(UsersState.error(error.toString()));
    }
  }

  void _emit(UsersState state) {
    _state = state;
    if (!_stateController.isClosed) {
      _stateController.add(state);
    }
  }

  void dispose() {
    _stateController.close();
  }
}
