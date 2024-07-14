import 'package:flutter/material.dart';
import 'package:flutter_application_1/singup/validate_code.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

// ignore: camel_case_types, must_be_immutable
class Validate extends StatefulWidget {
  Validate({super.key});

  @override
  State<Validate> createState() => _ValidateState();
}

class _ValidateState extends State<Validate> {
  var countriess = countries;
  var filteredCountries = ["SY"];
  TextEditingController controllerPhone = TextEditingController();
  List<Country> filter = [];
  final GlobalKey<FormState> _formKey = GlobalKey();
  void initState() {
    // TODO: implement initState
    super.initState();
    countriess.forEach((element) {
      filteredCountries.forEach((filteredc) {
        if (filteredc == element.code) {
          filter.add(element);
        }
      });
    });
  }

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
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            margin: const EdgeInsets.only(top: 50),
            width: double.infinity,
            height: 400,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                "images/ALSHA.png",
              )),
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 400,
              ),
              // const Text(
              //   "Mobile Number:",
              //   style: TextStyle(
              //     fontSize: 25,
              //     fontWeight: FontWeight.bold,
              //     fontStyle: FontStyle.italic,
              //   ),
              // ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IntlPhoneField(
                        controller: controllerPhone,
                        keyboardType: TextInputType.number,
                        dropdownTextStyle: const TextStyle(fontSize: 18),
                        style: const TextStyle(fontSize: 18),
                        dropdownIcon: const Icon(
                          Icons.arrow_drop_down,
                          size: 28,
                        ),
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            labelText: 'Phone Number...',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Colors.purple),
                            )),
                        initialCountryCode: 'SY',
                        countries: filter,
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          if (controllerPhone.text.isEmpty) {
                            var snackBar = const SnackBar(
                                content: Text('يرجى ادخال الرقم بشكل صحيح'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ValidateCode()));
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12),
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
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
