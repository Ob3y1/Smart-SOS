import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Page_3 extends StatelessWidget {
  const Page_3({super.key});

  @override
  Widget build(BuildContext context) {
  Color primaryColor =  Color.fromARGB(255, 0, 0, 0);
    // ignore: unused_local_variable
    Color accentColor = Color(0xFFD3A984);
    // ignore: unused_local_variable
    Color textColor = Color.fromARGB(255, 0, 0, 0);
    // ignore: unused_local_variable
    Color buttonColor = Color.fromARGB(255, 4, 4, 4);
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
              color: backgroundColor,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
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
              child: Column(
                children: [
                  Text(
              "طوارئ سريعة باستجابة سريعة",
                    style: TextStyle(
                      fontFamily: "myfont",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: 10,),
                     Text(
               "يقوم الذكاء الاصتناعي بتوجيه زمر الطوارئ بأسرع وقت إليكم ",
                    style: TextStyle(
                      fontFamily: "myfont",
                      fontSize: 13,
                    
                      color: primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
               Container(
                alignment: Alignment.bottomRight,
               margin: EdgeInsets.fromLTRB(20,80,30, 0),
              child: FloatingActionButton(
                onPressed: () {
                      Navigator.pushNamed(context, '/fore');
                },
                child: Text(
                  "Sigin Up",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                   color: backgroundColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                backgroundColor:buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10), // تعديل حجم الحواف هنا
                ),
                mini: false,
              ),
            ),
            
          ],
        ),
        
        backgroundColor: backgroundColor,
      ),
    );
  }
}