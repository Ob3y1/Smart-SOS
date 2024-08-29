import 'package:app_group/core/api/dio_consumer.dart';
import 'package:app_group/core/cubit/user_cubit.dart';
import 'package:app_group/features/user/UserApp/lasthome.dart';
import 'package:app_group/features/user/UserApp/login1.dart';
import 'package:app_group/features/user/UserApp/order.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
      home: prefs.getString("tokenGroup") == null
          ? const Login1Screen()
          : const order(),
    );
  }
}
