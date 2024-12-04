// lib/models/user_model.dart

class UserSubscription {
  final int id;
  final bool isPremium;
  final String subscriptionPlan;
  final bool? isExpired;
  final String? expirationDate;

  UserSubscription({
    required this.id,
    required this.isPremium,
    required this.subscriptionPlan,
    required this.isExpired,
    required this.expirationDate,
  });

  factory UserSubscription.fromJson(Map<String, dynamic> json) {
    return UserSubscription(
      id: json['id'],
      isPremium: json['isPremium'],
      subscriptionPlan: json['subscriptionPlan'],
      isExpired: json['isExpired'] ?? false,
      expirationDate: json['expirationDate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isPremium': isPremium,
      'subscriptionPlan': subscriptionPlan,
      'isExpired': isExpired,
      'expirationDate': expirationDate,
    };
  }
}

class User {
  final String userMail;
  final String mobile;
  final String username;
  final String? language;
  final int? id;
  final String? deviceId;
  final String? registeredDate;
  final bool? accountBlocked;
  final String? userRole;
  final UserSubscription? userSubscription;
  final List<dynamic>? userPaymentHistory;

  User({
    required this.userMail,
    required this.mobile,
    required this.username,
    this.language,
    this.id,
    this.deviceId,
    this.registeredDate,
    this.accountBlocked,
    this.userRole,
    this.userSubscription,
    this.userPaymentHistory,
  });

  // Factory method to create a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userMail: json['userMail'] ?? '',
      mobile: json['mobile'] ?? '',
      username: json['username'] ?? '',
      language: json['language'],
      id: json['id'],
      deviceId: json['deviceId'],
      registeredDate: json['registeredDate'],
      accountBlocked: json['accountBlocked'],
      userRole: json['userRole'],
      userSubscription: json['userSubscription'] != null
          ? UserSubscription.fromJson(json['userSubscription'])
          : null,
      userPaymentHistory: json['userPaymentHistory'],
    );
  }

  // Method to convert User to JSON
  Map<String, dynamic> toJson() {
    return {
      'userMail': userMail,
      'mobile': mobile,
      'username': username,
      'language': language,
      'id': id,
      'deviceId': deviceId,
      'registeredDate': registeredDate,
      'accountBlocked': accountBlocked,
      'userRole': userRole,
      'userSubscription': userSubscription?.toJson(),
      'userPaymentHistory': userPaymentHistory,
    };
  }

  // Merging two User instances
  User merge(User newUser) {
    return User(
      userMail: userMail.isNotEmpty ? userMail : newUser.userMail,
      mobile: mobile.isNotEmpty ? mobile : newUser.mobile,
      username: username.isNotEmpty ? username : newUser.username,
      language: language ?? newUser.language,
      id: id ?? newUser.id,
      deviceId: deviceId ?? newUser.deviceId,
      registeredDate: registeredDate ?? newUser.registeredDate,
      accountBlocked: accountBlocked ?? newUser.accountBlocked,
      userRole: userRole ?? newUser.userRole,
      userSubscription: userSubscription ?? newUser.userSubscription,
      userPaymentHistory: userPaymentHistory ?? newUser.userPaymentHistory,
    );
  }
}
