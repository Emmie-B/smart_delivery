
class StaffData {
  String? success;
  List<Data>? data;

  StaffData({this.success, this.data});

  StaffData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['data'] = this.data!.map((v) => v.toJson()).toList();
    return data;
  }
}

class Data {
  String? id;
  String? clintId;
  String? firstname;
  String? lastname;
  String? phone;
  String? email;
  String? password;
  String? priviledge;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.clintId,
      this.firstname,
      this.lastname,
      this.phone,
      this.email,
      this.password,
      this.priviledge,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clintId = json['clint_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    priviledge = json['priviledge'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['clint_id'] = clintId;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    data['priviledge'] = priviledge;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
