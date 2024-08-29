import 'package:app_group/core/api/dio_consumer.dart';
import 'package:app_group/core/cubit/user_cubit.dart';
import 'package:app_group/core/cubit/user_state.dart';
import 'package:app_group/features/group/signup/Sign_Up.dart';
import 'package:app_group/features/user/home.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscured = true;

  void _toggleObscureText() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserCubit(DioConsumer(dio: Dio())),
      child: SafeArea(
        child: BlocConsumer<UserCubit, UserState>(
          listener: (context, success) {
            if (success is SignInSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("success"),
              ));

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
                (route) => false,
              );
            } else if (success is SignInFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(success.message),
              ));
            }
          },
          builder: (context, state) {
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
                      margin: const EdgeInsets.only(top: 0),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          opacity: 0.1,
                          image: AssetImage(
                            "images/ALSHA.png",
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 350,
                          ),
                          const Text(
                            "Please Login To Continue With Your Account:",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              wordSpacing: 1,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          component1(
                            Icons.phone,
                            'Number Phone...',
                            false,
                            context.read<UserCubit>().controllerPhone,
                            TextInputType.number,
                            [
                              FilteringTextInputFormatter.allow(
                                RegExp("[0-9]"),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          component1(
                            Icons.lock_outline,
                            'Password...',
                            _isObscured,
                            context.read<UserCubit>().passwordController,
                            TextInputType.text,
                            [],
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscured
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: _toggleObscureText,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          state is SignInLoading
                              ? const CircularProgressIndicator()
                              : component2(
                                  'Login',
                                  2,
                                  () {
                                    if (context
                                            .read<UserCubit>()
                                            .controllerPhone
                                            .text
                                            .isEmpty ||
                                        context
                                            .read<UserCubit>()
                                            .passwordController
                                            .text
                                            .isEmpty) {
                                      var snackBar = const SnackBar(
                                          content: Text('يرجى ملئ الحقول'));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else {
                                      if (context
                                              .read<UserCubit>()
                                              .passwordController
                                              .text
                                              .length <
                                          4) {
                                        var snackBar = const SnackBar(
                                            content: Text(
                                                'يرجى كتابة كلمة السر بطول ال 4 على الاقل والرقم من 10 ارقام '));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      } else {
                                        context.read<UserCubit>().signIn();
                                      }
                                    }
                                  },
                                ),
                          const SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ),
                                (route) => false,
                              );
                            },
                            child: const Text("Sign Up"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget component1(
    IconData icon,
    String hintText,
    bool isPassword,
    TextEditingController? controller,
    TextInputType keyboardType,
    List<TextInputFormatter> inputFormatters, {
    Widget? suffixIcon,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 0, 0, 0).withOpacity(.3),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(.8),
            fontWeight: FontWeight.bold,
          ),
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
              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(.5),
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ),
    );
  }
}

Widget component1(
    IconData icon,
    String hintText,
    bool isPassword,
    TextEditingController? controller,
    TextInputType keyboardType,
    List<TextInputFormatter> inputFormatters) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 0, 0).withOpacity(.3),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
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
