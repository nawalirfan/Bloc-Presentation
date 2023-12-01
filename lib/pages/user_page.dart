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
              return Padding(
                padding: const EdgeInsets.only(top: 10.0, right: 5, left: 5),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 11.0 / 6.0,
                  ),
                  itemCount: state.user.length,
                  itemBuilder: (context, index) {
                    var item = state.user[index];
                    return InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          context: context,
                          builder: (context) {
                            return SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Container(
                                color: const Color(0x99A4EBEE),
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: item.images.map((image) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.network(
                                              image,
                                              width: 100,
                                              height: 200,
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    Text(
                                      item.title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(item.description.toString()),
                                    Text('\$ ${item.price.toString()}'),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                ),
                                                Text(item.rating.toString()),
                                              ],
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(item.discountPercentage
                                                    .toString()),
                                                const Icon(
                                                  Icons.discount,
                                                  color: Colors.blue,
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Material(
                        elevation: 10,
                        child: Card(
                          color: const Color.fromARGB(255, 157, 245, 240),
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            children: [
                              if (item.images.isNotEmpty &&
                                  item.images[0] is String)
                                Image.network(
                                  item.images[0],
                                  height: 100,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      children: [
                                        Text(item.title),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text('${item.price}  USD'),
                                      const Icon(Icons.visibility),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${item.description}',
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
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
