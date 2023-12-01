
import 'package:bloc_state_management/core/network.dart';
import 'package:bloc_state_management/models/product_model.dart';
import 'package:bloc_state_management/models/user_model.dart';

class UserRepository {
  final UserApiClient userApiClient;

  UserRepository({required this.userApiClient});

  Future<List<Products>> getuser() async {
    return userApiClient.fetchuser();
  }
  Future<List<Products>> getUserMoc() async {
    return userApiClient.fetchUserMoc();
  }
}