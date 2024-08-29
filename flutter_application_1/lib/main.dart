import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/user/UserApp/home1.dart';
import 'package:flutter_application_1/features/user/home.dart';
import 'package:flutter_application_1/core/api/dio_consumer.dart';
import 'package:flutter_application_1/core/cubit/user_cubit.dart';
import 'package:flutter_application_1/features/user/login/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(
          create: (_) => UserCubit(DioConsumer(dio: Dio())),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          prefs.getString("token") == null ? const LoginScreen() : const Home(),
    );
  }
}
