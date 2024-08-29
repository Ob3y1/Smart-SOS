import 'package:app_group/core/cubit/user_cubit.dart';
import 'package:app_group/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController userNameController = TextEditingController();
  //log in phone
  TextEditingController controllerPhone = TextEditingController();
  //sign up password
  TextEditingController passwordController = TextEditingController();
  //sign up config password
  TextEditingController passwordconfigController = TextEditingController();

  // متغيرات لإظهار أو إخفاء كلمة المرور
  bool _isPasswordObscured = true;
  bool _isConfigPasswordObscured = true;

  DateTime date = DateTime.now();
  var countriess = countries;
  String? country = "";
  var filteredCountries = ["SY"];
  List<Country> filter = [];

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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              opacity: 0.1,
              alignment: Alignment.center,
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
              const SizedBox(
                height: 100,
              ),
              component1(
                Icons.account_circle_outlined,
                'User Name...',
                false,
                userNameController,
              ),
              const SizedBox(
                height: 30,
              ),
              component1(
                Icons.lock_outline,
                'Password...',
                _isPasswordObscured,
                passwordController,
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordObscured
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isPasswordObscured = !_isPasswordObscured;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              component1(
                Icons.lock_outline,
                'Re-enter Password...',
                _isConfigPasswordObscured,
                passwordconfigController,
                suffixIcon: IconButton(
                  icon: Icon(_isConfigPasswordObscured
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isConfigPasswordObscured = !_isConfigPasswordObscured;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              IntlPhoneField(
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
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.purple),
                    )),
                initialCountryCode: 'SY',
                countries: filter,
              ),
              const SizedBox(
                height: 30,
              ),
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
                iconAlignment: IconAlignment.start,
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
                  if (userNameController.text.isNotEmpty &&
                      passwordconfigController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty &&
                      controllerPhone.text.isNotEmpty &&
                      country != "") {
                    if (passwordconfigController.text ==
                        passwordController.text) {
                      if (passwordController.text.length < 4) {
                        var snackBar = const SnackBar(
                            content: Text(
                                'يرجى كتابة كلمة السر بطول ال 8 على الاقل '));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        prefs.setString(
                            "userNameController", userNameController.text);
                        prefs.setString(
                            "passwordController", passwordController.text);
                        prefs.setString("passwordconfigController",
                            passwordconfigController.text);
                        prefs.setString("country", country ?? "");
                        prefs.setString(
                            "controllerPhone", controllerPhone.text);
                        prefs.setString("date", date.toString());
                        context.read<UserCubit>().otp(context);
                      }
                    } else {
                      var snackBar = const SnackBar(
                          content: Text('يرجى التأكد من مطابقة كلمة المرور'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  } else {
                    var snackBar =
                        const SnackBar(content: Text('يرجى ملئ الحقول'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget component1(
    IconData icon,
    String hintText,
    bool isPassword,
    TextEditingController? controller, {
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
          obscureText: isPassword,
          style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(.8),
            fontWeight: FontWeight.bold,
          ),
          cursorColor: const Color.fromARGB(255, 0, 0, 0),
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

Widget component1(IconData icon, String hintText, bool isSecurePassword,
    TextEditingController? controller) {
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
        style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(.8),
            fontWeight: FontWeight.bold),
        cursorColor: const Color.fromARGB(255, 0, 0, 0),
        obscureText: isSecurePassword,
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
