import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class Otp extends StatefulWidget {
  const Otp({Key? key}) : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final TextEditingController _pinController = TextEditingController();
  bool _isPinComplete = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _pinController.addListener(_checkPinCompletion);
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _checkPinCompletion() {
    setState(() {
      _isPinComplete = _pinController.text.length == 4;
    });
  }

  void navigateToNextScreen(BuildContext context) {
    if (_isPinComplete) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Verifying...'),
          duration: Duration(seconds:1),
        ),
      );
      // Perform verification logic here
      Navigator.pushNamed(context, '/seven');
    } else {
      setState(() {
        _errorMessage = 'Please enter a 4-digit code';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(226, 20, 71, 1),
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(84, 48, 66, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 244, 244, 244),
        appBar: AppBar(),
        body: Container(
          margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
          width: double.infinity,
          decoration: BoxDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  "assets/image/OIP__1_-removebg-preview.png",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 240,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Verify",
                style: TextStyle(
                  fontSize: 35,
                  fontFamily: "myfont",
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Please enter the 4-digit code sent to your number",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "myfont",
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Center(
                  child: Pinput(
                    length: 4,
                    controller: _pinController,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    showCursor: true,
                  ),
                ),
              ),
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () => navigateToNextScreen(context),
                child: Text(
                  "Verify",
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: "myfont",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      // ignore: deprecated_member_use
                      MaterialStateProperty.all(Color.fromARGB(255, 0, 0, 0)),
                  foregroundColor:
                      // ignore: deprecated_member_use
                      MaterialStateProperty.all(Color.fromARGB(255, 255, 255, 255)),
                  // ignore: deprecated_member_use
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 120, vertical: 22)),
                  // ignore: deprecated_member_use
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/five');
                },
                child: Text(
                  "Edit phone number",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: "myfont",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}