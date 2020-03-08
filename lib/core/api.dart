
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:SCTFPasswordManager/core/exceptions.dart';
import 'package:SCTFPasswordManager/core/models.dart';
import 'package:http/http.dart' as http;

class API {
  static String baseURL = "http://homeland.nvmtech.nl:80/"; // The URL to send all of the requests to
  static String apiURL = baseURL + "api/"; // The endpoint to send API requests to
  static String userURL = apiURL + "users/"; // The endpoint to send user related requests to
  static String passwordGroupURL = apiURL + "pw_groups/"; // The endpoint to send password group related requests to
  static String passwordURL = apiURL + "passwords/"; // The endpoint to send user related requests to

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
      case 400:
        throw BadRequestException(resp.body);
        break;

      case 401:
        throw RequestNotAuthenticatedException(resp.request.url.toString());
        break;

      // Handle unauthenticated requests
      case 403:
        throw RequestForbiddenException(resp.request.url.toString());
        break;
      
      // Handle not found request
      case 404:
        throw ModelDoesNotExistException(data['id']);
    }
  }

  // authenticate sends an authentication request to the backend. It takes in an username and password
  // and sets the local authToken variable to the retrieved token if the request was succesfull.
  // It throws an Exception is anything went wrong during the authentication process.
  Future<bool> authenticate(String username, String password) async {
    if (authToken != null) {
      return true;
    }

    Map<String, String> payload = {"username": username, "password": password};

    final resp = await http.post(baseURL+"auth/login", body: json.encode(payload), headers: getHeaders());

    verifyCommonResponses(resp);
    
    if (resp.statusCode == 200) {
      dynamic tokenData = json.decode(resp.body);
      this.authToken = tokenData["token"];
      return true;
    } else {
      throw Exception(resp.statusCode);
    }
  }

  // Deletes the local authentication token
  deAuthenticate() {
    if (authToken == null) {
      throw Exception("Client is not authenticated");
    }

    this.authToken = null;
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

  // Updates the user information on the server. Takes in a UserModel and returns
  // an updated UserModel if the action was succesfull, throws exceptions based on
  // failure of the action.
  Future<UserModel> updateUser(UserModel user) async {
    String uid = user.id;
    final resp = await http.put(userURL+"$uid/", body: json.encode(user.toJSON()), headers: getHeaders());
    
    verifyCommonResponses(resp);

    if (resp.statusCode == 200) {
      return UserModel.fromJSON(json.decode(resp.body));
    } else {
      throw Exception('Unknown error');
    }
  }

  // Removes a user account from the server, takes in a UserModel and returns true
  // if the action was succesfull. Throws Exceptions if anything goes wrong that
  // needs explanation.
  Future<bool> deleteUser(UserModel user) async {
    String uid = user.id;
    final resp = await http.delete(userURL+"$uid/", headers: getHeaders());

    verifyCommonResponses(resp);

    if (resp.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to delete user");
    }
  }

  Future<List<PasswordGroupModel>> fetchAllGroups() async {
    final resp = await http.get(passwordGroupURL, headers: getHeaders());

    verifyCommonResponses(resp);

    if (resp.statusCode == 200) {
      return parsePasswordGroups(resp.body);
    } else {
      throw Exception();
    }
  }

  Future<PasswordGroupModel> fetchGroup(String id) async {
    final resp = await http.get(passwordGroupURL+"$id/", headers: getHeaders());

    verifyCommonResponses(resp);

    if (resp.statusCode == 200) {
      return PasswordGroupModel.fromJSON(json.decode(resp.body));
    } else {
      throw Exception();
    }
  }

  Future<PasswordGroupModel> createGroup(PasswordGroupModel group) async {
    final resp = await http.post(passwordGroupURL, body: json.encode(group.toJSON()), headers: getHeaders());
    verifyCommonResponses(resp);

    if (resp.statusCode == 200) {
      return PasswordGroupModel.fromJSON(json.decode(resp.body));
    } else {
      throw Exception();
    }
  }

  Future<PasswordGroupModel> updateGroup(PasswordGroupModel group) async {
    String pgid = group.id;
    final resp = await http.put(passwordGroupURL+"$pgid/", body: json.encode(group.toJSON()), headers: getHeaders());
    
    verifyCommonResponses(resp);

    if (resp.statusCode == 200) {
      return PasswordGroupModel.fromJSON(json.decode(resp.body));
    } else {
      throw Exception();
    }
  }

  Future<bool> deleteGroup(PasswordGroupModel group) async {
    String pgid = group.id;
    final resp = await http.delete(passwordGroupURL+"$pgid/", headers: getHeaders());

    verifyCommonResponses(resp);

    if (resp.statusCode == 200) {
      return true;
    } else {
      throw Exception();
    }
  }

  Future<List<PasswordModel>> fetchAllPasswords() async {
    final resp = await http.get(passwordURL, headers: getHeaders());

    verifyCommonResponses(resp);

    print(resp.statusCode);

    if (resp.statusCode == 200) {
      return parsePasswords(resp.body);
    } else {
      throw Exception();
    }
  }

  Future<PasswordModel> fetchPassword(String id) async {
    final resp = await http.get(passwordURL+"$id/", headers: getHeaders());

    verifyCommonResponses(resp);

    if (resp.statusCode == 200) {
      return PasswordModel.fromJSON(json.decode(resp.body));
    } else {
      throw Exception();
    }
  }

  Future<PasswordModel> createPassword(PasswordModel password) async {
    final resp = await http.post(passwordURL, body: json.encode(password.toJSON()), headers: getHeaders());
    
    verifyCommonResponses(resp, {"id": "none"});

    if (resp.statusCode == 200) {
      return PasswordModel.fromJSON(json.decode(resp.body));
    } else {
      throw Exception();
    }
  }

  Future<PasswordModel> updatePassword(PasswordModel password) async {
    String pid = password.id;
    final resp = await http.put(passwordURL+"$pid/", body: json.encode(password.toJSON()), headers: getHeaders());

    try {
      verifyCommonResponses(resp, {"id": pid});
    } catch (e) {
      print(e.errorMessage());
    }
    print(resp.statusCode);
    if (resp.statusCode == 200) {
      return PasswordModel.fromJSON(json.decode(resp.body));
    } else {  
      throw Exception();
    }
  }

  Future<bool> deletePassword(PasswordModel password) async {
    String pid = password.id;
    final resp = await http.delete(passwordURL+"$pid/", headers: getHeaders());

    verifyCommonResponses(resp);

    if (resp.statusCode == 200) {
      return true;
    } else {
      throw Exception();
    }
  }
}