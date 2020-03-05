
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:SCTFPasswordManager/core/exceptions.dart';
import 'package:SCTFPasswordManager/core/models.dart';
import 'package:http/http.dart' as http;

class API {
  static String baseURL = "http://homeland.nvmtech.nl/"; // The URL to send all of the requests to
  static String apiURL = baseURL + "api/"; // The endpoint to send API requests to
  static String userURL = apiURL + "users/"; // The endpoint to send user related requests to

  String authToken; // The current authentication token for the API, if null the API is not
                    // authenticated.

  // Builds a Map<String, String> with the proper HTTP request headers, by default it sets
  // the content-type to application/json. If the authToken variable is set it integrates
  // this into the authorization header.
  Map<String,String> getHeaders() {
    if (authToken != null) {
      return {
        HttpHeaders.authorizationHeader: "Token $authToken",
        HttpHeaders.contentTypeHeader: "application/json"
      };
    }
    return {
      HttpHeaders.contentTypeHeader: "application/json"
    };
  }

  // Verifies common issues with the responses from the server such as 404, 500,
  // 403 and more. 
  void verifyCommonResponses(http.Response resp, [Map<String, dynamic> data]) {

    switch (resp.statusCode) {
      // Handle unauthenticated requests
      case 403:
        throw RequestNotAuthenticatedException(resp.request.url.toString());
        break;
      
      // Handle not found request
      case 404:
        throw ModelDoesNotExistException(data['id']);
    }

  }

  // authenticate sends an authentication request to the backend. It takes in an username and password
  // and sets the local authToken variable to the retrieved token if the request was succesfull.
  // It throws an Exception is anything went wrong during the authentication process.
  void authenticate(String username, String password) async {
    if (authToken != null) {
      throw Exception("Client already authenticated, use .deAuthenticate to logout first");
    }

    Map<String, String> payload = {"username": username, "password": password};

    final resp = await http.post(baseURL+"auth/login", body: json.encode(payload));
    
    if (resp.statusCode == 200) {
      print("Authenticatedd");
      
      Map<String, String> tokenData = json.decode(resp.body);

      this.authToken = tokenData["authentication_token"];
    } else {
      throw Exception("User authentication failed");
    }
  }

  // Deletes the local authentication token and notifies the server that the
  // authentication token can be invalidated.
  // TODO: Implement
  void deAuthenticate() {
    if (authToken == null) {
      throw Exception("Client is not authenticated");
    }
  }

  // Retrieves user information from the server. Takes in an UUID and
  // retursna Usermodel or an exception
  Future<UserModel> fetchUser(String id) async {
    final resp = await http.get(apiURL+'users/$id', headers: getHeaders());

    verifyCommonResponses(resp);

    if (resp.statusCode == 200) {
      return UserModel.fromJSON(json.decode(resp.body));
    } else if (resp.statusCode == 404) {
      throw ModelDoesNotExistException(id);
    } else {
      throw Exception("Failed to load user");
    }
  }


  // Asks the server to create a new user in the databse, a filled in UserModel is required
  // along with the target password of the user to be made. If creation of the user is
  // unsuccesfull the function throws an Exception to notify the caller.
  Future<UserModel> createUser(UserModel user, String password) async {
    // Build payload
    Map<String, String> payload = user.toJSON();
    payload.addAll({"password": password});

    final resp = await http.post(userURL, body: json.encode(payload), headers: getHeaders());

    if (resp.statusCode == 201) {
      return UserModel.fromJSON(json.decode(resp.body));
    } else {
      if (resp.statusCode == 400 && resp.body.contains("username already exists")) {
        throw ModelAlreadyExistsException("User");
      } else {
        throw Exception({"status": resp.statusCode, "reason": resp.body});
      }
    }
  }
}