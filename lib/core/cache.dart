import 'package:SCTFPasswordManager/core/api.dart';
import 'package:SCTFPasswordManager/core/models.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

// Keys and Prefixes that are common throughout the
// application.
String userKey = "user";
String authKey = "authentication";
String passwordGroupKeyPrefix = "pwg-";
String passwordKeyPrefix = "pw-";


class Cache extends API {
  Database db;
  StoreRef store;

  int get localDBVersion => 1;

  Cache() {
    _setup();
  }
  
  void _setup() async {
    // Open database
    String dbPath = "./sctflocalstorage.db";
    db = await databaseFactoryIo.openDatabase(dbPath, version: localDBVersion);

    // Alias for store
    store = StoreRef.main();
  }

  // Stores the provide AuthenticationTokenModel, returns the key of the stored
  // instance.
  Future<String> storeAuthenticationToken(AuthTokenModel auth) async {
    String key = await store.record(authKey).add(db, auth.toMap());
    return key;
  }
  

  // Sets the API token
  void setAuthenticationToken(String token) {
    super.authToken = token;
  }

  // Updates the authentication token for both the local storage
  // and the underlying API layer.
  void updateAuthenticationToken(AuthTokenModel auth) async {
    await storeAuthenticationToken(auth);
    setAuthenticationToken(auth.authenticationToken);
  }

  // Requests authentication from the API layer and stores the result.
  Future<AuthTokenModel> authenticate(String username, String password) async {
    AuthTokenModel authToken = await super.authenticate(username, password);
    if (authToken != null) {
      store.record(authKey).update(db, authToken.toMap());
      return authToken;
    }
    return null;
  }

  // Checks the local storage for a user object and validates if the 
  // information hasn't expired. If the local information is correct
  // it returns the local information.
  // If the xpirationdate has been exceeded new data is retrived form
  // the server and stored. lastly the new user model is returned.
  Future<UserModel> fetchUser(String id) async {
    // Retireve data from local storage and verify if it is valid
    Map<String, dynamic> dbData = store.record(userKey) as Map<String, dynamic>;
    
    if (dbData != null) {
      UserModel user = UserModel.fromMap(dbData);
      if (DateTime.now().isBefore(user.validUntil)) {
        return user;
      }
    }
    
    // Data wasn't valid, retrieve form the server
    UserModel retrievedUser = await super.fetchUser(id);
    store.record(userKey).put(db, retrievedUser.toMap());
    return retrievedUser;
  }

  // Sends the user to be updated to the API layer and updates
  // the local version of the object. Returns the newly created
  // user.
  Future<UserModel> updateUser(UserModel user) async {
    // Push data and store the response
    UserModel updatedUser = await super.updateUser(user);
    store.record(userKey).update(db, updatedUser.toMap());
    return updatedUser;
  }

  // Passes the delete action on to the underlying layer and
  // deletes local data if the action was a success.
  Future<bool> deleteUser(UserModel user) async {
    // Delete usere and delete locally
    bool isSuccess = await super.deleteUser(user);
    if (isSuccess) {
      store.record(userKey).delete(db); 
    }

    return isSuccess;
  }
  
  // Checks the local cache for the request group and verifies if it's validUntil
  // hasn't been exceeded. If it hasn't the local data is returned. Otherwise
  // a new version is retrieved from the server.
  Future<PasswordGroupModel> fetchGroup(String id) async {
    // Retrieve from database and try to verify the date
    Map<String, dynamic> dbData = await store.record(passwordGroupKeyPrefix + id).get(db) as Map<String, dynamic>;
    PasswordGroupModel dbGroup = PasswordGroupModel.fromMap(dbData);
    if (DateTime.now().isBefore(dbGroup.validUntil)) {
      return dbGroup;
    }

    // Data has expired, fetch new and store it
    PasswordGroupModel fetchedPasswordGroup = await super.fetchGroup(id);
    store.record(passwordGroupKeyPrefix+id).add(db, fetchedPasswordGroup.toMap());
    return fetchedPasswordGroup;
  }

  // Updates a password group and stores the result locally. Returns a 
  // PasswordGroupModel object
  Future<PasswordGroupModel> updateGroup(PasswordGroupModel group) async {
    // Update the remote version and store returned data in local database
    PasswordGroupModel updatedGroup = await super.updateGroup(group);
    store.record(updatedGroup.id).update(db, updatedGroup.toMap());

    return updatedGroup;
  }

  // Deletes a password group from the remote server, and if succesfull
  // deletes the local version aswell.
  Future<bool> deleteGroup(PasswordGroupModel group) async {
    bool isSuccess = await super.deleteGroup(group);
    if (isSuccess) {
      store.record(group.id).delete(db);
    }

    return isSuccess;
  }

  // Fetches the requested password from the local database and checks
  // if the data is still 
  Future<PasswordModel> fetchPassword(String id) async {
    // Retrieve local data and verify the validUntil date.
    Map<String, dynamic> dbData = await store.record(passwordKeyPrefix+id).get(db) as Map<String, dynamic>;
    PasswordModel dbPassword = PasswordModel.fromMap(dbData);
    if (DateTime.now().isBefore(dbPassword.validUntil)) {
      return dbPassword;
    }

    // Data wasn't valid, retrieve a new version
    PasswordModel newPassword = await super.fetchPassword(id);
    store.record(newPassword.id).put(db, newPassword.toMap());
    return newPassword;
  }

  Future<PasswordModel> updatePassword(PasswordModel password) async {
    // Update password & store returned version
    PasswordModel updatedPassword = await super.updatePassword(password);
    store.record(updatedPassword.id).update(db, password.toMap());
    return updatedPassword;
  }

  Future<bool> deletePassword(PasswordModel password) async {
    // Delete password & delete local version
    bool isSuccess = await super.deletePassword(password);
    if (isSuccess) {
      store.record(password.id).delete(db);
    }

    return isSuccess;
  }

}