import 'package:flutter/material.dart';
import 'package:flutter_application_1/singup/validate_code.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

// ignore: camel_case_types, must_be_immutable
class Validate extends StatefulWidget {
  const Validate({super.key});

  @override
  State<Validate> createState() => _ValidateState();
}

class _ValidateState extends State<Validate> {
  var countriess = countries;
  var filteredCountries = ["SY"];
  TextEditingController controllerPhone = TextEditingController(text: "09");
  List<Country> filter = [];
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    for (var element in countriess) {
      for (var filteredc in filteredCountries) {
        if (filteredc == element.code) {
          filter.add(element);
        }
      }
    }
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
                  opacity: 0.1,
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IntlPhoneField(
                        autofocus: true,
                        controller: controllerPhone,
                        onTap: null,
                        onChanged: null,
                        onSaved: null,
                        onCountryChanged: null,
                        onSubmitted: null,
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
                          if (controllerPhone.text != "09" &&
                              controllerPhone.text.isNotEmpty) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ValidateCode()));
                          } else {
                            var snackBar = const SnackBar(
                                content: Text('يرجى ادخال الرقم بشكل صحيح'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
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
