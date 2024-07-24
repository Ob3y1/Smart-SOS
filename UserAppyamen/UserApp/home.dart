import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/UserApp/edit.dart';
import 'package:flutter_application_1/login/login.dart';

// ignore: camel_case_types
class home extends StatefulWidget {
  final String? phoneNumber;

  const home({super.key, this.phoneNumber});

  @override
  State<home> createState() => _HomeState();
}

class _HomeState extends State<home> {
  Color primaryColor = const Color.fromARGB(228, 0, 0, 0);
  Color accentColor = const Color(0xFFD3A984);
  Color textColor = const Color.fromARGB(255, 255, 255, 255);
  Color buttonColor = const Color.fromARGB(255, 7, 7, 8);
  Color backgroundColor = const Color(0xFFF5F5F5);
  Color containerColor = const Color.fromARGB(255, 33, 32, 32);
  bool step1 = true;
  bool step2 = true;
  bool step3 = true;
  bool activeTextFromField = false;

  void showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(Icons.logout),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                // Perform logout action here
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginScreen()));
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    if (step1 && step2 && step3) {
      activeTextFromField = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromRGBO(0, 0, 0, 1),
          ),
          backgroundColor: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10, right: 20),
              width: double.infinity,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: showLogoutDialog,
                    icon: const Icon(Icons.logout),
                    color: backgroundColor,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HomePageedit()));
                    },
                    icon: const Icon(Icons.edit),
                    color: backgroundColor,
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phone Number:',
                          style: TextStyle(color: textColor),
                        ),
                        Text(
                          widget.phoneNumber ?? "",
                          style: TextStyle(color: textColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(top: 30, left: 0, right: 0),
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: Colors.black)),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: Stepper(
                elevation: 0,
                type: StepperType.horizontal,
                steps: [
                  Step(
                    isActive: step1,
                    stepStyle: StepStyle(
                      color: step1 == false ? Colors.grey : Colors.green,
                    ),
                    // title: Text('تم الارسال'),
                    title: const SizedBox.shrink(),
                    subtitle: const Text('تم الارسال'),
                    content: const SizedBox.shrink(),
                  ),
                  Step(
                    isActive: step2,
                    stepStyle: StepStyle(
                      color: step2 == false ? Colors.grey : Colors.green,
                    ),
                    title: const SizedBox.shrink(),
                    subtitle: const Text('المساعدة في الطريق'),
                    // title: Text('المساعدة في الطريق'),
                    content: const SizedBox.shrink(),
                  ),
                  Step(
                    isActive: step3,
                    stepStyle: StepStyle(
                      color: step3 == false ? Colors.grey : Colors.green,
                    ),
                    title: const SizedBox.shrink(),
                    subtitle: const Text('تم انهاء العمل '),
                    // title: Text('تم انهاء العمل '),
                    content: const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
            TextField(
              style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(.8),
                  fontWeight: FontWeight.bold),
              cursorColor: const Color.fromARGB(255, 0, 0, 0),
              enabled: activeTextFromField,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(9)),
                hintText: 'Add your notes here',
                hintStyle: TextStyle(
                    fontSize: 14,
                    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(.5)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
