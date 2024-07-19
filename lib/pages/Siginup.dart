
import 'package:flutter/material.dart';

class Siginup extends StatefulWidget {
  const Siginup({super.key});

  @override
  State<Siginup> createState() => _SignupState();
}

class _SignupState extends State<Siginup> {
 DateTime date =DateTime.now();
  String gender = '';
  String name = '';

  String password = '';
  String errorMessage = '';
  String confirmPassword = '';
  bool _isFormFilled = false;
  bool _isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 30, 0, 0),
              alignment: Alignment.topLeft,
              child: const Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: "myfont",
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(25),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 'male',
                            groupValue: gender,
                            onChanged: (newValue) {
                              setState(() {
                                gender = newValue!;
                                _isFormFilled = gender.isNotEmpty &&
                                    name.isNotEmpty &&
                                
                                    password.isNotEmpty &&
                                    confirmPassword.isNotEmpty;
                              });
                            },
                          ),
                          const SizedBox(width: 20),
                          const Text(
                            "Male",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              fontFamily: "myfont",
                            ),
                          ),
                          const SizedBox(width: 20),
                          Radio(
                            value: 'female',
                            groupValue: gender,
                            onChanged: (newValue) {
                              setState(() {
                                gender = newValue!;
                                _isFormFilled = gender.isNotEmpty &&
                                    name.isNotEmpty &&
                               
                                    password.isNotEmpty &&
                                    confirmPassword.isNotEmpty;
                              });
                            },
                          ),

                          const SizedBox(width: 20),
                          const Text(
                            "Female",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              fontFamily: "myfont",
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            name = value;
                            _isFormFilled = name.isNotEmpty &&
                                gender.isNotEmpty &&
                        
                                password.isNotEmpty &&
                                confirmPassword.isNotEmpty;
                          });
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: "Name",
                          labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 128, 130, 128),
                            fontFamily: "myfont",
                          ),
                          border: OutlineInputBorder(
                            gapPadding: 6,
                            borderSide: const BorderSide(
                              color: Color.fromARGB(31, 243, 243, 243),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 41, 41, 41),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
             
                      const Text(
                        "Use a valid and active email, we will need to verify it later ",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "myfont",
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            password = value;
                            _isFormFilled = name.isNotEmpty &&
                                gender.isNotEmpty &&
                               
                                password.isNotEmpty &&
                                confirmPassword.isNotEmpty;
                            password == confirmPassword && password.length >= 8;
                            errorMessage = '';
                          });
                        },
                        obscureText: !_isPasswordVisible,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 128, 130, 128),
                            fontFamily: "myfont",
                          ),
                          border: OutlineInputBorder(
                            gapPadding: 6,
                            borderSide: const BorderSide(
                              color: Color.fromARGB(31, 243, 243, 243),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 103, 102, 101),
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Keep it safe, use both upper and lowercase and a number ",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "myfont",
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            confirmPassword = value;
                            _isFormFilled = name.isNotEmpty &&
                                gender.isNotEmpty &&
                    
                                password.isNotEmpty &&
                                confirmPassword.isNotEmpty;
                            password == confirmPassword && password.length >= 8;
                            errorMessage = '';
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelText: "Re-enter Password",
                          labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 128, 130, 128),
                            fontFamily: "myfont",
                          ),
                          border: OutlineInputBorder(
                            gapPadding: 6,
                            borderSide: const BorderSide(
                              color: Color.fromARGB(31, 243, 243, 243),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 103, 102, 101),
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      if (errorMessage.isNotEmpty)
                        Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              errorMessage,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontFamily: "myfont",
                              ),
                            )),
                      const SizedBox(height: 15),
                      Container(
                        margin: const EdgeInsets.only(right: 190),
                        child: const Text(
                          "Just to be safe ",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "myfont",
                          ),
                          textAlign: TextAlign.left,
                        ),
                        
                      ),
                      Text(
                        '${date.day}/${date.month}/${date.year}',
                     style: TextStyle(),   
                      ),
                      ElevatedButton(onPressed: () async{
                        // ignore: unused_local_variable
                        DateTime ? newDate = await showDatePicker(
                          context: context, firstDate: DateTime(1500), lastDate: DateTime(2500),
                          
                          );
                        if (newDate==null) return;
                        setState(() {
                          date=newDate;
                        });
                      }, child:Text('Select Date') ),
                      const SizedBox(height: 10),
                      const Text(
                        "By signing up, I agree with Terms & Conditions and Privacy Policy",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "myfont",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.only(bottom: 25),
                        child: ElevatedButton(
                          onPressed: _isFormFilled
                              ? () {
                                  if (_formKey.currentState!.validate()) {
                                    // <-- التحقق من صحة النموذج
                                    if (password.length < 8) {
                                      setState(() {
                                        errorMessage =
                                            'Passwords must be at least 8 characters long.';
                                      });
                                    } else if (password != confirmPassword) {
                                      setState(() {
                                        errorMessage = 'Passwords do not match.';
                                      });
                                    } else {
                                      Navigator.pushNamed(context, '/five');
                                    }
                                  }
                                }
                              : null,
                          child: const Text(
                            "Continue",
                            style: TextStyle(
                              color: Color.fromARGB(255, 229, 229, 229),
                              fontFamily: "myfont",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ButtonStyle(
                            
                            padding: WidgetStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 105, vertical: 27),
                            ),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            backgroundColor: _isFormFilled
                                ? WidgetStateProperty.all(
                                    Color.fromARGB(255, 20, 20, 20))
                                : WidgetStateProperty.all(
                                    Color.fromARGB(255, 147, 150, 147)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
