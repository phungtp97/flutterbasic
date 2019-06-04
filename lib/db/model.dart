class User{
  String id;
  String password;

  User({this.id, this.password});

  factory User.fromMap(Map<String, dynamic> json) => User(
    id : json['id'],
    password : json['password']
  );
}

class Chat{
  String id;
  String sender;
  String message;

  Chat({this.id, this.sender, this.message});

  factory Chat.fromMap(Map<String, dynamic> json) => Chat(
    id: json['id'],
    sender: json['sender'],
    message: json['message']
  );
  static List<Chat> fromJsonList(List<dynamic> jsons) {
    List<Chat> objects = jsons.map((i) => Chat.fromMap(i)).toList();
    return objects;
  }
}