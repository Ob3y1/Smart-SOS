import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'complaint_form.dart'; // تأكد من استيراد صفحة تقديم الشكوى

class ComplaintsListPage extends StatefulWidget {
  @override
  _ComplaintsListPageState createState() => _ComplaintsListPageState();
}

class _ComplaintsListPageState extends State<ComplaintsListPage> {
  List<dynamic> _complaints = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchComplaints();
  }

  Future<void> _fetchComplaints() async {
    final url =
        'https://yourapi.com/api/complaints'; // استبدل this ب URL الخاص بك
    final token = 'your_token'; // استبدل this بالتوكن الخاص بك

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _complaints = jsonDecode(response.body);
          _isLoading = false;
        });
      } else {
        // خطأ في جلب الشكاوى
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      // خطأ في الاتصال
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Complaints'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _complaints.length,
                    itemBuilder: (context, index) {
                      final complaint = _complaints[index];
                      return ListTile(
                        title: Text('Complaint #${complaint['id']}'),
                        subtitle: Text('Status: ${complaint['status']}'),
                        onTap: () {
                          // يمكن إضافة منطق لفتح تفاصيل الشكوى إذا رغبت بذلك
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ComplaintForm()),
                      );
                    },
                    child: Text('Submit a New Complaint'),
                  ),
                ),
              ],
            ),
    );
  }
}
