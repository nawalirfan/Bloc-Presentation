
import 'package:bloc_state_management/core/network.dart';
import 'package:bloc_state_management/models/user_model.dart';

class UserRepository {
  final UserApiClient userApiClient;

  UserRepository({required this.userApiClient});

  Future<List<Users>> getuser() async {
    return userApiClient.fetchuser();
  }
  Future<List<Users>> getUserMoc() async {
    return userApiClient.fetchUserMoc();
  }
}