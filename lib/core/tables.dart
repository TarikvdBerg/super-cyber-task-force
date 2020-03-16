import 'package:moor_flutter/moor_flutter.dart';

part 'tables.g.dart';

class AuthTokens extends Table {
  TextColumn get id => text().named("id").customConstraint('UNIQUE')();
  TextColumn get token => text().named("token").customConstraint('UNIQUE')();
  DateTimeColumn get expiryDate => dateTime().named("expiry_date")();

  @override
  Set<Column> get primaryKey => {id};
}

class Users extends Table {
  TextColumn get id => text().named("id").customConstraint('UNIQUE')();
  TextColumn get username =>
      text().named("username").customConstraint('UNIQUE')();
  TextColumn get email => text().named("email").customConstraint('UNIQUE')();
  TextColumn get firstname => text().named("first_name")();
  TextColumn get lastname => text().named("last_name")();
  TextColumn get displayname => text().named("display_name")();

  @override
  Set<Column> get primaryKey => {id};
}

class PasswordGroups extends Table {
  TextColumn get id => text().named("id").customConstraint('UNIQUE')();
  TextColumn get name => text().named("enc_name").customConstraint('UNIQUE')();

  @override
  Set<Column> get primaryKey => {id};
}

class Passwords extends Table {
  TextColumn get id => text().named("id").customConstraint('UNIQUE')();
  TextColumn get encName => text().named("enc_name")();
  TextColumn get encDescription => text().named("enc_description")();
  TextColumn get encPassword => text().named("enc_password")();
  TextColumn get group =>
      text().named("group").customConstraint('REFERENCES passwordgroup(id)')();

  @override
  Set<Column> get primaryKey => {id};
}

@UseMoor(tables: [Users, PasswordGroups, Passwords, AuthTokens], daos: [UsersDao, PasswordGroupsDao, PasswordsDao])
class LocalPasswordDatabase extends _$LocalPasswordDatabase {
  LocalPasswordDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
          path: 'sctf_storage.sqlite',
          logStatements: true
        ));

  @override
  int get schemaVersion => 1;
}

@UseDao(tables: [AuthTokens])
class AuthTokensDao extends DatabaseAccessor<LocalPasswordDatabase> with _$AuthTokensDaoMixin {
  AuthTokensDao(LocalPasswordDatabase db) : super(db);

  Future<AuthToken> get getToken => select(authTokens).getSingle();
  Future storeToken(AuthToken authToken) => into(authTokens).insert(authToken);
  Future updateToken(AuthToken authToken) => update(authTokens).replace(authToken);
  Future deleteToken(AuthToken authToken) => delete(authTokens).delete(authToken);
}

@UseDao(tables: [Users])
class UsersDao extends DatabaseAccessor<LocalPasswordDatabase> with _$UsersDaoMixin {
  UsersDao(LocalPasswordDatabase db) : super(db);

  Future<User> get singleUser => select(users).getSingle();
  Future insertUser(User user) => into(users).insert(user);
  Future updateUser(User user) => update(users).replace(user);
  Future deleteUser(User user) => delete(users).delete(user);
}

@UseDao(tables: [PasswordGroups])
class PasswordGroupsDao extends DatabaseAccessor<LocalPasswordDatabase> with _$PasswordGroupsDaoMixin {
  PasswordGroupsDao(LocalPasswordDatabase db) : super(db);

  Future<List<PasswordGroup>> get allPasswordGroups => select(passwordGroups).get();
  Future insertPassword(PasswordGroup passwordGroup) => into(passwordGroups).insert(passwordGroup);
  Future updatePassword(PasswordGroup passwordGroup) => update(passwordGroups).replace(passwordGroup);
  Future deletePassword(PasswordGroup passwordGroup) => delete(passwordGroups).delete(passwordGroup);
}

@UseDao(tables: [Passwords])
class PasswordsDao extends DatabaseAccessor<LocalPasswordDatabase> with _$PasswordsDaoMixin {
  PasswordsDao(LocalPasswordDatabase db) : super(db);

  Future<List<Password>> get allPasswords => select(passwords).get();
  Future insertPassword(Password password) => into(passwords).insert(password);
  Future updatePassword(Password password) => update(passwords).replace(password);
  Future deletePassword(Password password) => delete(passwords).delete(password);
}