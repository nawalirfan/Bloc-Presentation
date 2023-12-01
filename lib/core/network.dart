import 'dart:convert';
import 'dart:ffi';
import "package:http/http.dart" as http;
import 'package:bloc_state_management/models/user_model.dart';

class UserApiClient {
  final http.Client httpClient;

  UserApiClient({required this.httpClient});

  Future<List<Users>> fetchuser() async {
    final userResponse = await httpClient.get(Uri.parse(Endpoints.userUrl));

    if (userResponse.statusCode != 200) {
      throw Exception('error getting user for location');
    }
    List<dynamic> parsedListJson = jsonDecode(userResponse.body);
    List<Users> itemsList = List<Users>.from(
        parsedListJson.map<Users>((dynamic i) => Users.fromJson(i)));
    return itemsList;
  }

  Future<List<Users>> fetchUserMoc() async {
    return [Users(completed: true, id: 12, title: 'Mock data', userId: 12)];
  }
}

class Endpoints {
  static const baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String userUrl = '$baseUrl/todos';
}
