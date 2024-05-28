class User{
  int userid;
  String firstname;
  String lastname;
  String email;
  String password;
  String phonenumber;
  String type;

  User({
    required this.userid,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    required this.phonenumber,
    required this.type
  });

  Map<String, dynamic> toJson(){
    return {
      "UserID": this.userid,
      "FirstName": this.firstname,
      "LastName": this.lastname,
      "Email": this.email,
      "Password": this.password,
      "PhoneNumber": this.phonenumber,
      "Type": this.type
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userid: json["UserID"] ?? '',
        firstname: json["FirstName"] ?? '',
        lastname: json["LastName"] ?? '',
        email: json["Email"] ?? '',
        password: json["Password"] ?? '',
        phonenumber: json["PhoneNumber"] ?? '',
        type: json["Type"] ?? ''
    );
  }
}
