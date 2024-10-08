import 'package:app_group/core/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class ValidateCode extends StatefulWidget {
  const ValidateCode({super.key});

  @override
  State<ValidateCode> createState() => _ValidateCodeState();
}

class _ValidateCodeState extends State<ValidateCode> {
  String? code;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          title: const Text(
            "Sign Up",
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
          child: Stack(children: [
            Container(
              width: double.infinity,
              height: 400,
              margin: const EdgeInsets.only(top: 100),
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
                    height: 200,
                  ),
                  const Text(
                    ":سوف يتم ارسال كود عبر رقم الهاتف ادخله هنا",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  OTPTextField(
                    contentPadding: const EdgeInsets.all(10),
                    fieldStyle: FieldStyle.box,
                    style: const TextStyle(fontSize: 32),
                    fieldWidth: 50,
                    width: 360,
                    length: 4,
                    onChanged: (value) {
                      setState(() {
                        code = value;
                        print("acsoa $code");
                      });
                    },
                    keyboardType: TextInputType.number,
                    otpFieldStyle: OtpFieldStyle(
                      borderColor: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  MaterialButton(
                    onPressed: () {
                      print(code);
                      if (code != null) {
                        context.read<UserCubit>().signUp(code!,context);
                      } else {
                        var snackBar = const SnackBar(
                            content: Text('يرجى ادخال الكود بشكل صحيح'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    color: Colors.black,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 70),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                      "Next",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          wordSpacing: 4,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ]),
        ));
  }
}
