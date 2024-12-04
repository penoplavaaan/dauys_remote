import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/collection.dart';
import '../models/song_new.dart';
import '../storage/local_storage.dart';
import '../models/user_model.dart';


class Api {
  final LocalStorage localStorage = LocalStorage();
  late String _bearerToken;
  static const String baseUrl = 'https://dligjs37pj7q2.cloudfront.net';

  Api._(this._bearerToken);

  static Future<Api> createFirstTime() async {
    final api = Api._(" ");
    return api;
  }

  static Future<Api> create() async {
    final localStorage = LocalStorage();
    final email = await localStorage.getEmail();
    final password = await localStorage.getPassword();

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
    final response = await _makePostNoAuth('/api/v1/auth/authenticate', data); // Call to authenticate
    return response['access_token']; // Return the token
  }

  Future<void> login(String email, String password) async {
    _bearerToken = await _initializeBearerToken(email, password);
    await localStorage.saveCredentials(email, password); // Save email for future use
  }

  static Future<dynamic> _makePostNoAuth(String endpoint, Map<String, dynamic> data) async {
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
      print(response.body);
      throw Exception('Failed to post data: ${response.statusCode}');
    }
  }

  Future<dynamic> _makePost(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: await _buildHeaders(),
      body: json.encode(data),
    );

    print('POST request:');
    print('endpoint: $endpoint');
    print('data:');
    print(data);
    print('response statusCode: ${response.statusCode}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      try{
        return json.decode(utf8.decode(response.bodyBytes));
      } catch (e){
        return [];
      }
    } else {
      print(response.body);
      throw Exception('Failed to post data: ${response.statusCode}');
    }
  }

  Future<dynamic> _makeGet(String endpoint, {Map<String, String>? queryParams}) async {
    Uri uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParams);
    final headers = await _buildHeaders();

    final response = await http.get(uri, headers: headers);


    print('GET request:');
    print('endpoint: $endpoint');
    print('queryParams:');
    print('token :$_bearerToken');
    print(queryParams);
    print('response statusCode: ${response.statusCode}');
    if (response.statusCode == 200) {
      print('response:');
      print(response.body);
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<dynamic> _makePostWithQuery(String endpoint, {Map<String, String>? queryParams}) async {
    Uri uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParams);
    final headers = await _buildHeaders();

    final response = await http.post(uri, headers: headers);

    print('POST request with query:');
    print('endpoint: $endpoint');
    print('queryParams:');
    print('token :$_bearerToken');
    print(queryParams);
    print('response statusCode: ${response.statusCode}');
    if (response.statusCode == 200) {
      print('response:');
      print(response.body);
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
    final responseJson = await _makeGet('/api/v1/users/getSettings');
    return User.fromJson(responseJson);
  }

  Future<List<Collection>> getAllCollections() async {
    final responseJson = await _makeGet('/api/songs/getAllCollections');

    // Convert the response into a List of Collections
    List<Collection> collections = (responseJson as List)
        .map((json) => Collection.fromJson(json))
        .toList();

    return collections;
  }

  Future<SongNew> getSongById(int id) async {
    final responseJson = await _makeGet('/api/songs/$id');
    final songJson = responseJson['songs'][0];
    final songTextResponse = await _makeGet(songJson['songTextUri']);
    return SongNew.fromJsonWithText(songJson, songTextResponse['text']);
  }

  Future<User> getUserFullData() async {
    final responseJson = await _makeGet('/api/v1/users/getUser');
    final newUser = User.fromJson(responseJson);

    // Fetch existing user settings
    final existingUser = await getUserSettings();

    // Merge existing user settings with new data
    final mergedUser = existingUser.merge(newUser);
    return mergedUser;
  }

  Future<void> updateUserData({
    required String userMail,
    required String mobile,
    required String username,
    String language = "",
  }) async {
    final queryParams = {
      'userMail': userMail,
      'mobile': mobile,
      'username': username,
      'language': "ru",
    };

    await _makePostWithQuery('/api/v1/users/setSettings', queryParams: queryParams);
  }



  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
    required String newPasswordRepeat,
  }) async {
    final data = {
      'currentPassword': oldPassword,
      'newPassword': newPassword,
      'confirmationPassword': newPasswordRepeat
    };
    try{
      final response = await _makePost('/api/v1/users/changePassword', data);
      final email = await localStorage.getEmail();
      await localStorage.saveCredentials(email ?? '', newPassword);
    } catch (e){
      print('ошибка');
      print(e);
      return false;
    }
    return true;
  }

  Future<dynamic> fullTextSearch(String input) async {
    final queryParams = {
      'input': input,
      'sortBy': 'DEFAULT',
      'sortMethod': 'ASC',
      'size': '10',
    };
    return await _makeGet('/api/v1/search/fullTextSearch', queryParams: queryParams);
  }
}
