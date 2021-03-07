class LoginModel {
  String username;
  String password;

  LoginModel({
    this.username,
    this.password,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }
}

class LoginResponseModel {
  int errorCode;
  String errorDesc;
  String data;

  LoginResponseModel({this.errorCode, this.errorDesc, this.data});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    errorDesc = json['error_desc'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error_code'] = this.errorCode;
    data['error_desc'] = this.errorDesc;
    data['data'] = this.data;
    return data;
  }
}
