/*
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
runApp(MyApp());
}

class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'Firebase Token Example',
home: TokenScreen(),
);
}
}

class TokenScreen extends StatefulWidget {
@override
_TokenScreenState createState() => _TokenScreenState();
}

class _TokenScreenState extends State<TokenScreen> {
String? _token;

@override
void initState() {
super.initState();
_getToken();
}

Future<void> _getToken() async {
FirebaseMessaging messaging = FirebaseMessaging.instance;
String? token = await messaging.getToken();
setState(() {
_token = token;
});
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text('Firebase Token'),
),
body: Center(
child: _token != null
? Text('Token: $_token')
: CircularProgressIndicator(),
),
);
}
}

*/

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
/*import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';*/

import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controllerS = TextEditingController();
  List messages = [];
  String greetings = '';
  String greetings2 = '';
  String greetings3 = '';

  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult, localeId: 'ar_SA');
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  Future sendMessage(String message) async {
    final response = await http.post(
      Uri.parse(
          'http://localhost:5000/chat'), // تأكد من استخدام عنوان IP الصحيح
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'message': message}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        messages.add(
          " $message",
        );
        messages.add(" ${data['response']}");
      });
    } else {
      throw Exception('فشل في إرسال الرسالة');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SMART SOS chat',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        body: Container(
          width: double.infinity,
          /*    decoration:BoxDecoration( border:Border.all(color:Colors.transparent,width: 2.0),
      gradient:LinearGradient(colors:
      [Colors.blue,Colors.red],
      begin:Alignment.topLeft,
      end:Alignment.bottomRight,
      ),
      
      ),*/
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    Color textColor =
                        index % 2 == 0 ? Colors.black : Colors.black;
                    Color backcolor = index % 2 == 0 ? Colors.red : Colors.blue;
                    Alignment aligR = index % 2 == 0
                        ? Alignment.centerRight
                        : Alignment.centerLeft;
                    return Column(children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                              width: 2000,
                              padding: EdgeInsets.all(10),
                              color: backcolor.withOpacity(0.5),

/*       decoration:BoxDecoration( border:Border.all(color:Colors.transparent,width: 0.5),borderRadius:BorderRadius.circular(10),
      gradient:LinearGradient(colors:
      [backcolor,backcolor],
      begin:Alignment.topLeft,
      end:Alignment.bottomRight,
      ),
      
      ),
*/
                              alignment: aligR,
                              child: Text(messages[index],
                                  style: TextStyle(color: textColor)))),
                      SizedBox(height: 8)
                    ]);
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
                        decoration: InputDecoration(
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
                      icon: Icon(Icons.send),
                      onPressed: () {
                        //if(_lastWords == null){
                        if (_controller.text.isEmpty) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    title:
                                        Text('ادخل مشكلتك في الصندوق من فضلك'),
                                    actions: <Widget>[
                                      IconButton(
                                          icon: Icon(Icons.send),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          })
                                    ]);
                              });
                        } else {
                          sendMessage(_controller.text);
                          _controller.clear();
                        }
                        //}

                        // else{
                        // sendMessage('$_lastWords');
                        // _lastWords== null;
                        //}
                      },
                    ),
                  ],
                ),
              ),

              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(greetings, //Text that will be displayed on the screen
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    Text(greetings2, //Text that will be displayed on the screen
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    Center(
                      child: Container(
                        //container that contains the button
                        width: 150,
                        height: 60,
                        child: TextButton(
                          // color: Colors.blue,
                          onPressed: () async {
                            //async function to perform http get

                            final response = await http.get(Uri.parse(
                                'http://127.0.0.1:5000/get_data')); //getting the response from our backend server script

                            final decoded = json.decode(response.body) as Map<
                                String,
                                dynamic>; //converting it from json to key value pair

                            setState(() {
                              greetings = decoded['greetings'];
                              greetings2 = decoded[
                                  'greetings2']; //changing the state of our widget on data update
                            });
                          },
                          child: Text(
                            'Press',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent, width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [Colors.red, Colors.white],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: FloatingActionButton(
                              onPressed:

                                  // If not yet listening for speech start, otherwise stop

                                  _speechToText.isNotListening
                                      ? _startListening
                                      : _stopListening,
                              tooltip: 'Listen',
                              child: Icon(_speechToText.isNotListening
                                  ? Icons.mic_off
                                  : Icons.mic),
                            )),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Text('$_lastWords'),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {
                              //if(_lastWords == null){

                              if (_lastWords.isEmpty) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          title: Text(
                                              'ارجاء قم يتسجيل الصوت اولا'),
                                          actions: <Widget>[
                                            IconButton(
                                                icon: Icon(Icons.send),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                })
                                          ]);
                                    });
                              } else {
                                sendMessage(_lastWords);
                                _lastWords = "";
                              }
                              //}

                              // else{
                              // sendMessage('$_lastWords');
                              // _lastWords== null;
                              //}
                            },
                          ),
                        ),
                      ])) //Container
            ],
          ),
        ) //con1
        );
  }
}

/*

import 'package:flutter/material.dart';
 


import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void startListening() {
    _speech.listen(
      onResult: (result) {
        setState(() {
          _text = result.recognizedWords;
        });
      },
    );
    setState(() {
      _isListening = true;
    });
  }

  void stopListening() {
    _speech.stop();
    setState(() {
      _isListening = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Speech to Text Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_text),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (!_isListening) {
                    startListening();
                  } else {
                    stopListening();
                  }
                },
                child: Text(_isListening ? 'Stop Listening' : 'Start Listening'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/

/*


 import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Recognized words:',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  '$_lastWords'
                  
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            // If not yet listening for speech start, otherwise stop
            _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
    );
  }
}*/
