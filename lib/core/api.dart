
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
  void verifyCommonResponses(http.Response resp) {

    switch (resp.statusCode) {
      case 400:
        throw BadRequestException(resp.body);
        break;

      // Handle unauthenticated requests
      case 401:
        throw RequestNotAuthenticatedException(resp.request.url.toString());
        break;

      // Handle forbidden requests
      case 403:
        throw RequestForbiddenException(resp.request.url.toString());
        break;
      
      // Handle not found request 
      case 404:
        throw ModelDoesNotExistException("");
        break;

      // Handle internal server errors
      case 500:
        throw ServerErrorException(resp.body);
        break;
    }
  }

  // authenticate sends an authentication request to the backend. It takes in an username and password
  // and sets the local authToken variable to the retrieved token if the request was succesfull.
  // It throws an Exception is anything went wrong during the authentication process.
  Future<AuthTokenModel> authenticate(String username, String password) async {
    if (authToken != null) {
      return null;
    }

    Map<String, String> payload = {"username": username, "password": password};

    final resp = await http.post(baseURL+"auth/login", body: json.encode(payload), headers: getHeaders());

    verifyCommonResponses(resp);
    
    if (resp.statusCode == 200) {
      Map<String, dynamic> tokenData = json.decode(resp.body);
      AuthTokenModel authToken = AuthTokenModel.fromMap(tokenData);
      this.authToken = authToken.authenticationToken;
      return authToken;
    } else {
      throw UnknownResponseException(resp.statusCode, resp.body);
    }
  }

  // Deletes the local authentication token
  void deAuthenticate() {
    this.authToken = null;
  }

  // Retrieves user information from the server. Takes in an UUID and
  // retursna Usermodel or an exception
  Future<UserModel> fetchUser(String id) async {
    final resp = await http.get(apiURL+'users/$id/', headers: getHeaders());

    verifyCommonResponses(resp);

    if (resp.statusCode == 200) {
      return UserModel.fromMap(json.decode(resp.body));
    } else {
      throw UnknownResponseException(resp.statusCode, resp.body);
    }
  }


  // Asks the server to create a new user in the database, a filled in UserModel is required
  // along with the target password of the user to be made. If creation of the user is
  // unsuccesfull the function throws an Exception to notify the caller.
  Future<UserModel> createUser(UserModel user, String password) async {
    // Build payload
    Map<String, dynamic> payload = user.toMap();
    payload.addAll({"password": password});

    final resp = await http.post(userURL, body: json.encode(payload), headers: getHeaders());

    if (resp.statusCode == 201) {
      return UserModel.fromMap(json.decode(resp.body));
    } else {
      if (resp.statusCode == 400 && resp.body.contains("username already exists")) {
        throw ModelAlreadyExistsException("User");
      } else {
        throw UnknownResponseException(resp.statusCode, resp.body);
      }
    }
  }

  // Updates the user information on the server. Takes in a UserModel and returns
  // an updated UserModel if the action was succesfull, throws exceptions based on
  // failure of the action.
  Future<UserModel> updateUser(UserModel user, String password) async {
    Map<String, dynamic> payload = user.toMap();
    payload.addAll({"password": password});
    String uid = user.id;
    final resp = await http.put(userURL+"$uid/", body: json.encode(payload), headers: getHeaders());
    print(resp.body);
    verifyCommonResponses(resp);

    if (resp.statusCode == 200) {
      return UserModel.fromMap(json.decode(resp.body));
    } else {
      throw UnknownResponseException(resp.statusCode, resp.body);
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
      throw UnknownResponseException(resp.statusCode, resp.body);
    }
  }

  // Fetches all groups from the server, returns a list of PasswordGroupModels if
  // the fetch was succesfull, throws exceptions based on what went wrong
  Future<List<PasswordGroupModel>> fetchAllGroups() async {
    final resp = await http.get(passwordGroupURL, headers: getHeaders());

    verifyCommonResponses(resp);

    if (resp.statusCode == 200) {
      return parsePasswordGroups(resp.body);
    } else {
      throw UnknownResponseException(resp.statusCode, resp.body);
    }
  }

  // Fetches a single group from the server identified by the provided ID. Returns
  // eihther the passwordgroupmodel or throws an exceptiono according to what went wrong.
  Future<PasswordGroupModel> fetchGroup(String id) async {
    final resp = await http.get(passwordGroupURL+"$id/", headers: getHeaders());

    verifyCommonResponses(resp);

    if (resp.statusCode == 200) {
      return PasswordGroupModel.fromMap(json.decode(resp.body));
    } else {
      throw UnknownResponseException(resp.statusCode, resp.body);
    }
  }

  // Creates a new password group based on the provided PasswordGrouppModel. Returns the
  // created group if successfull otherwise throws an exception based on what went wrong.
  Future<PasswordGroupModel> createGroup(PasswordGroupModel group) async {
    final resp = await http.post(passwordGroupURL, body: json.encode(group.toMap()), headers: getHeaders());
    verifyCommonResponses(resp);

    if (resp.statusCode == 200) {
      return PasswordGroupModel.fromMap(json.decode(resp.body));
    } else {
      throw UnknownResponseException(resp.statusCode, resp.body);
    }
  }

  // Updates a passwordgroup based on the group model provided. Returns the newly udated
  // PasswordGroup if succesful otherwise throws an exception based on what went wrong.
  Future<PasswordGroupModel> updateGroup(PasswordGroupModel group) async {
    String pgid = group.id;
    final resp = await http.put(passwordGroupURL+"$pgid/", body: json.encode(group.toMap()), headers: getHeaders());
    
    verifyCommonResponses(resp);

    if (resp.statusCode == 200) {
      return PasswordGroupModel.fromMap(json.decode(resp.body));
    } else {
      throw UnknownResponseException(resp.statusCode, resp.body);
    }
  }

  // Deletes a PasswordGroup from the server, returns true if succesfull or throws an
  // exception based on what went wrong.
  Future<bool> deleteGroup(PasswordGroupModel group) async {
    String pgid = group.id;
    final resp = await http.delete(passwordGroupURL+"$pgid/", headers: getHeaders());

    verifyCommonResponses(resp);

    if (resp.statusCode == 200) {
      return true;
    } else {
      throw UnknownResponseException(resp.statusCode, resp.body);
    }
  }

  // Fetches all passwords from the server, returns a List of PasswordModel if succesful,
  // throws exceptions based on what went wrong.
  Future<List<PasswordModel>> fetchAllPasswords() async {
    final resp = await http.get(passwordURL, headers: getHeaders());

    verifyCommonResponses(resp);

    if (resp.statusCode == 200) {
      return parsePasswords(resp.body);
    } else {
      throw UnknownResponseException(resp.statusCode, resp.body);
    }
  }

  // Fetches a single password from the databse identified by the provided ID,
  // returns a PasswordModel if succesfull or throws exceptions based on what went
  // wrongs
  Future<PasswordModel> fetchPassword(String id) async {
    final resp = await http.get(passwordURL+"$id/", headers: getHeaders());

    verifyCommonResponses(resp);

    if (resp.statusCode == 200) {
      return PasswordModel.fromMap(json.decode(resp.body));
    } else {
      throw UnknownResponseException(resp.statusCode, resp.body);
    }
  }

  // Creates a new password on the server based on the provided PasswordModel, returns
  // the newly generated PasswordModel if succesful, throws exceptions based on 
  // what went wrong.
  Future<PasswordModel> createPassword(PasswordModel password) async {
    final resp = await http.post(passwordURL, body: json.encode(password.toMap()), headers: getHeaders());
    
    verifyCommonResponses(resp);

    if (resp.statusCode == 200) {
      return PasswordModel.fromMap(json.decode(resp.body));
    } else {
      throw UnknownResponseException(resp.statusCode, resp.body);
    }
  }

  // Updates a Password based on the model provided. Returns the newly updated
  // PasswordModel if succesful otherwise throws an exception based on what went wrong.
  Future<PasswordModel> updatePassword(PasswordModel password) async {
    String pid = password.id;
    final resp = await http.put(passwordURL+"$pid/", body: json.encode(password.toMap()), headers: getHeaders());

    verifyCommonResponses(resp);
    
    if (resp.statusCode == 200) {
      return PasswordModel.fromMap(json.decode(resp.body));
    } else {  
      throw UnknownResponseException(resp.statusCode, resp.body);
    }
  }

  /// Deletes a Password from the server, returns true if succesfull or throws an
  // exception based on what went wrong.
  Future<bool> deletePassword(PasswordModel password) async {
    String pid = password.id;
    final resp = await http.delete(passwordURL+"$pid/", headers: getHeaders());

    verifyCommonResponses(resp);

    if (resp.statusCode == 200) {
      return true;
    } else {
      throw UnknownResponseException(resp.statusCode, resp.body);
    }
  }
}