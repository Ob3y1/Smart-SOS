import 'package:app_group/core/cubit/user_cubit.dart';
import 'package:app_group/core/cubit/user_state.dart';
import 'package:app_group/features/group/map/mapp.dart';
import 'package:app_group/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: camel_case_types
class lasthome extends StatefulWidget {
  const lasthome({
    super.key,
  });

  @override
  OnbordingState createState() => OnbordingState();
}

class OnbordingState extends State<lasthome> {
  bool _isChecked = false;
  @override
  void initState() {
    context.read<UserCubit>().showInfo(prefs.getString("idGroup") ?? "0");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Smart SOS",
          style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              wordSpacing: 4,
              color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is InfoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is InfoLoaded) {
            var data = state.data;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 20),
                    width: double.infinity,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 0, left: 0, right: 0),
                    width: double.infinity,
                    height: 250,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text('اسم الشخص : ${data['name']}'),
                          Text('رقم الهاتف : ${data['phone_number']}'),
                          Text('الجنس : ${data['gender']}'),
                          Text('العمر : ${data['age']}'),
                          Text('تفاصيل الحادثة : ${data['details']}'),
                          Text('رقم الطلب : ${data['id']}'),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20, left: 0, right: 0),
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: Colors.black),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: MapScreen(
                        myLocation: false,
                        latitude: double.parse(data['latitude']),
                        longitude: double.parse(data['longitude']),
                        add: false,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  value: _isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isChecked = value!;
                                      print(_isChecked);
                                    });
                                  },
                                  activeColor: Colors.green,
                                ),
                                const Text("إشعار كاذب"),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                print(data['id'].toString());
                                context
                                    .read<UserCubit>()
                                    .support(data['id'].toString());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black, // لون الزر
                              ),
                              child: const Text(
                                'نحتاج الى دعم',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_isChecked) {
                                context
                                    .read<UserCubit>()
                                    .finish(1, data['id'], context);
                              } else {
                                context
                                    .read<UserCubit>()
                                    .finish(0, data['id'], context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                            child: const Text(
                              'تم الانتهاء',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is InfoError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is InfoSupport) {
            print("InfoSupport");
            return AlertDialog(
              content: Text(state.message),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => lasthome(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ],
            );
            // // Schedule the showing of the SnackBar after the current frame
            // SchedulerBinding.instance.addPostFrameCallback((_) {
            //   showSnackBar(context, state.message);
            // });
            // return Container();
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  void showSnackBar(BuildContext context, String ms) {
    var snackBar = SnackBar(
      content: Text(ms),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
