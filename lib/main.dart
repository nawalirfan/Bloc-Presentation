import 'package:bloc_state_management/core/network.dart';
import 'package:bloc_state_management/core/repository/user_repo.dart';
import 'package:bloc_state_management/pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  final UserRepository userRepository = UserRepository(
    userApiClient: UserApiClient(
      httpClient: http.Client(),
    ),
  );
  runApp(MyApp(
    userRepository: userRepository,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.userRepository});
  final UserRepository userRepository;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyanAccent),
          useMaterial3: true,
        ),
        home: UserPage(
          userRepository: userRepository,
        ));
  }
}