import 'package:hive_flutter/adapters.dart';

class LocalStorage {
  // Initialize Hive
  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox('credentials');
    await Hive.openBox('search_history');
  }

  // Save email and password
  Future<void> saveTokenExplicitly(String token) async {
    await init();
    var box = Hive.box('credentials');
    await box.put('token', token);
  }

  // Save email and password
  Future<String?> getTokenExplicitly() async {
    await init();
    var box = Hive.box('credentials');
    return await box.get('token');
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
    await box.delete('token');


    var boxHistory = Hive.box('search_history');
    await boxHistory.delete('queries');
  }

  Future<void> saveSearchQuery(String query) async {
    if (query.trim().isEmpty) return;
    await init();
    var box = Hive.box('search_history');
    List<String> history = List<String>.from(box.get('queries', defaultValue: []) as List);
    history.remove(query);
    history.insert(0, query);
    if (history.length > 20) {
      history = history.sublist(0, 10);
    }

    await box.put('queries', history);
  }

  Future<List<String>> getSearchHistory() async {
    await init();
    var box = Hive.box('search_history');
    return List<String>.from(box.get('queries', defaultValue: []) as List);
  }
}
