import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/collection.dart';
import '../storage/local_storage.dart';
import '../models/user_model.dart';

const String baseUrl = 'https://dligjs37pj7q2.cloudfront.net';

class Api {
  final LocalStorage localStorage = LocalStorage();
  late String _bearerToken;

  Api._(this._bearerToken);

  static Future<Api> createFirstTime() async {
    final api = Api._(" ");
    return api;
  }

  static Future<Api> create() async {
    final localStorage = LocalStorage();
    final email = await localStorage.getEmail(); // Assume this is asynchronous
    final password = await localStorage.getPassword(); // Assume this is asynchronous

    if (email != null && password != null) {
      final api = Api._(await _initializeBearerToken(email, password));
      return api; // Return an instance of Api with the token
    } else {
      throw Exception('Email or password not found in local storage.');
    }
  }

  static Future<String> _initializeBearerToken(String email, String password) async {
    final data = {
      'email': email,
      'password': password,
    };
    final response = await _makePost('/api/v1/auth/authenticate', data); // Call to authenticate
    return response['access_token']; // Return the token
  }

  Future<void> login(String email, String password) async {
    _bearerToken = await _initializeBearerToken(email, password);
    await localStorage.saveCredentials(email, password); // Save email for future use
  }

  static Future<dynamic> _makePost(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    print('POST request:');
    print('endpoint: $endpoint');
    print('data:');
    print(data);
    print('response statusCode: ${response.statusCode}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to post data: ${response.statusCode}');
    }
  }

  Future<dynamic> makeGet(String endpoint, {Map<String, String>? queryParams}) async {
    Uri uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParams);
    final headers = await _buildHeaders();

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<Map<String, String>> _buildHeaders() async {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_bearerToken', // Use the stored token
    };
  }

  Future<User> getUserSettings() async {
    final responseJson = await makeGet('/api/v1/users/getSettings');
    return User.fromJson(responseJson);
  }

  Future<List<Collection>> getAllCollections() async {
    final responseJson = await makeGet('/api/songs/getAllCollections');

    // Convert the response into a List of Collections
    List<Collection> collections = (responseJson as List)
        .map((json) => Collection.fromJson(json))
        .toList();

    return collections;
  }
}
