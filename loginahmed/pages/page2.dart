import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Page_2 extends StatelessWidget {
  const Page_2({super.key});

  @override
  Widget build(BuildContext context) {
     Color primaryColor =  Color.fromARGB(255, 12, 13, 13);
    // ignore: unused_local_variable
    Color accentColor = Color(0xFFD3A984);
    // ignore: unused_local_variable
    Color textColor = Color.fromARGB(255, 255, 252, 252);
    // ignore: unused_local_variable
    Color buttonColor = Color.fromARGB(255, 12, 12, 12);
    Color backgroundColor = Color.fromARGB(255, 255, 255, 255);

    return SafeArea(
      
      child: Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: const Color.fromARGB(255, 243, 242, 242)),
          backgroundColor: primaryColor,
          title: Text(
            "Smart Sos",
            style: TextStyle(
              fontFamily: "myfont",
              
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: textColor
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
                 "كل خدمات الطوارئ متوفرة",
                    style: TextStyle(
                      fontFamily: "myfont",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: 10,),
                     Text(
                "وفرنا خدمة الاسعاف والاطفاء والشرطة بحيث يتواجدوا بأسرع وقت عندكم في أي طارئ",
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
            Container(
              margin: EdgeInsets.fromLTRB(10, 70, 10, 20),
         child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                     margin: EdgeInsets.fromLTRB(20,50, 0, 0),
                    child: FloatingActionButton(
                      onPressed: () {
                            Navigator.pushNamed(context, '/fore');
                      },
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "myfont",
                          color: textColor
                        ),
                      ),
                      backgroundColor:buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // تعديل حجم الحواف هنا
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    
                     margin: EdgeInsets.fromLTRB(0,50, 20, 0),
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/third');
                         
                        
                      },
                      
                      child: Text(
                        "Next",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "myfont",
                          color: textColor
                        ),
                      ),
                      backgroundColor: buttonColor,
                        shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // تعديل حجم الحواف هنا
                      ),
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