class UserShow {
  bool? success;
  User? user;
  String? phoneNumber;

  UserShow({this.success, this.user, this.phoneNumber});

  UserShow.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['phone_number'] = this.phoneNumber;
    return data;
  }
}

class User {
  int? id;
  String? name;
  int? otpId;
  String? dateOfBirth;
  String? gender;
  String? createdAt;
  String? updatedAt;
  int? role;
  Otp? otp;

  User(
      {this.id,
      this.name,
      this.otpId,
      this.dateOfBirth,
      this.gender,
      this.createdAt,
      this.updatedAt,
      this.role,
      this.otp});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    otpId = json['otp_id'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    role = json['role'];
    otp = json['otp'] != null ? new Otp.fromJson(json['otp']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['otp_id'] = this.otpId;
    data['date_of_birth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['role'] = this.role;
    if (this.otp != null) {
      data['otp'] = this.otp!.toJson();
    }
    return data;
  }
}

class Otp {
  int? id;
  String? identifier;
  String? token;
  int? validity;
  int? valid;
  String? createdAt;
  String? updatedAt;

  Otp(
      {this.id,
      this.identifier,
      this.token,
      this.validity,
      this.valid,
      this.createdAt,
      this.updatedAt});

  Otp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    identifier = json['identifier'];
    token = json['token'];
    validity = json['validity'];
    valid = json['valid'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['identifier'] = this.identifier;
    data['token'] = this.token;
    data['validity'] = this.validity;
    data['valid'] = this.valid;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
