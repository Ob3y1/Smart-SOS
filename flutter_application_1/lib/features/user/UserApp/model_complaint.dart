import 'package:equatable/equatable.dart';

// Define models
class Complaint extends Equatable {
  final int id;
  final int userId;
  final String message;
  final String? responcedir;
  final int cStatusId;
  final String createdAt;
  final String updatedAt;
  final Status status;

  Complaint({
    required this.id,
    required this.userId,
    required this.message,
    this.responcedir,
    required this.cStatusId,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      id: json['id'],
      userId: json['user_id'],
      message: json['message'],
      responcedir: json['responcedir'],
      cStatusId: json['c_status_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      status: Status.fromJson(json['status']),
    );
  }

  @override
  List<Object?> get props => [id, userId, message, responcedir, cStatusId, createdAt, updatedAt, status];
}

class Status extends Equatable {
  final int id;
  final String name;

  Status({
    required this.id,
    required this.name,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  List<Object?> get props => [id, name];
}

class ComplaintsResponse extends Equatable {
  final bool success;
  final List<Complaint> data;

  ComplaintsResponse({
    required this.success,
    required this.data,
  });

  factory ComplaintsResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Complaint> complaintsList = list.map((i) => Complaint.fromJson(i)).toList();

    return ComplaintsResponse(
      success: json['success'],
      data: complaintsList,
    );
  }

  @override
  List<Object?> get props => [success, data];
}
