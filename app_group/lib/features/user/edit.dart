import 'package:app_group/core/cubit/user_cubit.dart';
import 'package:app_group/features/user/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class HomePageedit extends StatefulWidget {
  const HomePageedit({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageedit> with TickerProviderStateMixin {
  // ignore: non_constant_identifier_names

  var countriess = countries;
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
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black,
        title: const Text(
          "Edit Your Information:",
          style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              wordSpacing: 1,
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
                  context.read<UserCubit>().edituserNameController,
                  TextInputType.text),
              const SizedBox(
                height: 30,
              ),

              // component1(Icons.account_circle_outlined, 'Phone Number...',
              //     false, controllerPhone, TextInputType.number),

              component1(
                  Icons.lock_outline,
                  'Password...',
                  true,
                  context.read<UserCubit>().editpasswordController,
                  TextInputType.text),
              const SizedBox(
                height: 30,
              ),

              const SizedBox(
                height: 30,
              ),
              // IntlPhoneField(
              //   controller: context.read<UserCubit>().editcontrollerPhone,
              //   onTap: null,
              //   onChanged: null,
              //   onSaved: null,
              //   onCountryChanged: null,
              //   onSubmitted: null,
              //   keyboardType: TextInputType.number,
              //   dropdownTextStyle: const TextStyle(fontSize: 18),
              //   style: const TextStyle(fontSize: 18),
              //   dropdownIcon: const Icon(
              //     Icons.arrow_drop_down,
              //     size: 28,
              //   ),
              //   decoration: const InputDecoration(
              //       contentPadding: EdgeInsets.zero,
              //       labelText: 'Phone Number...',
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(20)),
              //         borderSide: BorderSide(color: Colors.purple),
              //       )),
              //   initialCountryCode: 'SY',
              //   countries: filter,
              // ),
              const SizedBox(
                height: 30,
              ),
              RadioListTile(
                  activeColor: Colors.purple,
                  title: const Text("male"),
                  value: "male",
                  groupValue: context.read<UserCubit>().editcountry,
                  onChanged: (val) {
                    setState(() {
                      context.read<UserCubit>().editcountry = val;
                    });
                  }),
              RadioListTile(
                  activeColor: Colors.purple,
                  title: const Text("female"),
                  value: "female",
                  groupValue: context.read<UserCubit>().editcountry,
                  onChanged: (val) {
                    setState(() {
                      context.read<UserCubit>().editcountry = val;
                    });
                  }),
              Text(
                '${context.read<UserCubit>().date.day}/${context.read<UserCubit>().date.month}/${context.read<UserCubit>().date.year}',
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
                      initialDate: context.read<UserCubit>().date,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2500));
                  if (newDate == null) return;
                  setState(() {
                    context.read<UserCubit>().date = newDate;
                  });
                },
              ),
              const SizedBox(
                height: 70,
              ),

              component2(
                'Edit',
                2,
                () {
                  if (context
                          .read<UserCubit>()
                          .edituserNameController
                          .text
                          .isNotEmpty &&
                      context
                          .read<UserCubit>()
                          .editpasswordController
                          .text
                          .isNotEmpty &&
                      context.read<UserCubit>().editcountry != "") {
                    if (context
                            .read<UserCubit>()
                            .editpasswordController
                            .text
                            .length <
                        4) {
                      var snackBar = const SnackBar(
                          content: Text(
                              'يرجى كتابة كلمة السر بطول ال 8 على الاقل '));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      var snackBar = const SnackBar(content: Text('sucsee'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      context.read<UserCubit>().editUserProfile();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const Home(),
                        ),
                        (route) => false,
                      );
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
    ));
  }
}

Widget component1(
  IconData icon,
  String hintText,
  bool isSecurePassword,
  TextEditingController? controller,
  TextInputType keyboardType,
) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 0, 0).withOpacity(.3),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        keyboardType: keyboardType,
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
