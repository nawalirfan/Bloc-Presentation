import 'package:bloc_state_management/bloc/user_bloc/user_event.dart';
import 'package:bloc_state_management/bloc/user_bloc/user_state.dart';
import 'package:bloc_state_management/core/repository/user_repo.dart';
import 'package:bloc_state_management/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserLoading()) {
    on<FetchUser>((event, emit) async {
      await _getUser(emit);
    });
    on<FetchUserMoc>((event, emit) async {
      await _getUserMoc(emit);
    });
  }

  Future<void> _getUser(Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final List<Users> user = await userRepository.getuser();
      emit(UserLoaded(user: user));
    } catch (e) {
      emit(UserError(errorMsg: e.toString()));
    }
  }

  Future<void> _getUserMoc(Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final List<Users> user = await userRepository.getUserMoc();
      emit(UserLoaded(user: user));
    } catch (e) {
      emit(UserError(errorMsg: e.toString()));
    }
  }
}
