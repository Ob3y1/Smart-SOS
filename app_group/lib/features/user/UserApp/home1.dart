import 'package:app_group/core/cubit/user_cubit.dart';
import 'package:app_group/core/cubit/user_state.dart';
import 'package:app_group/features/user/UserApp/card_widget_home1.dart';
import 'package:app_group/features/user/home.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:flutter_bloc/flutter_bloc.dart'; // استيراد Dio

class Home1 extends StatefulWidget {
  const Home1({super.key});

  @override
  State<Home1> createState() => _HomeState();
}

class _HomeState extends State<Home1> {
  Color primaryColor = const Color.fromARGB(228, 0, 0, 0);
  Color accentColor = const Color(0xFFD3A984);
  Color textColor = const Color.fromARGB(255, 255, 255, 255);
  Color buttonColor = const Color.fromARGB(255, 7, 7, 8);
  Color backgroundColor = const Color(0xFFF5F5F5);
  Color containerColor = const Color.fromARGB(255, 33, 32, 32);

  bool step1 = false;
  bool step2 = false;
  bool step3 = false;
  bool activeTextFromField = false;
  bool showContent = true; // Flag to control visibility of content

  @override
  void initState() {
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
              fontSize: 25,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              wordSpacing: 4,
              color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserHomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserHomeLoaded) {
            if (state.userHome.requests?.length == 0) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Home(),
                  ));
            }
            return ListView.builder(
              itemCount: state.userHome.requests?.length ?? 0,
              itemBuilder: (context, index) {
                final request = state.userHome.requests![index];
                print(request.requestStatus);
                return CardWidgetHome1(
                  activeTextFromField: activeTextFromField,
                  type: request.job ?? "",
                  carNumber: request.carNumber ?? "",
                  site: request.site ?? "",
                  requestStatus: request.requestStatus ?? 0,
                );
              },
            );
          } else if (state is UserHomeError) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const Center(child: Text('Please wait...'));
        },
      ),
    );
  }
}
