// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tables.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class User extends DataClass implements Insertable<User> {
  final String id;
  final String username;
  final String email;
  final String firstname;
  final String lastname;
  final String displayname;
  User(
      {@required this.id,
      @required this.username,
      @required this.email,
      @required this.firstname,
      @required this.lastname,
      @required this.displayname});
  factory User.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return User(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      username: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}username']),
      email:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}email']),
      firstname: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}first_name']),
      lastname: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}last_name']),
      displayname: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}display_name']),
    );
  }
  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<String>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      email: serializer.fromJson<String>(json['email']),
      firstname: serializer.fromJson<String>(json['firstname']),
      lastname: serializer.fromJson<String>(json['lastname']),
      displayname: serializer.fromJson<String>(json['displayname']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'username': serializer.toJson<String>(username),
      'email': serializer.toJson<String>(email),
      'firstname': serializer.toJson<String>(firstname),
      'lastname': serializer.toJson<String>(lastname),
      'displayname': serializer.toJson<String>(displayname),
    };
  }

  @override
  UsersCompanion createCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      firstname: firstname == null && nullToAbsent
          ? const Value.absent()
          : Value(firstname),
      lastname: lastname == null && nullToAbsent
          ? const Value.absent()
          : Value(lastname),
      displayname: displayname == null && nullToAbsent
          ? const Value.absent()
          : Value(displayname),
    );
  }

  User copyWith(
          {String id,
          String username,
          String email,
          String firstname,
          String lastname,
          String displayname}) =>
      User(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        displayname: displayname ?? this.displayname,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('email: $email, ')
          ..write('firstname: $firstname, ')
          ..write('lastname: $lastname, ')
          ..write('displayname: $displayname')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          username.hashCode,
          $mrjc(
              email.hashCode,
              $mrjc(firstname.hashCode,
                  $mrjc(lastname.hashCode, displayname.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.username == this.username &&
          other.email == this.email &&
          other.firstname == this.firstname &&
          other.lastname == this.lastname &&
          other.displayname == this.displayname);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<String> username;
  final Value<String> email;
  final Value<String> firstname;
  final Value<String> lastname;
  final Value<String> displayname;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.email = const Value.absent(),
    this.firstname = const Value.absent(),
    this.lastname = const Value.absent(),
    this.displayname = const Value.absent(),
  });
  UsersCompanion.insert({
    @required String id,
    @required String username,
    @required String email,
    @required String firstname,
    @required String lastname,
    @required String displayname,
  })  : id = Value(id),
        username = Value(username),
        email = Value(email),
        firstname = Value(firstname),
        lastname = Value(lastname),
        displayname = Value(displayname);
  UsersCompanion copyWith(
      {Value<String> id,
      Value<String> username,
      Value<String> email,
      Value<String> firstname,
      Value<String> lastname,
      Value<String> displayname}) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      displayname: displayname ?? this.displayname,
    );
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  final GeneratedDatabase _db;
  final String _alias;
  $UsersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn('id', $tableName, false,
        $customConstraints: 'UNIQUE');
  }

  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  GeneratedTextColumn _username;
  @override
  GeneratedTextColumn get username => _username ??= _constructUsername();
  GeneratedTextColumn _constructUsername() {
    return GeneratedTextColumn('username', $tableName, false,
        $customConstraints: 'UNIQUE');
  }

  final VerificationMeta _emailMeta = const VerificationMeta('email');
  GeneratedTextColumn _email;
  @override
  GeneratedTextColumn get email => _email ??= _constructEmail();
  GeneratedTextColumn _constructEmail() {
    return GeneratedTextColumn('email', $tableName, false,
        $customConstraints: 'UNIQUE');
  }

  final VerificationMeta _firstnameMeta = const VerificationMeta('firstname');
  GeneratedTextColumn _firstname;
  @override
  GeneratedTextColumn get firstname => _firstname ??= _constructFirstname();
  GeneratedTextColumn _constructFirstname() {
    return GeneratedTextColumn(
      'first_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _lastnameMeta = const VerificationMeta('lastname');
  GeneratedTextColumn _lastname;
  @override
  GeneratedTextColumn get lastname => _lastname ??= _constructLastname();
  GeneratedTextColumn _constructLastname() {
    return GeneratedTextColumn(
      'last_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _displaynameMeta =
      const VerificationMeta('displayname');
  GeneratedTextColumn _displayname;
  @override
  GeneratedTextColumn get displayname =>
      _displayname ??= _constructDisplayname();
  GeneratedTextColumn _constructDisplayname() {
    return GeneratedTextColumn(
      'display_name',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, username, email, firstname, lastname, displayname];
  @override
  $UsersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'users';
  @override
  final String actualTableName = 'users';
  @override
  VerificationContext validateIntegrity(UsersCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (d.username.present) {
      context.handle(_usernameMeta,
          username.isAcceptableValue(d.username.value, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (d.email.present) {
      context.handle(
          _emailMeta, email.isAcceptableValue(d.email.value, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (d.firstname.present) {
      context.handle(_firstnameMeta,
          firstname.isAcceptableValue(d.firstname.value, _firstnameMeta));
    } else if (isInserting) {
      context.missing(_firstnameMeta);
    }
    if (d.lastname.present) {
      context.handle(_lastnameMeta,
          lastname.isAcceptableValue(d.lastname.value, _lastnameMeta));
    } else if (isInserting) {
      context.missing(_lastnameMeta);
    }
    if (d.displayname.present) {
      context.handle(_displaynameMeta,
          displayname.isAcceptableValue(d.displayname.value, _displaynameMeta));
    } else if (isInserting) {
      context.missing(_displaynameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return User.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(UsersCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.username.present) {
      map['username'] = Variable<String, StringType>(d.username.value);
    }
    if (d.email.present) {
      map['email'] = Variable<String, StringType>(d.email.value);
    }
    if (d.firstname.present) {
      map['first_name'] = Variable<String, StringType>(d.firstname.value);
    }
    if (d.lastname.present) {
      map['last_name'] = Variable<String, StringType>(d.lastname.value);
    }
    if (d.displayname.present) {
      map['display_name'] = Variable<String, StringType>(d.displayname.value);
    }
    return map;
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(_db, alias);
  }
}

class PasswordGroup extends DataClass implements Insertable<PasswordGroup> {
  final String id;
  final String name;
  PasswordGroup({@required this.id, @required this.name});
  factory PasswordGroup.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return PasswordGroup(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}enc_name']),
    );
  }
  factory PasswordGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return PasswordGroup(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  @override
  PasswordGroupsCompanion createCompanion(bool nullToAbsent) {
    return PasswordGroupsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  PasswordGroup copyWith({String id, String name}) => PasswordGroup(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('PasswordGroup(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, name.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is PasswordGroup &&
          other.id == this.id &&
          other.name == this.name);
}

class PasswordGroupsCompanion extends UpdateCompanion<PasswordGroup> {
  final Value<String> id;
  final Value<String> name;
  const PasswordGroupsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  PasswordGroupsCompanion.insert({
    @required String id,
    @required String name,
  })  : id = Value(id),
        name = Value(name);
  PasswordGroupsCompanion copyWith({Value<String> id, Value<String> name}) {
    return PasswordGroupsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}

class $PasswordGroupsTable extends PasswordGroups
    with TableInfo<$PasswordGroupsTable, PasswordGroup> {
  final GeneratedDatabase _db;
  final String _alias;
  $PasswordGroupsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn('id', $tableName, false,
        $customConstraints: 'UNIQUE');
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('enc_name', $tableName, false,
        $customConstraints: 'UNIQUE');
  }

  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  $PasswordGroupsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'password_groups';
  @override
  final String actualTableName = 'password_groups';
  @override
  VerificationContext validateIntegrity(PasswordGroupsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PasswordGroup map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return PasswordGroup.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(PasswordGroupsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['enc_name'] = Variable<String, StringType>(d.name.value);
    }
    return map;
  }

  @override
  $PasswordGroupsTable createAlias(String alias) {
    return $PasswordGroupsTable(_db, alias);
  }
}

class Password extends DataClass implements Insertable<Password> {
  final String id;
  final String encName;
  final String encDescription;
  final String encPassword;
  final String group;
  Password(
      {@required this.id,
      @required this.encName,
      @required this.encDescription,
      @required this.encPassword,
      @required this.group});
  factory Password.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return Password(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      encName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}enc_name']),
      encDescription: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}enc_description']),
      encPassword: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}enc_password']),
      group:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}group']),
    );
  }
  factory Password.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Password(
      id: serializer.fromJson<String>(json['id']),
      encName: serializer.fromJson<String>(json['encName']),
      encDescription: serializer.fromJson<String>(json['encDescription']),
      encPassword: serializer.fromJson<String>(json['encPassword']),
      group: serializer.fromJson<String>(json['group']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'encName': serializer.toJson<String>(encName),
      'encDescription': serializer.toJson<String>(encDescription),
      'encPassword': serializer.toJson<String>(encPassword),
      'group': serializer.toJson<String>(group),
    };
  }

  @override
  PasswordsCompanion createCompanion(bool nullToAbsent) {
    return PasswordsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      encName: encName == null && nullToAbsent
          ? const Value.absent()
          : Value(encName),
      encDescription: encDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(encDescription),
      encPassword: encPassword == null && nullToAbsent
          ? const Value.absent()
          : Value(encPassword),
      group:
          group == null && nullToAbsent ? const Value.absent() : Value(group),
    );
  }

  Password copyWith(
          {String id,
          String encName,
          String encDescription,
          String encPassword,
          String group}) =>
      Password(
        id: id ?? this.id,
        encName: encName ?? this.encName,
        encDescription: encDescription ?? this.encDescription,
        encPassword: encPassword ?? this.encPassword,
        group: group ?? this.group,
      );
  @override
  String toString() {
    return (StringBuffer('Password(')
          ..write('id: $id, ')
          ..write('encName: $encName, ')
          ..write('encDescription: $encDescription, ')
          ..write('encPassword: $encPassword, ')
          ..write('group: $group')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          encName.hashCode,
          $mrjc(encDescription.hashCode,
              $mrjc(encPassword.hashCode, group.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Password &&
          other.id == this.id &&
          other.encName == this.encName &&
          other.encDescription == this.encDescription &&
          other.encPassword == this.encPassword &&
          other.group == this.group);
}

class PasswordsCompanion extends UpdateCompanion<Password> {
  final Value<String> id;
  final Value<String> encName;
  final Value<String> encDescription;
  final Value<String> encPassword;
  final Value<String> group;
  const PasswordsCompanion({
    this.id = const Value.absent(),
    this.encName = const Value.absent(),
    this.encDescription = const Value.absent(),
    this.encPassword = const Value.absent(),
    this.group = const Value.absent(),
  });
  PasswordsCompanion.insert({
    @required String id,
    @required String encName,
    @required String encDescription,
    @required String encPassword,
    @required String group,
  })  : id = Value(id),
        encName = Value(encName),
        encDescription = Value(encDescription),
        encPassword = Value(encPassword),
        group = Value(group);
  PasswordsCompanion copyWith(
      {Value<String> id,
      Value<String> encName,
      Value<String> encDescription,
      Value<String> encPassword,
      Value<String> group}) {
    return PasswordsCompanion(
      id: id ?? this.id,
      encName: encName ?? this.encName,
      encDescription: encDescription ?? this.encDescription,
      encPassword: encPassword ?? this.encPassword,
      group: group ?? this.group,
    );
  }
}

class $PasswordsTable extends Passwords
    with TableInfo<$PasswordsTable, Password> {
  final GeneratedDatabase _db;
  final String _alias;
  $PasswordsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn('id', $tableName, false,
        $customConstraints: 'UNIQUE');
  }

  final VerificationMeta _encNameMeta = const VerificationMeta('encName');
  GeneratedTextColumn _encName;
  @override
  GeneratedTextColumn get encName => _encName ??= _constructEncName();
  GeneratedTextColumn _constructEncName() {
    return GeneratedTextColumn(
      'enc_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _encDescriptionMeta =
      const VerificationMeta('encDescription');
  GeneratedTextColumn _encDescription;
  @override
  GeneratedTextColumn get encDescription =>
      _encDescription ??= _constructEncDescription();
  GeneratedTextColumn _constructEncDescription() {
    return GeneratedTextColumn(
      'enc_description',
      $tableName,
      false,
    );
  }

  final VerificationMeta _encPasswordMeta =
      const VerificationMeta('encPassword');
  GeneratedTextColumn _encPassword;
  @override
  GeneratedTextColumn get encPassword =>
      _encPassword ??= _constructEncPassword();
  GeneratedTextColumn _constructEncPassword() {
    return GeneratedTextColumn(
      'enc_password',
      $tableName,
      false,
    );
  }

  final VerificationMeta _groupMeta = const VerificationMeta('group');
  GeneratedTextColumn _group;
  @override
  GeneratedTextColumn get group => _group ??= _constructGroup();
  GeneratedTextColumn _constructGroup() {
    return GeneratedTextColumn('group', $tableName, false,
        $customConstraints: 'REFERENCES passwordgroup(id)');
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, encName, encDescription, encPassword, group];
  @override
  $PasswordsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'passwords';
  @override
  final String actualTableName = 'passwords';
  @override
  VerificationContext validateIntegrity(PasswordsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (d.encName.present) {
      context.handle(_encNameMeta,
          encName.isAcceptableValue(d.encName.value, _encNameMeta));
    } else if (isInserting) {
      context.missing(_encNameMeta);
    }
    if (d.encDescription.present) {
      context.handle(
          _encDescriptionMeta,
          encDescription.isAcceptableValue(
              d.encDescription.value, _encDescriptionMeta));
    } else if (isInserting) {
      context.missing(_encDescriptionMeta);
    }
    if (d.encPassword.present) {
      context.handle(_encPasswordMeta,
          encPassword.isAcceptableValue(d.encPassword.value, _encPasswordMeta));
    } else if (isInserting) {
      context.missing(_encPasswordMeta);
    }
    if (d.group.present) {
      context.handle(
          _groupMeta, group.isAcceptableValue(d.group.value, _groupMeta));
    } else if (isInserting) {
      context.missing(_groupMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Password map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Password.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(PasswordsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.encName.present) {
      map['enc_name'] = Variable<String, StringType>(d.encName.value);
    }
    if (d.encDescription.present) {
      map['enc_description'] =
          Variable<String, StringType>(d.encDescription.value);
    }
    if (d.encPassword.present) {
      map['enc_password'] = Variable<String, StringType>(d.encPassword.value);
    }
    if (d.group.present) {
      map['group'] = Variable<String, StringType>(d.group.value);
    }
    return map;
  }

  @override
  $PasswordsTable createAlias(String alias) {
    return $PasswordsTable(_db, alias);
  }
}

class AuthToken extends DataClass implements Insertable<AuthToken> {
  final String id;
  final String token;
  final DateTime expiryDate;
  AuthToken(
      {@required this.id, @required this.token, @required this.expiryDate});
  factory AuthToken.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return AuthToken(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      token:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}token']),
      expiryDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}expiry_date']),
    );
  }
  factory AuthToken.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return AuthToken(
      id: serializer.fromJson<String>(json['id']),
      token: serializer.fromJson<String>(json['token']),
      expiryDate: serializer.fromJson<DateTime>(json['expiryDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'token': serializer.toJson<String>(token),
      'expiryDate': serializer.toJson<DateTime>(expiryDate),
    };
  }

  @override
  AuthTokensCompanion createCompanion(bool nullToAbsent) {
    return AuthTokensCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      token:
          token == null && nullToAbsent ? const Value.absent() : Value(token),
      expiryDate: expiryDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expiryDate),
    );
  }

  AuthToken copyWith({String id, String token, DateTime expiryDate}) =>
      AuthToken(
        id: id ?? this.id,
        token: token ?? this.token,
        expiryDate: expiryDate ?? this.expiryDate,
      );
  @override
  String toString() {
    return (StringBuffer('AuthToken(')
          ..write('id: $id, ')
          ..write('token: $token, ')
          ..write('expiryDate: $expiryDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(token.hashCode, expiryDate.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is AuthToken &&
          other.id == this.id &&
          other.token == this.token &&
          other.expiryDate == this.expiryDate);
}

class AuthTokensCompanion extends UpdateCompanion<AuthToken> {
  final Value<String> id;
  final Value<String> token;
  final Value<DateTime> expiryDate;
  const AuthTokensCompanion({
    this.id = const Value.absent(),
    this.token = const Value.absent(),
    this.expiryDate = const Value.absent(),
  });
  AuthTokensCompanion.insert({
    @required String id,
    @required String token,
    @required DateTime expiryDate,
  })  : id = Value(id),
        token = Value(token),
        expiryDate = Value(expiryDate);
  AuthTokensCompanion copyWith(
      {Value<String> id, Value<String> token, Value<DateTime> expiryDate}) {
    return AuthTokensCompanion(
      id: id ?? this.id,
      token: token ?? this.token,
      expiryDate: expiryDate ?? this.expiryDate,
    );
  }
}

class $AuthTokensTable extends AuthTokens
    with TableInfo<$AuthTokensTable, AuthToken> {
  final GeneratedDatabase _db;
  final String _alias;
  $AuthTokensTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn('id', $tableName, false,
        $customConstraints: 'UNIQUE');
  }

  final VerificationMeta _tokenMeta = const VerificationMeta('token');
  GeneratedTextColumn _token;
  @override
  GeneratedTextColumn get token => _token ??= _constructToken();
  GeneratedTextColumn _constructToken() {
    return GeneratedTextColumn('token', $tableName, false,
        $customConstraints: 'UNIQUE');
  }

  final VerificationMeta _expiryDateMeta = const VerificationMeta('expiryDate');
  GeneratedDateTimeColumn _expiryDate;
  @override
  GeneratedDateTimeColumn get expiryDate =>
      _expiryDate ??= _constructExpiryDate();
  GeneratedDateTimeColumn _constructExpiryDate() {
    return GeneratedDateTimeColumn(
      'expiry_date',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, token, expiryDate];
  @override
  $AuthTokensTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'auth_tokens';
  @override
  final String actualTableName = 'auth_tokens';
  @override
  VerificationContext validateIntegrity(AuthTokensCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (d.token.present) {
      context.handle(
          _tokenMeta, token.isAcceptableValue(d.token.value, _tokenMeta));
    } else if (isInserting) {
      context.missing(_tokenMeta);
    }
    if (d.expiryDate.present) {
      context.handle(_expiryDateMeta,
          expiryDate.isAcceptableValue(d.expiryDate.value, _expiryDateMeta));
    } else if (isInserting) {
      context.missing(_expiryDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuthToken map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return AuthToken.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(AuthTokensCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.token.present) {
      map['token'] = Variable<String, StringType>(d.token.value);
    }
    if (d.expiryDate.present) {
      map['expiry_date'] = Variable<DateTime, DateTimeType>(d.expiryDate.value);
    }
    return map;
  }

  @override
  $AuthTokensTable createAlias(String alias) {
    return $AuthTokensTable(_db, alias);
  }
}

abstract class _$LocalPasswordDatabase extends GeneratedDatabase {
  _$LocalPasswordDatabase(QueryExecutor e)
      : super(SqlTypeSystem.defaultInstance, e);
  $UsersTable _users;
  $UsersTable get users => _users ??= $UsersTable(this);
  $PasswordGroupsTable _passwordGroups;
  $PasswordGroupsTable get passwordGroups =>
      _passwordGroups ??= $PasswordGroupsTable(this);
  $PasswordsTable _passwords;
  $PasswordsTable get passwords => _passwords ??= $PasswordsTable(this);
  $AuthTokensTable _authTokens;
  $AuthTokensTable get authTokens => _authTokens ??= $AuthTokensTable(this);
  UsersDao _usersDao;
  UsersDao get usersDao =>
      _usersDao ??= UsersDao(this as LocalPasswordDatabase);
  PasswordGroupsDao _passwordGroupsDao;
  PasswordGroupsDao get passwordGroupsDao =>
      _passwordGroupsDao ??= PasswordGroupsDao(this as LocalPasswordDatabase);
  PasswordsDao _passwordsDao;
  PasswordsDao get passwordsDao =>
      _passwordsDao ??= PasswordsDao(this as LocalPasswordDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [users, passwordGroups, passwords, authTokens];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$AuthTokensDaoMixin on DatabaseAccessor<LocalPasswordDatabase> {
  $AuthTokensTable get authTokens => db.authTokens;
}
mixin _$UsersDaoMixin on DatabaseAccessor<LocalPasswordDatabase> {
  $UsersTable get users => db.users;
}
mixin _$PasswordGroupsDaoMixin on DatabaseAccessor<LocalPasswordDatabase> {
  $PasswordGroupsTable get passwordGroups => db.passwordGroups;
}
mixin _$PasswordsDaoMixin on DatabaseAccessor<LocalPasswordDatabase> {
  $PasswordsTable get passwords => db.passwords;
}
