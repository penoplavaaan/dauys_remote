import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class LocalStorage {
  // Initialize Hive
  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox('credentials');
  }

  // Save email and password
  Future<void> saveCredentials(String email, String password) async {
    await init();
    var box = Hive.box('credentials');
    await box.put('email', email);
    await box.put('password', password);
  }

  // Retrieve email
  Future<String?> getEmail() async {
    await init();
    var box = Hive.box('credentials');
    return box.get('email');
  }

  // Retrieve password
  Future<String?> getPassword() async {
    await init();
    var box = Hive.box('credentials');
    return box.get('password');
  }

  // Clear credentials
  Future<void> clearCredentials() async {
    await init();
    var box = Hive.box('credentials');
    await box.delete('email');
    await box.delete('password');
  }
}
