part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final UserModel userModel;

  UserLoadedState(this.userModel);
}

class UserErrorState extends UserState {
  final String error;

  UserErrorState(this.error);
}
