import 'package:bloc_state_management/bloc/user_bloc/user_bloc.dart';
import 'package:bloc_state_management/bloc/user_bloc/user_event.dart';
import 'package:bloc_state_management/bloc/user_bloc/user_state.dart';
import 'package:bloc_state_management/core/repository/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPage extends StatefulWidget {
  final UserRepository userRepository;

  const UserPage({Key? key, required this.userRepository}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late UserBloc _userBloc;

  @override
  void initState() {
    super.initState();
    _userBloc = UserBloc(userRepository: widget.userRepository);
    _userBloc.add(const FetchUser());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter user'),
        actions: const <Widget>[],
      ),
      body: Center(
        child: BlocBuilder(
          bloc: _userBloc,
          builder: (_, UserState state) {
            if (state is UserEmpty) {
              return const Center(child: Text('Empty state'));
            }
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is UserLoaded) {
              return ListView.builder(
                itemCount: state.user.length,
                itemBuilder: (BuildContext context, int i) {
                  var obj = state.user[i];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(obj.title ?? '--'),
                      subtitle: Text(obj.userId.toString()),
                    ),
                  );
                },
              );
            }
            if (state is UserError) {
              return const Text(
                'Something went wrong!',
                style: TextStyle(color: Colors.red),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _userBloc.close();
    super.dispose();
  }
}

class Location extends StatelessWidget {
  final String location;

  const Location({required Key key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      location,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}

class LastUpdated extends StatelessWidget {
  final DateTime dateTime;

  const LastUpdated({required Key key, required this.dateTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Updated: ${TimeOfDay.fromDateTime(dateTime).format(context)}',
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w200,
        color: Colors.white,
      ),
    );
  }
}
