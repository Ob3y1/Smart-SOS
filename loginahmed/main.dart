// ignore_for_file: prefer_const_constructors



import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Siginup.dart';
// ignore: unused_import
import 'package:flutter_application_1/pages/Siginup1.dart';
import 'package:flutter_application_1/pages/edit.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_application_1/pages/otp.dart';


import 'package:flutter_application_1/pages/page1.dart';
import 'package:flutter_application_1/pages/page2.dart';
import 'package:flutter_application_1/pages/page3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      initialRoute: '/eight',
       
      
      routes: {
        '/first':(context) => const Page_1(),
         '/second':(context) => const Page_2(),
          '/third':(context) => const Page_3(),
            '/fore':(context) => const Siginup(),
             '/five':(context) => Signup1(),
               '/six':(context) => const Otp(),
                 '/seven':(context) => const Login(),
                     '/eight':(context) => const Home(phoneNumber: '', password: '',),
        '/ten':(context) => const Edit(),
      },
    );
    

  }

}
