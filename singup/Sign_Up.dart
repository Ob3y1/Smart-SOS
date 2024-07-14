import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/singup/Validating.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  DateTime date = DateTime.now();
  String? country = "";
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordconfigController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage(
                "images/ALSHA.png",
              )),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const Text(
                //   "Edit Your Information:",
                //   style: TextStyle(
                //     fontSize: 20,
                //     fontWeight: FontWeight.bold,
                //     letterSpacing: 1,
                //     wordSpacing: 4,
                //   ),
                // ),
                const SizedBox(
                  height: 250,
                ),
                component1(Icons.account_circle_outlined, 'User Name...', false,
                    false, userNameController),
                const SizedBox(
                  height: 20,
                ),
                component1(Icons.lock_outline, 'Password...', true, false,
                    passwordController),
                const SizedBox(
                  height: 20,
                ),
                component1(Icons.lock_outline, 'Re-enter Password...', true,
                    false, passwordconfigController),
                const SizedBox(
                  height: 20,
                ),
                // const Text(
                //   "Choose Your Gender:",
                //   style: TextStyle(
                //     fontSize: 20,
                //     fontWeight: FontWeight.bold,
                //     letterSpacing: 1,
                //     wordSpacing: 4,
                //   ),
                // ),
                RadioListTile(
                    activeColor: Colors.purple,
                    title: const Text("male"),
                    value: "male",
                    groupValue: country,
                    onChanged: (val) {
                      setState(() {
                        country = val;
                      });
                    }),
                RadioListTile(
                    activeColor: Colors.purple,
                    title: const Text("female"),
                    value: "female",
                    groupValue: country,
                    onChanged: (val) {
                      setState(() {
                        country = val;
                      });
                    }),
                Text(
                  '${date.day}/${date.month}/${date.year}',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                ElevatedButton(
                  child: const Text(
                    'Select a date:',
                    style: TextStyle(fontSize: 20, color: Colors.purple),
                  ),
                  onPressed: () async {
                    DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(1500),
                        lastDate: DateTime(2500));
                    if (newDate == null) return;
                    setState(() {
                      date = newDate;
                    });
                  },
                ),
                const SizedBox(
                  height: 70,
                ),
                component2(
                  'Continue',
                  2,
                  () {
                    prefs.setString("passeord", passwordController.text);
                    prefs.setString(
                        "passeordconfig", passwordconfigController.text);
                    prefs.setString("userName", userNameController.text);
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Validate()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget component1(IconData icon, String hintText, bool isPassword,
      bool isEmail, TextEditingController? controller) {
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
              color: Color.fromARGB(255, 0, 0, 0).withOpacity(.8),
              fontWeight: FontWeight.bold),
          cursorColor: const Color.fromARGB(255, 0, 0, 0),
          obscureText: isPassword,
          keyboardType:
              isEmail ? TextInputType.emailAddress : TextInputType.text,
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

class Validating {}
