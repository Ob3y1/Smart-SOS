
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}   

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  List messages = [];
    String greetings = '';
  String greetings2 = '';
 
  Future sendMessage(String message) async {
    final response = await http.post(
      Uri.parse('http://localhost:5000/chat'), // تأكد من استخدام عنوان IP الصحيح
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'message': message}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        messages.add("أنت: $message",);
        messages.add("بوت: ${data['response']}");
      });
    } else {
      throw Exception('فشل في إرسال الرسالة');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SMART SOS chat',style:TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),),
      body: Column(
      
        children: [
          Expanded(
          
            child: ListView.builder(
            
              itemCount: messages.length,
              itemBuilder: (context, index) {

                return Container(
      
      child: ListTile(title: Text(messages[index])));
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
                    decoration: InputDecoration(hintText: 'اكتب رسالة...'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    sendMessage(_controller.text);
                    _controller.clear();
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
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text(greetings2, //Text that will be displayed on the screen
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Center( 
              child: Container( //container that contains the button 
                width: 150,    
                height: 60,
                child: TextButton(
                 // color: Colors.blue,
                  onPressed: () async { //async function to perform http get

                  final response = await http.get(Uri.parse('http://127.0.0.1:5000/get_data')); //getting the response from our backend server script

                  final decoded = json.decode(response.body) as Map<String, dynamic>; //converting it from json to key value pair 

                  setState(() {
                    greetings = decoded['greetings'];
                    greetings2 = decoded['greetings2'];  //changing the state of our widget on data update
                  });

                  },
                  child: Text( 
                    'Press',
                    style: TextStyle(fontSize: 24,),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
        ],
      ),
    );
  }
}


