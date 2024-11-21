import 'dart:convert';
import 'package:http/http.dart' as http;

import '../storage/local_storage.dart';

const String baseUrl = 'https://dligjs37pj7q2.cloudfront.net';

class Api {
  final LocalStorage localStorage = LocalStorage();
  String? bearerToken;

  // Method to make GET requests with optional query parameters and Bearer token
  Future<dynamic> makeGet(String endpoint, {Map<String, String>? queryParams}) async {
    Uri uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParams);
    final response = await http.get(
      uri,
      headers: _buildHeaders(),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  // Method to make POST requests with Bearer token
  Future<dynamic> makePost(String endpoint, Map<String, dynamic> data) async {
    print('making POST qeury');
    print('endpoint:');
    print(endpoint);
    print('data: ');
    print(data);
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: _buildHeaders(),
      body: json.encode(data),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('response');
      print(json.decode(response.body));

      return json.decode(response.body);
    } else {
      print(json.decode(response.body));

      throw Exception('Failed to post data: ${response.statusCode}');
    }
  }

  // Private method to build headers
  Map<String, String> _buildHeaders() {
    final headers = {'Content-Type': 'application/json'};
    if (bearerToken != null) {
      headers['Authorization'] = 'Bearer $bearerToken';
    }
    return headers;
  }

  // Method to authenticate and get Bearer token
  Future<void> getBearerToken() async {
    final email = await localStorage.getEmail();
    final password = await localStorage.getPassword();

    if (email != null && password != null) {
      final data = {
        'email': email,
        'password': password,
      };
      final response = await makePost('/api/v1/auth/authenticate', data);
      bearerToken = response['token']; // Assuming the token is returned in this format
    } else {
      throw Exception('Email or password not found in local storage.');
    }
  }

  Future<void> login(String email, String password) async {
    await localStorage.saveCredentials(email, password);
    await getBearerToken();
  }

}
