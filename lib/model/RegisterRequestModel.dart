class RegisterRequestModel{
   String? name;
   String? email;
   String? password;
   String? password_confirmation;

  RegisterRequestModel({this.name, this.email, this.password, this.password_confirmation});

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    password_confirmation = json['password_confirmation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['password_confirmation'] = this.password_confirmation;
    return data;
  }
}
