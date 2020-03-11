
// Exception for when a instance of an model already exists
// on the server,.
import 'package:flutter/animation.dart';

class ModelAlreadyExistsException implements Exception {
  static String modelName;
  
  ModelAlreadyExistsException(String model) {
    modelName = model;
  }

  String errorMessage() {
    return "$modelName already exists on server";
  }
}

// Exception for when a model does not exists on the server,
// takes in a ID to build the error message with.
class ModelDoesNotExistException implements Exception {
  static String id;
  
  ModelDoesNotExistException(String id) {
    id = id;
  }

  String errorMessage() {
    return "Object with ID($id) doest not exist";
  }
}

// Exception for when an request that should've contained an authentication mechanism
// is rejected by the server for not being authenticated. Takes an endpoint to clarify
// which action was rejected.
class RequestNotAuthenticatedException implements Exception {
  static String endpoint;

  RequestNotAuthenticatedException(String endp) {
    endpoint = endp;
  }

  String errorMessage() {
    return "Request to $endpoint wasn't authenticated";
  }
}

// Exception for when a request to a resource is forbidden due to user access constraints
class RequestForbiddenException implements Exception {
  static String endpoint;

  RequestForbiddenException(String endp) {
    endpoint = endp;
  }

  String errorMessage() {
    return "Access to resource at $endpoint forbidden";
  }
}

// Exception for when an request doesn't match the servers expectations
class BadRequestException implements Exception {
  static String message;

  BadRequestException(String mess) {
    message = mess;
  }

  String errorMessage() {
    return message;
  }
}

// Exception to handle homeland internal server errors
class ServerErrorException implements Exception {
  String responseText;

  ServerErrorException(String text) {
    this.responseText = text;
  }

  String errorMessage() {
    return "Server had an internal error: $responseText";
  }
}

// Exception for when the response is unknown, takes in an 
// statusCode and serverMesssage to notify the developer.
class UnknownResponseException implements Exception {
  int statusCode;
  String responseText;

  UnknownResponseException(int status, String responseText) {
    this.statusCode = status;
    this.responseText = responseText;
  }

  String errorMessage() {
    return "Server Status $statusCode. Message: $responseText";
  }
}