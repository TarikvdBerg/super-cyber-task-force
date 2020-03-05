
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:SCTFPasswordManager/core/models.dart';
import 'package:http/http.dart' as http;

class API {
  static String baseURL = "http://homeland.nvmtech.nl/";
  static String apiURL = baseURL + "api/";
  static String userURL = apiURL + "users/";

  String authToken = null;

  Map<String,String> getHeaders() {

    if (authToken != null) {
      return {HttpHeaders.authorizationHeader: "Token $authToken"};
    }
    return {};
  }

  void authenticate(String username, String password) async {
    if (authToken != null) {
      throw Exception("Client already authenticated, use .deAuthenticate to logout first");
    }

    final resp = await http.post(baseURL+"auth/login/", body: {"username": username, "password": password});

    if (resp.statusCode == 200) {
      print("Authenticatedd");
      
      Map<String, String> tokenData = json.decode(resp.body);

      this.authToken = tokenData["authentication_token"];
    } else {
      throw Exception("User authentication failed");
    }
  }

  deAuthenticate() {
    if (authToken == null) {
      throw Exception("Client is not authenticated");
    }
  }

  Future<UserModel> fetchUser(String id) async {
    final resp = await http.get(apiURL+'users/$id', headers: getHeaders());

    if (resp.statusCode == 200) {
      return UserModel.fromJSON(json.decode(resp.body));
    } else {
      throw Exception("Failed to load user");
    }
  }

  Future<UserModel> createUser(UserModel user) async {
    final resp = await http.post(userURL, body: user.toJSON());

    if (resp.statusCode == 200) {
      return UserModel.fromJSON(json.decode(resp.body));
    } else {
      throw Exception({"error": "Failed to create a user", "reason": resp.statusCode});
    }
  }
}