import 'package:flutter/material.dart';

class Error extends StatefulWidget {
  const Error({super.key});

  @override
  State<Error> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Error> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                "images/wrong-png-10-removebg-preview.png",
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Somethings has gone...",
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
