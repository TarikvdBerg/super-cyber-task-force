
// Exception for when a instance of an model already exists
// on the server,.
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