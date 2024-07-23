import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home.dart';

class Login extends StatefulWidget {
  const Login({Key? key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoginEnabled = false;

  @override
  void initState() {
    super.initState();
    phoneNumberController.addListener(validateFields);
    passwordController.addListener(validateFields);
  }

  void validateFields() {
    setState(() {
      isLoginEnabled = phoneNumberController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          validatePhoneNumber(phoneNumberController.text);
    });
  }

  bool validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.startsWith("09") && phoneNumber.length == 10) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                "assets/image/OIP__2_-removebg-preview.png",
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(left: 20, top: 20, right: 30),
                width: double.infinity,
                height: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                        fontFamily: "myfont",
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "please login to continue with your account",
                      style: TextStyle(
                        fontFamily: "myfont",
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 25),
                    TextFormField(
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        labelStyle: TextStyle(
                            color: Color.fromARGB(255, 128, 130, 128),
                            fontFamily: "myfont"),
                        border: OutlineInputBorder(
                          gapPadding: 6,
                          borderSide: const BorderSide(
                              color: Color.fromARGB(31, 243, 243, 243)),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 103, 102, 101)),
                        ),
                      ),
                      controller: phoneNumberController,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                            color: Color.fromARGB(255, 128, 130, 128),
                            fontFamily: "myfont"),
                        border: OutlineInputBorder(
                          gapPadding: 6,
                          borderSide: const BorderSide(
                              color: Color.fromARGB(31, 243, 243, 243)),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 103, 102, 101)),
                        ),
                      ),
                      controller: passwordController,
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: isLoginEnabled
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Home(
                                    phoneNumber: phoneNumberController.text,
                                    password: passwordController.text,
                                  ),
                                ),
                              );
                            }
                          : null,
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Color.fromARGB(255, 242, 239, 239),
                          fontFamily: 'myfont',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 15, 14, 14),
                        padding: EdgeInsets.symmetric(
                            horizontal: 120, vertical: 22),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}