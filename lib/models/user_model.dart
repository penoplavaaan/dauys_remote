// lib/models/user_model.dart

class User {
  final String userMail;
  final String mobile;
  final String username;
  final String? language;

  User({
    required this.userMail,
    required this.mobile,
    required this.username,
    this.language,
  });

  // Factory method to create a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userMail: json['userMail'],
      mobile: json['mobile'],
      username: json['username'],
      language: json['language'],
    );
  }

  // Method to convert User to JSON
  Map<String, dynamic> toJson() {
    return {
      'userMail': userMail,
      'mobile': mobile,
      'username': username,
      'language': language,
    };
  }
}
