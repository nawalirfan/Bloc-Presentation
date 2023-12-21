// import 'package:bloc_state_management/core/network.dart';
// import 'package:bloc_state_management/core/repository/user_repo.dart';
// import 'package:bloc_state_management/pages/user_page.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// void main() {
//   final UserRepository userRepository = UserRepository(
//     userApiClient: UserApiClient(
//       httpClient: http.Client(),
//     ),
//   );
//   runApp(MyApp(
//     userRepository: userRepository,
//   ));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key, required this.userRepository});
//   final UserRepository userRepository;
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyanAccent),
//           useMaterial3: true,
//         ),
//         home: UserPage(
//           userRepository: userRepository,
//         ));
//   }
// }

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyanAccent),
          useMaterial3: true,
        ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 117, 107, 228),
          title: const Text('Testing'),
        ),
        body: Container(
          color: const Color.fromARGB(255, 108, 137, 160),
          child: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                ),
                child: ListTile(
                  leading: Icon(Icons.person), // Person icon
                  title: Text('User'), // Title
                  subtitle: Text('Full Name ${index + 1}'), // Dynamic subtitle using index
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}