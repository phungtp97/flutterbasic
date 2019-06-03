class User{
  String id;
  String password;

  User({this.id, this.password});

  factory User.fromMap(Map<String, dynamic> json) => User(
    id : json['id'],
    password : json['password']
  );
}