import 'dart:async';

import 'package:hw3_app/features/users/domain/entities/user.dart';
import 'package:hw3_app/features/users/domain/usecases/get_users_use_case.dart';

/// Required 3 UI states.
enum UsersStatus { loading, loaded, error }

class UsersState {
  const UsersState._({
    required this.status,
    this.users = const <User>[],
    this.errorMessage,
  });

  const UsersState.loading() : this._(status: UsersStatus.loading);

  const UsersState.loaded(List<User> users)
    : this._(status: UsersStatus.loaded, users: users);

  const UsersState.error(String message)
    : this._(status: UsersStatus.error, errorMessage: message);

  final UsersStatus status;
  final List<User> users;
  final String? errorMessage;
}

/// Presentation logic component (minimal BLoC with streams).
class UsersBloc {
  UsersBloc({required GetUsersUseCase getUsersUseCase})
    : _getUsersUseCase = getUsersUseCase;

  final GetUsersUseCase _getUsersUseCase;
  final StreamController<UsersState> _stateController =
      StreamController<UsersState>.broadcast();

  UsersState _state = const UsersState.loading();

  Stream<UsersState> get stream => _stateController.stream;
  UsersState get state => _state;

  /// Task part: move loading logic away from UI.
  Future<void> loadUsers() async {
    _emit(const UsersState.loading());
    try {
      final users = await _getUsersUseCase();
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
