import 'package:flutter/material.dart';

class Page_1 extends StatelessWidget {
  const Page_1({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Color primaryColor = Color.fromARGB(228, 0, 0, 0);
    // ignore: unused_local_variable
    Color accentColor = Color(0xFFD3A984);
    // ignore: unused_local_variable
    Color textColor = Color.fromARGB(255, 255, 255, 255);
    // ignore: unused_local_variable
    Color buttonColor = Color.fromARGB(255, 7, 7, 8);
    Color backgroundColor = Color(0xFFF5F5F5);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            "Smart Sos",
            style: TextStyle(
              fontFamily: "myfont",
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color:textColor,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              alignment: Alignment.topCenter,
              child: Image.asset(
                "assets/image/ALSHAMLOGO10-1-.png",
                height: 400,
                width: 300,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 5),
            Container(
              alignment: Alignment.center,
              child: Text(
                "تطبيق الطوارئ الرسمي في سوريا",
                style: TextStyle(
                  fontFamily: "myfont",
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 16, 14, 14),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 90, 10, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                     margin: EdgeInsets.fromLTRB(20,40, 0, 0),
                    child: FloatingActionButton(
                      onPressed: () {
                            Navigator.pushNamed(context, '/fore');
                      },
                      child: Text(
                        "Skip",
                        style: TextStyle(
                       color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "myfont",
                        ),
                      ),
                     backgroundColor: buttonColor,
                      
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // تعديل حجم الحواف هنا
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    
                    margin: EdgeInsets.fromLTRB(0,40, 20, 0),
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/second');
                      },
                      child: Text(
                        "Next",
                        style: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "myfont",
                        ),
                      ),
                      backgroundColor:buttonColor,
                      
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
