import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/cubit/user_cubit.dart';
import 'package:flutter_application_1/core/cubit/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'complaint_form.dart'; // تأكد من استيراد صفحة تقديم الشكوى

class ComplaintsListPage extends StatefulWidget {
  const ComplaintsListPage({super.key});

  @override
  _ComplaintsListPageState createState() => _ComplaintsListPageState();
}

class _ComplaintsListPageState extends State<ComplaintsListPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().fetchComplaints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaints List'),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is ComplaintsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ComplaintsLoaded) {
            // Reverse the list to show the latest complaint first
            final reversedComplaints = List.from(state.complaints.reversed);

            return ListView.builder(
              itemCount: reversedComplaints.length,
              itemBuilder: (context, index) {
                final complaint = reversedComplaints[index];
                return Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(
                      complaint.message,
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      children: [
                        Text(
                          'Status: ${complaint.status.name}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        Text(
                          'responcedir: ${complaint.responcedir ?? "لايوجد رد"}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),

                    // Optionally, add an onTap callback for further actions
                    onTap: () {
                      // Handle the tap event if needed
                    },
                  ),
                );
              },
            );
          } else if (state is ComplaintsError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  ComplaintForm(), // Replace with your form page
            ),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Add Complaint',
      ),
    );
  }
}
