import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

class Signup1 extends StatefulWidget {
  const Signup1({Key? key}) : super(key: key);

  @override
  _Signup1State createState() => _Signup1State();
}

class _Signup1State extends State<Signup1> {
  Color primaryColor = const Color.fromARGB(255, 12, 13, 13);
  final TextEditingController phoneNumberController = TextEditingController();
  String selectedCountryCode = "+963";
  bool phoneNumberError = false;

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    phoneNumberController.addListener(validatePhoneNumber);
  }

  void validatePhoneNumber() {
    setState(() {
      final phoneNumber = phoneNumberController.text;
      phoneNumberError = !(phoneNumber.startsWith('09'));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 30, 0, 0),
              child: Text(
                "Sign Up",
                style: const TextStyle(
                  fontSize: 35,
                  fontFamily: "myfont",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(
                "continue with phone number verification",
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: "myfont",
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Image.asset(
                "assets/image/image-removebg-preview.png",
                height: 200,
                width: 500,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(30, 40, 0, 0),
              margin: const EdgeInsets.only(top: 100),
              width: double.infinity,
              height: 278,
              decoration: BoxDecoration(
                color: const Color.fromARGB(146, 178, 184, 189),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mobile number",
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: "myfont",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 10),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.start, // Updated alignment
                      children: [
                        CountryCodePicker(
                          onChanged: (value) {
                            setState(() {
                              selectedCountryCode = value.toString();
                            });
                          },
                          initialSelection: 'SY',
                          countryFilter: [
                            'SY'
                          ], // Set countryFilter to contain only 'SY' (Syria)
                          showCountryOnly: false,
                          showOnlyCountryWhenClosed: false,
                          alignLeft: false,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: phoneNumberController,
                            maxLength: 10,
                            decoration: InputDecoration(
                              hintText: "Enter phone number",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10,
                        right: 30), // Added padding around ElevatedButton
                    child: ElevatedButton(
                      onPressed: () {
                        if (phoneNumberController.text.length == 10 &&
                            !phoneNumberError) {
                          // Proceed to the next step

                          Navigator.pushNamed(context, '/six');
                        } else {
                          // Show an error message for invalid phone number
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Invalid Phone Number"),
                                content: const Text(
                                  "Please enter a valid 10-digit phone number starting with '09'.",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: const Text(
                        "Next",
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: "myfont",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ButtonStyle(
                        // ignore: deprecated_member_use
                        backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(232, 0, 0, 0),
                        ),
                        // ignore: deprecated_member_use
                        foregroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 255, 255, 255),
                        ),
                        // ignore: deprecated_member_use
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 110, vertical: 20),
                        ),
                        // ignore: deprecated_member_use
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}