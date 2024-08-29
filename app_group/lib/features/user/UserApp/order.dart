import 'package:app_group/core/cubit/user_cubit.dart';
import 'package:app_group/core/cubit/user_state.dart';
import 'package:app_group/features/group/map/mapp.dart';
import 'package:app_group/features/user/UserApp/login1.dart';
import 'package:app_group/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: camel_case_types
class order extends StatefulWidget {
  const order({super.key});

  @override
  OnbordingState createState() => OnbordingState();
}

class OnbordingState extends State<order> {
  bool _lights = false;
  Color primaryColor = const Color.fromARGB(228, 0, 0, 0);
  Color accentColor = const Color(0xFFD3A984);
  Color textColor = const Color.fromARGB(255, 255, 255, 255);
  Color buttonColor = const Color.fromARGB(255, 7, 7, 8);
  Color backgroundColor = const Color(0xFFF5F5F5);
  Color containerColor = const Color.fromARGB(255, 33, 32, 32);
  void showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(Icons.logout),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                // Perform logout action here
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Login1Screen()));
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    context.read<UserCubit>().getRequestNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromRGBO(0, 0, 0, 1),
          ),
          backgroundColor: Colors.black,
        ),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is RequestNotificationLoadedNot) {
            final data = state.data;
            print(data['user']['group_status']);
            if (data['user']['group_status'] == 0) {
              _lights = false;
            } else {
              _lights = true;
            }
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  width: double.infinity,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: showLogoutDialog,
                        icon: const Icon(Icons.logout),
                        color: backgroundColor,
                      ),
                      Switch.adaptive(
                          value: _lights,
                          onChanged: (bool value) {
                            setState(() {
                              _lights = value;
                              context.read<UserCubit>().changeStatus();
                            });
                          }),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "رقم السيارة:${data['user']['car_number']}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 300),
                  child: Text("لا يوجد طلبات حاليا"),
                ),
              ],
            );
          } else if (state is RequestNotificationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RequestNotificationLoaded) {
            final user = state.data["user"];
            _lights = user['group_status'] != 0;
            if (state.data["message"] == "لا يوجد طلبات حاليا") {
              return Column(children: [
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  width: double.infinity,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: showLogoutDialog,
                        icon: const Icon(Icons.logout),
                        color: backgroundColor,
                      ),
                      Switch.adaptive(
                        value: _lights,
                        onChanged: (bool value) {
                          setState(() {
                            context.read<UserCubit>().changeStatus();
                            _lights = value;
                          });
                        },
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "رقم السيارة: ${user['car_number']}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 300),
                  child: Text("لا يوجد طلبات حاليا"),
                ),
              ]);
            } else {
              final List<dynamic> requests =
                  state.data["requests"]; // Fetch the list of requests
              final user = state.data["user"]; // Fetch the user data

              _lights = user['group_status'] != 0;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 20),
                      width: double.infinity,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: showLogoutDialog,
                            icon: const Icon(Icons.logout),
                            color: backgroundColor,
                          ),
                          Switch.adaptive(
                            value: _lights,
                            onChanged: (bool value) {
                              setState(() {
                                context.read<UserCubit>().changeStatus();
                                _lights = value;
                              });
                            },
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              "رقم السيارة: ${user['car_number']}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Iterate through the list of requests and display each one
                    for (var request in requests)
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("الاسم: ${request['name']}",
                                style: const TextStyle(fontSize: 16)),
                            Text("الهاتف: ${request['phone_number']}",
                                style: const TextStyle(fontSize: 16)),
                            Text("الوصف: ${request['details']}",
                                style: const TextStyle(fontSize: 16)),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              height: 200,
                              child: MapScreen(
                                latitude: double.parse(request['latitude']),
                                longitude: double.parse(request['longitude']),
                                myLocation: false,
                                add: false,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    prefs.setString(
                                        "idGroup", request['id'].toString());
                                    context.read<UserCubit>().agree(
                                        request['id'].toString(), context);
                                  },
                                  child: const Text("قبول"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    prefs.setString(
                                        "idGroup", request['id'].toString());
                                    context.read<UserCubit>().refuse(
                                        request['id'].toString(), context);
                                  },
                                  child: const Text("رفض"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            }
          } else if (state is RequestNotificationError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('Start by fetching data'));
          }
        },
      ),
    );
  }
}
