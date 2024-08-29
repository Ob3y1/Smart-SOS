class UserHome {
  bool? success;
  List<Requests>? requests;

  UserHome({this.success, this.requests});

  UserHome.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['requests'] != null) {
      requests = <Requests>[];
      json['requests'].forEach((v) {
        requests!.add(new Requests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.requests != null) {
      data['requests'] = this.requests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Requests {
  int? id;
  int? groupId;
  int? emergencyRequestId;
  String? carNumber;
  String? job;
  String? site;
  int? requestStatus;

  Requests(
      {this.id,
      this.groupId,
      this.emergencyRequestId,
      this.carNumber,
      this.job,
      this.site,
      this.requestStatus});

  Requests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['group_id'];
    emergencyRequestId = json['emergency_request_id'];
    carNumber = json['car_number'];
    job = json['job'];
    site = json['site'];
    requestStatus = json['request_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['group_id'] = this.groupId;
    data['emergency_request_id'] = this.emergencyRequestId;
    data['car_number'] = this.carNumber;
    data['job'] = this.job;
    data['site'] = this.site;
    data['request_status'] = this.requestStatus;
    return data;
  }
}