import 'dart:async';
import 'package:app_group/core/cubit/user_cubit.dart';
import 'package:app_group/features/group/map/mapp.dart';
import 'package:app_group/features/user/UserApp/Complaint.dart';
import 'package:app_group/features/user/edit.dart';
import 'package:app_group/main.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Color primaryColor = const Color.fromARGB(228, 0, 0, 0);
  Color accentColor = const Color(0xFFD3A984);
  Color textColor = const Color.fromARGB(255, 255, 255, 255);
  Color buttonColor = const Color.fromARGB(255, 7, 7, 8);
  Color backgroundColor = const Color(0xFFF5F5F5);
  Color containerColor = const Color.fromARGB(255, 33, 32, 32);
  bool _isObscured = true;
  final TextEditingController _controller = TextEditingController();
  List messages = [];
  String greetings = '';
  String greetings2 = '';

  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    context.read<UserCubit>().getUserProfile();
    print(prefs.getString("phone_number"));
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult, localeId: 'ar_SA');
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      _controller.text = _lastWords; // تعيين النص المسجل إلى حقل النص
    });
  }

  Future sendMessage(String message) async {
    print("sendMessage");
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/chat'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'message': message}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        messages.add(" $message");
        messages.add(" ${data['response']}");
      });
    } else {
      throw Exception('فشل في إرسال الرسالة');
    }
  }

  void showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(Icons.logout),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                context.read<UserCubit>().logout(context);
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const SizedBox(
                height: 78,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Text(
                    'User Menu',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.edit,
                    color:
                        Color.fromARGB(255, 0, 0, 0)), // التأكد من لون الأيقونة
                title: const Text('Edit Profile',
                    style: TextStyle(
                        color: Color.fromARGB(
                            255, 0, 0, 0))), // التأكد من لون النص
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const HomePageedit(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.add_comment,
                    color:
                        Color.fromARGB(255, 0, 0, 0)), // التأكد من لون الأيقونة
                title: const Text('Complaint',
                    style: TextStyle(
                        color: Color.fromARGB(
                            255, 0, 0, 0))), // التأكد من لون النص
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ComplaintsListPage(),
                    ),
                  );
                },
              ),
              const Spacer(), // يملأ المساحة الفارغة بين عناصر القائمة وزر تسجيل الخروج
              ListTile(
                leading: const Icon(Icons.logout,
                    color:
                        Color.fromARGB(255, 0, 0, 0)), // التأكد من لون الأيقونة
                title: const Text('Logout',
                    style: TextStyle(
                        color: Color.fromARGB(
                            255, 0, 0, 0))), // التأكد من لون النص
                onTap: showLogoutDialog,
              ),
            ],
          ),
        ),
        body: Builder(
          builder: (context) => Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10, right: 20),
                width: double.infinity,
                height: 70,
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu,
                          color: Colors.white), // أيقونة drawer
                      onPressed: () {
                        Scaffold.of(context)
                            .openDrawer(); // فتح ال drawer عند الضغط على الأيقونة
                      },
                    ),
                    const Spacer(),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Phone Number:',
                              style: TextStyle(color: textColor),
                            ),
                            Text(
                              prefs.getString("phoneNumber").toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white70,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: double.infinity,
                height: 250,
                child: MapScreen(),
              ),
              const SizedBox(height: 8),
              Container(
                margin: const EdgeInsets.only(top: 0, left: 0, right: 0),
                width: double.infinity,
                height: 380,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    opacity: 0.5,
                    image: AssetImage("images/A.png"),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          if (messages[index] == " لا تقلق نحن قادمون") {
                            print(messages[index]);
                            context.read<UserCubit>().getdetails(context);
                          }

                          Color textColor =
                              index % 2 == 0 ? Colors.white : Colors.white;
                          Color backcolor =
                              index % 2 == 0 ? Colors.grey : Colors.black;
                          Alignment aligR = index % 2 == 0
                              ? Alignment.centerRight
                              : Alignment.centerLeft;
                          return Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(10),
                                  color: backcolor.withOpacity(0.5),
                                  alignment: aligR,
                                  child: Text(
                                    messages[index],
                                    style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              decoration: const InputDecoration(
                                hintText: "اكتب الرسالة هنا.....",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              _speechToText.isNotListening
                                  ? Icons.mic_off
                                  : Icons.mic,
                            ),
                            onPressed: _speechToText.isListening
                                ? _stopListening
                                : _startListening,
                          ),
                          IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {
                              if (_controller.text.isEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                          'ادخل مشكلتك في الصندوق من فضلك'),
                                      actions: <Widget>[
                                        IconButton(
                                          icon: const Icon(Icons.send),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    );
                                  },
                                );
                              } else {
                                sendMessage(_controller.text);
                                _controller.clear();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
