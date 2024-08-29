import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/cubit/user_cubit.dart';
import 'package:flutter_application_1/core/cubit/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ComplaintForm extends StatefulWidget {
  const ComplaintForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ComplaintFormState createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ComplaintForm> {
  final _formKey = GlobalKey<FormState>();

  String? ms;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit a Complaint'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Message'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your message';
                  }
                  return null;
                },
                onChanged: (value) {
                  ms = value;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (ms == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("يرجى ادخال شكوى")),
                    );
                  } else {
                    context.read<UserCubit>().submitComplaint(ms!,context);
                  }
                },
                child: const Text('Submit Complaint'),
              ),
              BlocConsumer<UserCubit, UserState>(listener: (context, state) {
                if (state is ComplaintsSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              }, builder: (context, state) {
                if (state is ComplaintsInitial) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  ); // Show loading indicator
                }
                return SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
