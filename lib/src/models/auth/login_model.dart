class LoginModel {
  String email;
  String password;

  LoginModel({
    this.email,
    this.password,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}

class LoginResponseModel {
  bool status;
  String type;
  String token;
  String message;

  LoginResponseModel({this.status, this.type, this.token});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'];
    token = json['token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['type'] = this.type;
    data['token'] = this.token;
    data['message'] = this.message;
    return data;
  }
}
