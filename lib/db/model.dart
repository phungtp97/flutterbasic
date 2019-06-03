class User{
  String id;
  String password;

  User({this.id, this.password});

  User.fromMap(Map<String, dynamic> json) {
    this.id = json['id'];
    this.password = json['password'];
  }
}