import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/collection.dart';
import '../models/song_new.dart';
import '../models/user_collection.dart';
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
    final token = await localStorage.getTokenExplicitly();

    if (token != null) {
      final api = Api._(token);
      return api;
    }

    if (email != null && password != null) {
      final api = Api._(await _initializeBearerToken(email, password));
      return api; // Return an instance of Api with the token
    } else {
      throw Exception('Email, password or bearerToken not found in local storage.');
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

  Future<dynamic> _makeDelete(String endpoint, {Map<String, String>? queryParams}) async {
    Uri uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParams);
    final headers = await _buildHeaders();

    final response = await http.delete(uri, headers: headers);


    print('DELETE request:');
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

  Future<List<UserCollection>> getAllUserCollections() async {
    final responseJson = await _makeGet('/api/v1/userdata/userPlaylist');

    // Convert the response into a List of Collections
    List<UserCollection> collections = (responseJson as List)
        .map((json) => UserCollection.fromJson(json))
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
    print('responseJson');
    print(responseJson);
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

  Future<dynamic> getFavourites() async {
     final queryParams = {
      'page': '0',
      'size': '500',
    };

    return await _makeGet('/api/v1/userdata/favoritesList', queryParams: queryParams);
  }

  Future<dynamic> getEvaluated() async {
    final queryParams = {
      'page': '0',
      'size': '500',
    };

    return await _makeGet('/api/v1/userdata/favoritesByStar', queryParams: queryParams);
  }

  Future<dynamic> getHistory() async {
    final queryParams = {
      'page': '0',
      'size': '500',
    };

    return await _makeGet('/api/v1/userdata/history', queryParams: queryParams);
  }

  Future<bool> authGoogle(String token) async {
    final data = {
      'accessToken': token,
    };

    try{
      _bearerToken =  (await _makePostNoAuth('/oauth2/mobile/google', data))['access_token'] ?? '';
      if (_bearerToken == ''){
        return false;
      }

      await localStorage.saveTokenExplicitly(_bearerToken);
      return true;
    }catch (e){
      print(e);
    }

    return true;
  }

  Future<bool> authFacebook(String token) async {
    final data = {
      'accessToken': token,
    };

    try{
      _bearerToken =  (await _makePostNoAuth('/oauth2/mobile/facebook', data))['access_token'] ?? '';
      print('fb token $_bearerToken');
      if (_bearerToken == ''){
        print('_bearerToken == ''');

        return false;
      }

      await localStorage.saveTokenExplicitly(_bearerToken);
      return true;
    }catch (e){
      print(e);
      return false;
    }

    return true;
  }

  Future<bool> toggleFavourites(int songId, bool inFavNow) async{
    try{
      if(inFavNow){
        final data = {
          'songId': songId,
        };

        await _makePost('/api/v1/userdata/addToFavorites', data);
      }
      else {
        await _makeDelete('/api/v1/userdata/favoritesdeleteSong/$songId');
      }
    } catch (e) {
      return false;
    }

    return true;
  }

  Future<bool> createNewPlaylist(String playlistName) async{
    try{
      final data = {
        'userPlayListName': playlistName,
      };

      await _makePost('/api/v1/userdata/createUserPlaylist', data);
    } catch (e) {
      return false;
    }

    return true;
  }

  Future<bool> addSongToPlaylist(int playlistId, int songId) async{
    try{
      final data = {
        "songsId": [
          songId
        ],
        "playListId": playlistId
      };

      await _makePost('/api/v1/userdata/addToPlaylist', data);
    } catch (e) {
      return false;
    }

    return true;
  }

  Future<bool> makeSubscription() async{
    try{
      final Map<String, String> query = {
        "subScriptionType": "PREMIUM"
      };

      await _makePostWithQuery('/api/v1/subscription/makeSubscription', queryParams: query);
    } catch (e) {
      return false;
    }

    return true;
  }

  Future<bool> removeSongFromPlaylist(int songId, int playlistId) async{
    try{
      await _makeDelete('/api/v1/userdata/$songId/$playlistId');
    } catch (e) {
      return false;
    }

    return true;
  }
}
