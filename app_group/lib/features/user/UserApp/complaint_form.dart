import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComplaintForm extends StatefulWidget {
  @override
  _ComplaintFormState createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ComplaintForm> {
  final _formKey = GlobalKey<FormState>();
  String? _orderNumber;
  String? _message;
  bool _isSubmitting = false;

  Future<void> _submitComplaint() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    setState(() {
      _isSubmitting = true;
    });

    final url =
        'https://yourapi.com/api/complaints'; // استبدل this ب URL الخاص بك
    final token = 'your_token'; // استبدل this بالتوكن الخاص بك

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'order_number': _orderNumber,
          'message': _message,
        }),
      );

      if (response.statusCode == 201) {
        // الشكوى تم تقديمها بنجاح
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Complaint submitted successfully.')),
        );
      } else {
        // خطأ في تقديم الشكوى
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit complaint.')),
        );
      }
    } catch (error) {
      // خطأ في الاتصال
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again later.')),
      );
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit a Complaint'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Order Number (Optional)'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _orderNumber = value;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Message'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your message';
                  }
                  return null;
                },
                onSaved: (value) {
                  _message = value;
                },
              ),
              SizedBox(height: 16.0),
              _isSubmitting
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _submitComplaint,
                      child: Text('Submit Complaint'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
