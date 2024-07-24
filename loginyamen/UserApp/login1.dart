import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Login1Screen extends StatelessWidget {
  const Login1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController carController = TextEditingController();

    TextEditingController passwordController = TextEditingController();
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
                  const Text("Please Login To Continue With Your Account:",
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
                      carController),
                  const SizedBox(
                    height: 20,
                  ),
                  component1(Icons.lock_outline, 'Password...', true,
                      passwordController),
                  const SizedBox(
                    height: 50,
                  ),
                  component2(
                    'Login',
                    2,
                    () {
                       if (carController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        var snackBar =
                            const SnackBar(content: Text('يرجى ملئ الحقول'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        if (passwordController.text.length < 8) {
                          var snackBar = const SnackBar(
                              content: Text(
                                  'يرجى كتابة كلمة السر بطول ال 8 على الاقل '));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          print("sucss");
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
