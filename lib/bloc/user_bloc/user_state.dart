import 'package:bloc_state_management/models/user_model.dart';

abstract class UserState {
  const UserState([List props = const []]) : super();
}

class UserEmpty extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<Users> user;

  UserLoaded({required this.user}) : super([user]);
}

class UserError extends UserState {
  final String? errorMsg;
  UserError({this.errorMsg});
}