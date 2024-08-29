import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/features/user/UserApp/lasthome.dart';
import 'package:flutter_application_1/features/user/UserApp/login1.dart';
import 'package:flutter_application_1/core/cubit/user_cubit.dart';
import 'package:flutter_application_1/core/cubit/user_state.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/features/group/map/mapp.dart';
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
            final data = state.data;

            prefs.setString("idGroup", data['id'].toString());

            if (data['user']['group_status'] == 0) {
              _lights = false;
            } else {
              _lights = true;
            }

            return SingleChildScrollView(
              child: Stack(
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
                            }),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 105, left: 0, right: 0),
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: Colors.black),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          20), // نفس قيمة borderRadius هنا
                      child: MapScreen(
                        latitude: double.parse(data['latitude']),
                        longitude: double.parse(data['longitude']),
                        myLocation: false,
                        add: false,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 380, left: 0, right: 0),
                    width: double.infinity,
                    height: 250,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("الهاتف : ${data['phone_number']} "),
                        Text("الاسم :  ${data['name']}"),
                        Text("الوصف : ${data['details']}"),
                        const SizedBox(
                            height:
                                16), // لإضافة بعض المساحة بين النصوص والأزرار
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                context
                                    .read<UserCubit>()
                                    .agree(data['id'].toString(), context);
                              },
                              child: const Text("قبول"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                context
                                    .read<UserCubit>()
                                    .refuse(data['id'].toString(), context);
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
// Column(
//               children: [
//                 Text('ID: ${data['id']}'),
//                 Text('Phone Number: ${data['phone_number']}'),
//                 Text('Name: ${data['name']}'),
//                 Text('Latitude: ${data['latitude']}'),
//                 Text('Longitude: ${data['longitude']}'),
//                 Text('Details: ${data['details']}'),
//               ],
//             );


/*

 child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('User ID: ${user['id']}'),
                  Text('Job ID: ${user['job_id']}'),
                  Text('Car Number: ${user['car_number']}'),
                  Text('Site ID: ${user['site_id']}'),
                  Text('Group Status: ${user['group_status']}'),
                  Text('Created At: ${user['created_at']}'),
                  Text('Updated At: ${user['updated_at']}'),
                ],
              ),
            );

*/