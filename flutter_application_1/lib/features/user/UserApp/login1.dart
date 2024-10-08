import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/user/UserApp/home1.dart';
import 'package:flutter_application_1/features/user/UserApp/order.dart';
import 'package:flutter_application_1/core/api/dio_consumer.dart';
import 'package:flutter_application_1/core/cubit/user_cubit.dart';
import 'package:flutter_application_1/core/cubit/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class Login1Screen extends StatelessWidget {
  const Login1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => UserCubit(DioConsumer(dio: Dio())),
        child: SafeArea(
            child: BlocConsumer<UserCubit, UserState>(
                listener: (context, success) {
          if (success is SignIn1Success) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("success"),
            ));

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const order(),
              ),
              (route) => false,
            );
          } else if (success is SignIn1Failure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(success.message),
            ));
          }
        }, builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: const Text(
                "Login",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    wordSpacing: 4,
                    color: Colors.white),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 400,
                    margin: const EdgeInsets.only(top: 50),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          opacity: 0.1,
                          image: AssetImage(
                            "images/ALSHA.png",
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 400,
                        ),
                        const Text(
                            "Please Login To Continue With Your Account:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              wordSpacing: 4,
                            )),
                        const SizedBox(
                          height: 50,
                        ),
                        component1(Icons.car_crash, 'Number Your Car...', false,
                            context.read<UserCubit>().carController),
                        const SizedBox(
                          height: 20,
                        ),
                        component1(Icons.lock_outline, 'Password...', true,
                            context.read<UserCubit>().carpasswordController),
                        const SizedBox(
                          height: 50,
                        ),
                        state is SignIn1Loading
                            ? const CircularProgressIndicator()
                            : component2(
                                'Login',
                                2,
                                () {
                                  if (context
                                          .read<UserCubit>()
                                          .carController
                                          .text
                                          .isEmpty ||
                                      context
                                          .read<UserCubit>()
                                          .carpasswordController
                                          .text
                                          .isEmpty) {
                                    var snackBar = const SnackBar(
                                        content: Text('يرجى ملئ الحقول'));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    if (context
                                            .read<UserCubit>()
                                            .carpasswordController
                                            .text
                                            .length <
                                        4) {
                                      var snackBar = const SnackBar(
                                          content: Text(
                                              'يرجى كتابة كلمة السر بطول ال 8 على الاقل '));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else {
                                      context.read<UserCubit>().signIn1();
                                    }
                                  }
                                },
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        })));
  }

  Widget component1(IconData icon, String hintText, bool isPassword,
      TextEditingController? controller) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 0, 0, 0).withOpacity(.3),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          controller: controller,
          style: TextStyle(
              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(.8),
              fontWeight: FontWeight.bold),
          cursorColor: const Color.fromARGB(255, 0, 0, 0),
          obscureText: isPassword,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(.7),
            ),
            border: InputBorder.none,
            hintMaxLines: 1,
            hintText: hintText,
            hintStyle: TextStyle(
                fontSize: 14,
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(.5)),
          ),
        ),
      ),
    );
  }

  Widget component2(String string, double width, VoidCallback voidCallback) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: voidCallback,
        child: Container(
          height: 40,
          width: 200,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            string,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
