// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, DbUser> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
      'image', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
      customFieldsJson = GeneratedColumn<String>(
              'custom_fields_json', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<Map<String, dynamic>?>(
              $UsersTable.$convertercustomFieldsJson);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, email, image, customFieldsJson];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<DbUser> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbUser(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image']),
      customFieldsJson: $UsersTable.$convertercustomFieldsJson.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}custom_fields_json'])),
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, dynamic>?, String?>
      $convertercustomFieldsJson = const JsonMapNullableConverter();
}

class DbUser extends DataClass implements Insertable<DbUser> {
  final int id;
  final String name;
  final String email;
  final String? image;
  final Map<String, dynamic>? customFieldsJson;
  const DbUser(
      {required this.id,
      required this.name,
      required this.email,
      this.image,
      this.customFieldsJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    if (!nullToAbsent || customFieldsJson != null) {
      map['custom_fields_json'] = Variable<String>(
          $UsersTable.$convertercustomFieldsJson.toSql(customFieldsJson));
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: Value(name),
      email: Value(email),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      customFieldsJson: customFieldsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(customFieldsJson),
    );
  }

  factory DbUser.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbUser(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      image: serializer.fromJson<String?>(json['image']),
      customFieldsJson:
          serializer.fromJson<Map<String, dynamic>?>(json['customFieldsJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'image': serializer.toJson<String?>(image),
      'customFieldsJson':
          serializer.toJson<Map<String, dynamic>?>(customFieldsJson),
    };
  }

  DbUser copyWith(
          {int? id,
          String? name,
          String? email,
          Value<String?> image = const Value.absent(),
          Value<Map<String, dynamic>?> customFieldsJson =
              const Value.absent()}) =>
      DbUser(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        image: image.present ? image.value : this.image,
        customFieldsJson: customFieldsJson.present
            ? customFieldsJson.value
            : this.customFieldsJson,
      );
  DbUser copyWithCompanion(UsersCompanion data) {
    return DbUser(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      image: data.image.present ? data.image.value : this.image,
      customFieldsJson: data.customFieldsJson.present
          ? data.customFieldsJson.value
          : this.customFieldsJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbUser(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('image: $image, ')
          ..write('customFieldsJson: $customFieldsJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, email, image, customFieldsJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbUser &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.image == this.image &&
          other.customFieldsJson == this.customFieldsJson);
}

class UsersCompanion extends UpdateCompanion<DbUser> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> email;
  final Value<String?> image;
  final Value<Map<String, dynamic>?> customFieldsJson;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.image = const Value.absent(),
    this.customFieldsJson = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String email,
    this.image = const Value.absent(),
    this.customFieldsJson = const Value.absent(),
  })  : name = Value(name),
        email = Value(email);
  static Insertable<DbUser> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? image,
    Expression<String>? customFieldsJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (image != null) 'image': image,
      if (customFieldsJson != null) 'custom_fields_json': customFieldsJson,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? email,
      Value<String?>? image,
      Value<Map<String, dynamic>?>? customFieldsJson}) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
      customFieldsJson: customFieldsJson ?? this.customFieldsJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (customFieldsJson.present) {
      map['custom_fields_json'] = Variable<String>(
          $UsersTable.$convertercustomFieldsJson.toSql(customFieldsJson.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('image: $image, ')
          ..write('customFieldsJson: $customFieldsJson')
          ..write(')'))
        .toString();
  }
}

class $CompaniesTable extends Companies
    with TableInfo<$CompaniesTable, DbCompany> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompaniesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _logoMeta = const VerificationMeta('logo');
  @override
  late final GeneratedColumn<String> logo = GeneratedColumn<String>(
      'logo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ownerNameMeta =
      const VerificationMeta('ownerName');
  @override
  late final GeneratedColumn<String> ownerName = GeneratedColumn<String>(
      'owner_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ownerEmailMeta =
      const VerificationMeta('ownerEmail');
  @override
  late final GeneratedColumn<String> ownerEmail = GeneratedColumn<String>(
      'owner_email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _planMeta = const VerificationMeta('plan');
  @override
  late final GeneratedColumn<String> plan = GeneratedColumn<String>(
      'plan', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _subscriptionStatusMeta =
      const VerificationMeta('subscriptionStatus');
  @override
  late final GeneratedColumn<String> subscriptionStatus =
      GeneratedColumn<String>('subscription_status', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _currentCycleEndMeta =
      const VerificationMeta('currentCycleEnd');
  @override
  late final GeneratedColumn<DateTime> currentCycleEnd =
      GeneratedColumn<DateTime>('current_cycle_end', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uuid,
        name,
        logo,
        ownerName,
        ownerEmail,
        plan,
        subscriptionStatus,
        currentCycleEnd
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'companies';
  @override
  VerificationContext validateIntegrity(Insertable<DbCompany> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('logo')) {
      context.handle(
          _logoMeta, logo.isAcceptableOrUnknown(data['logo']!, _logoMeta));
    }
    if (data.containsKey('owner_name')) {
      context.handle(_ownerNameMeta,
          ownerName.isAcceptableOrUnknown(data['owner_name']!, _ownerNameMeta));
    } else if (isInserting) {
      context.missing(_ownerNameMeta);
    }
    if (data.containsKey('owner_email')) {
      context.handle(
          _ownerEmailMeta,
          ownerEmail.isAcceptableOrUnknown(
              data['owner_email']!, _ownerEmailMeta));
    } else if (isInserting) {
      context.missing(_ownerEmailMeta);
    }
    if (data.containsKey('plan')) {
      context.handle(
          _planMeta, plan.isAcceptableOrUnknown(data['plan']!, _planMeta));
    } else if (isInserting) {
      context.missing(_planMeta);
    }
    if (data.containsKey('subscription_status')) {
      context.handle(
          _subscriptionStatusMeta,
          subscriptionStatus.isAcceptableOrUnknown(
              data['subscription_status']!, _subscriptionStatusMeta));
    } else if (isInserting) {
      context.missing(_subscriptionStatusMeta);
    }
    if (data.containsKey('current_cycle_end')) {
      context.handle(
          _currentCycleEndMeta,
          currentCycleEnd.isAcceptableOrUnknown(
              data['current_cycle_end']!, _currentCycleEndMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbCompany map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbCompany(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      logo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}logo']),
      ownerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}owner_name'])!,
      ownerEmail: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}owner_email'])!,
      plan: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plan'])!,
      subscriptionStatus: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}subscription_status'])!,
      currentCycleEnd: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}current_cycle_end']),
    );
  }

  @override
  $CompaniesTable createAlias(String alias) {
    return $CompaniesTable(attachedDatabase, alias);
  }
}

class DbCompany extends DataClass implements Insertable<DbCompany> {
  final int id;
  final String uuid;
  final String name;
  final String? logo;
  final String ownerName;
  final String ownerEmail;
  final String plan;
  final String subscriptionStatus;
  final DateTime? currentCycleEnd;
  const DbCompany(
      {required this.id,
      required this.uuid,
      required this.name,
      this.logo,
      required this.ownerName,
      required this.ownerEmail,
      required this.plan,
      required this.subscriptionStatus,
      this.currentCycleEnd});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || logo != null) {
      map['logo'] = Variable<String>(logo);
    }
    map['owner_name'] = Variable<String>(ownerName);
    map['owner_email'] = Variable<String>(ownerEmail);
    map['plan'] = Variable<String>(plan);
    map['subscription_status'] = Variable<String>(subscriptionStatus);
    if (!nullToAbsent || currentCycleEnd != null) {
      map['current_cycle_end'] = Variable<DateTime>(currentCycleEnd);
    }
    return map;
  }

  CompaniesCompanion toCompanion(bool nullToAbsent) {
    return CompaniesCompanion(
      id: Value(id),
      uuid: Value(uuid),
      name: Value(name),
      logo: logo == null && nullToAbsent ? const Value.absent() : Value(logo),
      ownerName: Value(ownerName),
      ownerEmail: Value(ownerEmail),
      plan: Value(plan),
      subscriptionStatus: Value(subscriptionStatus),
      currentCycleEnd: currentCycleEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(currentCycleEnd),
    );
  }

  factory DbCompany.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbCompany(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      name: serializer.fromJson<String>(json['name']),
      logo: serializer.fromJson<String?>(json['logo']),
      ownerName: serializer.fromJson<String>(json['ownerName']),
      ownerEmail: serializer.fromJson<String>(json['ownerEmail']),
      plan: serializer.fromJson<String>(json['plan']),
      subscriptionStatus:
          serializer.fromJson<String>(json['subscriptionStatus']),
      currentCycleEnd: serializer.fromJson<DateTime?>(json['currentCycleEnd']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'name': serializer.toJson<String>(name),
      'logo': serializer.toJson<String?>(logo),
      'ownerName': serializer.toJson<String>(ownerName),
      'ownerEmail': serializer.toJson<String>(ownerEmail),
      'plan': serializer.toJson<String>(plan),
      'subscriptionStatus': serializer.toJson<String>(subscriptionStatus),
      'currentCycleEnd': serializer.toJson<DateTime?>(currentCycleEnd),
    };
  }

  DbCompany copyWith(
          {int? id,
          String? uuid,
          String? name,
          Value<String?> logo = const Value.absent(),
          String? ownerName,
          String? ownerEmail,
          String? plan,
          String? subscriptionStatus,
          Value<DateTime?> currentCycleEnd = const Value.absent()}) =>
      DbCompany(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        name: name ?? this.name,
        logo: logo.present ? logo.value : this.logo,
        ownerName: ownerName ?? this.ownerName,
        ownerEmail: ownerEmail ?? this.ownerEmail,
        plan: plan ?? this.plan,
        subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
        currentCycleEnd: currentCycleEnd.present
            ? currentCycleEnd.value
            : this.currentCycleEnd,
      );
  DbCompany copyWithCompanion(CompaniesCompanion data) {
    return DbCompany(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      name: data.name.present ? data.name.value : this.name,
      logo: data.logo.present ? data.logo.value : this.logo,
      ownerName: data.ownerName.present ? data.ownerName.value : this.ownerName,
      ownerEmail:
          data.ownerEmail.present ? data.ownerEmail.value : this.ownerEmail,
      plan: data.plan.present ? data.plan.value : this.plan,
      subscriptionStatus: data.subscriptionStatus.present
          ? data.subscriptionStatus.value
          : this.subscriptionStatus,
      currentCycleEnd: data.currentCycleEnd.present
          ? data.currentCycleEnd.value
          : this.currentCycleEnd,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbCompany(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('logo: $logo, ')
          ..write('ownerName: $ownerName, ')
          ..write('ownerEmail: $ownerEmail, ')
          ..write('plan: $plan, ')
          ..write('subscriptionStatus: $subscriptionStatus, ')
          ..write('currentCycleEnd: $currentCycleEnd')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, uuid, name, logo, ownerName, ownerEmail,
      plan, subscriptionStatus, currentCycleEnd);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbCompany &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.name == this.name &&
          other.logo == this.logo &&
          other.ownerName == this.ownerName &&
          other.ownerEmail == this.ownerEmail &&
          other.plan == this.plan &&
          other.subscriptionStatus == this.subscriptionStatus &&
          other.currentCycleEnd == this.currentCycleEnd);
}

class CompaniesCompanion extends UpdateCompanion<DbCompany> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> name;
  final Value<String?> logo;
  final Value<String> ownerName;
  final Value<String> ownerEmail;
  final Value<String> plan;
  final Value<String> subscriptionStatus;
  final Value<DateTime?> currentCycleEnd;
  const CompaniesCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    this.logo = const Value.absent(),
    this.ownerName = const Value.absent(),
    this.ownerEmail = const Value.absent(),
    this.plan = const Value.absent(),
    this.subscriptionStatus = const Value.absent(),
    this.currentCycleEnd = const Value.absent(),
  });
  CompaniesCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required String name,
    this.logo = const Value.absent(),
    required String ownerName,
    required String ownerEmail,
    required String plan,
    required String subscriptionStatus,
    this.currentCycleEnd = const Value.absent(),
  })  : uuid = Value(uuid),
        name = Value(name),
        ownerName = Value(ownerName),
        ownerEmail = Value(ownerEmail),
        plan = Value(plan),
        subscriptionStatus = Value(subscriptionStatus);
  static Insertable<DbCompany> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? name,
    Expression<String>? logo,
    Expression<String>? ownerName,
    Expression<String>? ownerEmail,
    Expression<String>? plan,
    Expression<String>? subscriptionStatus,
    Expression<DateTime>? currentCycleEnd,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (logo != null) 'logo': logo,
      if (ownerName != null) 'owner_name': ownerName,
      if (ownerEmail != null) 'owner_email': ownerEmail,
      if (plan != null) 'plan': plan,
      if (subscriptionStatus != null) 'subscription_status': subscriptionStatus,
      if (currentCycleEnd != null) 'current_cycle_end': currentCycleEnd,
    });
  }

  CompaniesCompanion copyWith(
      {Value<int>? id,
      Value<String>? uuid,
      Value<String>? name,
      Value<String?>? logo,
      Value<String>? ownerName,
      Value<String>? ownerEmail,
      Value<String>? plan,
      Value<String>? subscriptionStatus,
      Value<DateTime?>? currentCycleEnd}) {
    return CompaniesCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      logo: logo ?? this.logo,
      ownerName: ownerName ?? this.ownerName,
      ownerEmail: ownerEmail ?? this.ownerEmail,
      plan: plan ?? this.plan,
      subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
      currentCycleEnd: currentCycleEnd ?? this.currentCycleEnd,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (logo.present) {
      map['logo'] = Variable<String>(logo.value);
    }
    if (ownerName.present) {
      map['owner_name'] = Variable<String>(ownerName.value);
    }
    if (ownerEmail.present) {
      map['owner_email'] = Variable<String>(ownerEmail.value);
    }
    if (plan.present) {
      map['plan'] = Variable<String>(plan.value);
    }
    if (subscriptionStatus.present) {
      map['subscription_status'] = Variable<String>(subscriptionStatus.value);
    }
    if (currentCycleEnd.present) {
      map['current_cycle_end'] = Variable<DateTime>(currentCycleEnd.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompaniesCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('logo: $logo, ')
          ..write('ownerName: $ownerName, ')
          ..write('ownerEmail: $ownerEmail, ')
          ..write('plan: $plan, ')
          ..write('subscriptionStatus: $subscriptionStatus, ')
          ..write('currentCycleEnd: $currentCycleEnd')
          ..write(')'))
        .toString();
  }
}

class $UserCompaniesTable extends UserCompanies
    with TableInfo<$UserCompaniesTable, DbUserCompany> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserCompaniesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES users (id) ON DELETE CASCADE'));
  static const VerificationMeta _companyIdMeta =
      const VerificationMeta('companyId');
  @override
  late final GeneratedColumn<int> companyId = GeneratedColumn<int>(
      'company_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES companies (id) ON DELETE CASCADE'));
  static const VerificationMeta _isOwnerMeta =
      const VerificationMeta('isOwner');
  @override
  late final GeneratedColumn<bool> isOwner = GeneratedColumn<bool>(
      'is_owner', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_owner" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [userId, companyId, isOwner];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_companies';
  @override
  VerificationContext validateIntegrity(Insertable<DbUserCompany> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('company_id')) {
      context.handle(_companyIdMeta,
          companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta));
    } else if (isInserting) {
      context.missing(_companyIdMeta);
    }
    if (data.containsKey('is_owner')) {
      context.handle(_isOwnerMeta,
          isOwner.isAcceptableOrUnknown(data['is_owner']!, _isOwnerMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId, companyId};
  @override
  DbUserCompany map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbUserCompany(
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      companyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}company_id'])!,
      isOwner: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_owner'])!,
    );
  }

  @override
  $UserCompaniesTable createAlias(String alias) {
    return $UserCompaniesTable(attachedDatabase, alias);
  }
}

class DbUserCompany extends DataClass implements Insertable<DbUserCompany> {
  final int userId;
  final int companyId;
  final bool isOwner;
  const DbUserCompany(
      {required this.userId, required this.companyId, required this.isOwner});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<int>(userId);
    map['company_id'] = Variable<int>(companyId);
    map['is_owner'] = Variable<bool>(isOwner);
    return map;
  }

  UserCompaniesCompanion toCompanion(bool nullToAbsent) {
    return UserCompaniesCompanion(
      userId: Value(userId),
      companyId: Value(companyId),
      isOwner: Value(isOwner),
    );
  }

  factory DbUserCompany.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbUserCompany(
      userId: serializer.fromJson<int>(json['userId']),
      companyId: serializer.fromJson<int>(json['companyId']),
      isOwner: serializer.fromJson<bool>(json['isOwner']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<int>(userId),
      'companyId': serializer.toJson<int>(companyId),
      'isOwner': serializer.toJson<bool>(isOwner),
    };
  }

  DbUserCompany copyWith({int? userId, int? companyId, bool? isOwner}) =>
      DbUserCompany(
        userId: userId ?? this.userId,
        companyId: companyId ?? this.companyId,
        isOwner: isOwner ?? this.isOwner,
      );
  DbUserCompany copyWithCompanion(UserCompaniesCompanion data) {
    return DbUserCompany(
      userId: data.userId.present ? data.userId.value : this.userId,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
      isOwner: data.isOwner.present ? data.isOwner.value : this.isOwner,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbUserCompany(')
          ..write('userId: $userId, ')
          ..write('companyId: $companyId, ')
          ..write('isOwner: $isOwner')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(userId, companyId, isOwner);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbUserCompany &&
          other.userId == this.userId &&
          other.companyId == this.companyId &&
          other.isOwner == this.isOwner);
}

class UserCompaniesCompanion extends UpdateCompanion<DbUserCompany> {
  final Value<int> userId;
  final Value<int> companyId;
  final Value<bool> isOwner;
  final Value<int> rowid;
  const UserCompaniesCompanion({
    this.userId = const Value.absent(),
    this.companyId = const Value.absent(),
    this.isOwner = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserCompaniesCompanion.insert({
    required int userId,
    required int companyId,
    this.isOwner = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : userId = Value(userId),
        companyId = Value(companyId);
  static Insertable<DbUserCompany> custom({
    Expression<int>? userId,
    Expression<int>? companyId,
    Expression<bool>? isOwner,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (companyId != null) 'company_id': companyId,
      if (isOwner != null) 'is_owner': isOwner,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserCompaniesCompanion copyWith(
      {Value<int>? userId,
      Value<int>? companyId,
      Value<bool>? isOwner,
      Value<int>? rowid}) {
    return UserCompaniesCompanion(
      userId: userId ?? this.userId,
      companyId: companyId ?? this.companyId,
      isOwner: isOwner ?? this.isOwner,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<int>(companyId.value);
    }
    if (isOwner.present) {
      map['is_owner'] = Variable<bool>(isOwner.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserCompaniesCompanion(')
          ..write('userId: $userId, ')
          ..write('companyId: $companyId, ')
          ..write('isOwner: $isOwner, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProvidersTable extends Providers
    with TableInfo<$ProvidersTable, DbProvider> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProvidersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _companyIdMeta =
      const VerificationMeta('companyId');
  @override
  late final GeneratedColumn<int> companyId = GeneratedColumn<int>(
      'company_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _parentCategoryIdMeta =
      const VerificationMeta('parentCategoryId');
  @override
  late final GeneratedColumn<int> parentCategoryId = GeneratedColumn<int>(
      'parent_category_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
      'image', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
      customFieldsJson = GeneratedColumn<String>(
              'custom_fields_json', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<Map<String, dynamic>?>(
              $ProvidersTable.$convertercustomFieldsJson);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        companyId,
        uuid,
        name,
        categoryId,
        parentCategoryId,
        category,
        image,
        phone,
        description,
        customFieldsJson,
        updatedAt,
        isDeleted
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'providers';
  @override
  VerificationContext validateIntegrity(Insertable<DbProvider> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('company_id')) {
      context.handle(_companyIdMeta,
          companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    }
    if (data.containsKey('parent_category_id')) {
      context.handle(
          _parentCategoryIdMeta,
          parentCategoryId.isAcceptableOrUnknown(
              data['parent_category_id']!, _parentCategoryIdMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbProvider map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbProvider(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      companyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}company_id']),
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id']),
      parentCategoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parent_category_id']),
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category']),
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      customFieldsJson: $ProvidersTable.$convertercustomFieldsJson.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}custom_fields_json'])),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at']),
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
    );
  }

  @override
  $ProvidersTable createAlias(String alias) {
    return $ProvidersTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, dynamic>?, String?>
      $convertercustomFieldsJson = const JsonMapNullableConverter();
}

class DbProvider extends DataClass implements Insertable<DbProvider> {
  final int id;
  final int? companyId;
  final String? uuid;
  final String name;
  final int? categoryId;
  final int? parentCategoryId;
  final String? category;
  final String? image;
  final String? phone;
  final String? description;
  final Map<String, dynamic>? customFieldsJson;
  final String? updatedAt;
  final bool isDeleted;
  const DbProvider(
      {required this.id,
      this.companyId,
      this.uuid,
      required this.name,
      this.categoryId,
      this.parentCategoryId,
      this.category,
      this.image,
      this.phone,
      this.description,
      this.customFieldsJson,
      this.updatedAt,
      required this.isDeleted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || companyId != null) {
      map['company_id'] = Variable<int>(companyId);
    }
    if (!nullToAbsent || uuid != null) {
      map['uuid'] = Variable<String>(uuid);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    if (!nullToAbsent || parentCategoryId != null) {
      map['parent_category_id'] = Variable<int>(parentCategoryId);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || customFieldsJson != null) {
      map['custom_fields_json'] = Variable<String>(
          $ProvidersTable.$convertercustomFieldsJson.toSql(customFieldsJson));
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  ProvidersCompanion toCompanion(bool nullToAbsent) {
    return ProvidersCompanion(
      id: Value(id),
      companyId: companyId == null && nullToAbsent
          ? const Value.absent()
          : Value(companyId),
      uuid: uuid == null && nullToAbsent ? const Value.absent() : Value(uuid),
      name: Value(name),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      parentCategoryId: parentCategoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentCategoryId),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      customFieldsJson: customFieldsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(customFieldsJson),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      isDeleted: Value(isDeleted),
    );
  }

  factory DbProvider.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbProvider(
      id: serializer.fromJson<int>(json['id']),
      companyId: serializer.fromJson<int?>(json['companyId']),
      uuid: serializer.fromJson<String?>(json['uuid']),
      name: serializer.fromJson<String>(json['name']),
      categoryId: serializer.fromJson<int?>(json['categoryId']),
      parentCategoryId: serializer.fromJson<int?>(json['parentCategoryId']),
      category: serializer.fromJson<String?>(json['category']),
      image: serializer.fromJson<String?>(json['image']),
      phone: serializer.fromJson<String?>(json['phone']),
      description: serializer.fromJson<String?>(json['description']),
      customFieldsJson:
          serializer.fromJson<Map<String, dynamic>?>(json['customFieldsJson']),
      updatedAt: serializer.fromJson<String?>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'companyId': serializer.toJson<int?>(companyId),
      'uuid': serializer.toJson<String?>(uuid),
      'name': serializer.toJson<String>(name),
      'categoryId': serializer.toJson<int?>(categoryId),
      'parentCategoryId': serializer.toJson<int?>(parentCategoryId),
      'category': serializer.toJson<String?>(category),
      'image': serializer.toJson<String?>(image),
      'phone': serializer.toJson<String?>(phone),
      'description': serializer.toJson<String?>(description),
      'customFieldsJson':
          serializer.toJson<Map<String, dynamic>?>(customFieldsJson),
      'updatedAt': serializer.toJson<String?>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  DbProvider copyWith(
          {int? id,
          Value<int?> companyId = const Value.absent(),
          Value<String?> uuid = const Value.absent(),
          String? name,
          Value<int?> categoryId = const Value.absent(),
          Value<int?> parentCategoryId = const Value.absent(),
          Value<String?> category = const Value.absent(),
          Value<String?> image = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<String?> description = const Value.absent(),
          Value<Map<String, dynamic>?> customFieldsJson = const Value.absent(),
          Value<String?> updatedAt = const Value.absent(),
          bool? isDeleted}) =>
      DbProvider(
        id: id ?? this.id,
        companyId: companyId.present ? companyId.value : this.companyId,
        uuid: uuid.present ? uuid.value : this.uuid,
        name: name ?? this.name,
        categoryId: categoryId.present ? categoryId.value : this.categoryId,
        parentCategoryId: parentCategoryId.present
            ? parentCategoryId.value
            : this.parentCategoryId,
        category: category.present ? category.value : this.category,
        image: image.present ? image.value : this.image,
        phone: phone.present ? phone.value : this.phone,
        description: description.present ? description.value : this.description,
        customFieldsJson: customFieldsJson.present
            ? customFieldsJson.value
            : this.customFieldsJson,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        isDeleted: isDeleted ?? this.isDeleted,
      );
  DbProvider copyWithCompanion(ProvidersCompanion data) {
    return DbProvider(
      id: data.id.present ? data.id.value : this.id,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      name: data.name.present ? data.name.value : this.name,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      parentCategoryId: data.parentCategoryId.present
          ? data.parentCategoryId.value
          : this.parentCategoryId,
      category: data.category.present ? data.category.value : this.category,
      image: data.image.present ? data.image.value : this.image,
      phone: data.phone.present ? data.phone.value : this.phone,
      description:
          data.description.present ? data.description.value : this.description,
      customFieldsJson: data.customFieldsJson.present
          ? data.customFieldsJson.value
          : this.customFieldsJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbProvider(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('categoryId: $categoryId, ')
          ..write('parentCategoryId: $parentCategoryId, ')
          ..write('category: $category, ')
          ..write('image: $image, ')
          ..write('phone: $phone, ')
          ..write('description: $description, ')
          ..write('customFieldsJson: $customFieldsJson, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      companyId,
      uuid,
      name,
      categoryId,
      parentCategoryId,
      category,
      image,
      phone,
      description,
      customFieldsJson,
      updatedAt,
      isDeleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbProvider &&
          other.id == this.id &&
          other.companyId == this.companyId &&
          other.uuid == this.uuid &&
          other.name == this.name &&
          other.categoryId == this.categoryId &&
          other.parentCategoryId == this.parentCategoryId &&
          other.category == this.category &&
          other.image == this.image &&
          other.phone == this.phone &&
          other.description == this.description &&
          other.customFieldsJson == this.customFieldsJson &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted);
}

class ProvidersCompanion extends UpdateCompanion<DbProvider> {
  final Value<int> id;
  final Value<int?> companyId;
  final Value<String?> uuid;
  final Value<String> name;
  final Value<int?> categoryId;
  final Value<int?> parentCategoryId;
  final Value<String?> category;
  final Value<String?> image;
  final Value<String?> phone;
  final Value<String?> description;
  final Value<Map<String, dynamic>?> customFieldsJson;
  final Value<String?> updatedAt;
  final Value<bool> isDeleted;
  const ProvidersCompanion({
    this.id = const Value.absent(),
    this.companyId = const Value.absent(),
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.parentCategoryId = const Value.absent(),
    this.category = const Value.absent(),
    this.image = const Value.absent(),
    this.phone = const Value.absent(),
    this.description = const Value.absent(),
    this.customFieldsJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  ProvidersCompanion.insert({
    this.id = const Value.absent(),
    this.companyId = const Value.absent(),
    this.uuid = const Value.absent(),
    required String name,
    this.categoryId = const Value.absent(),
    this.parentCategoryId = const Value.absent(),
    this.category = const Value.absent(),
    this.image = const Value.absent(),
    this.phone = const Value.absent(),
    this.description = const Value.absent(),
    this.customFieldsJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
  }) : name = Value(name);
  static Insertable<DbProvider> custom({
    Expression<int>? id,
    Expression<int>? companyId,
    Expression<String>? uuid,
    Expression<String>? name,
    Expression<int>? categoryId,
    Expression<int>? parentCategoryId,
    Expression<String>? category,
    Expression<String>? image,
    Expression<String>? phone,
    Expression<String>? description,
    Expression<String>? customFieldsJson,
    Expression<String>? updatedAt,
    Expression<bool>? isDeleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (companyId != null) 'company_id': companyId,
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (categoryId != null) 'category_id': categoryId,
      if (parentCategoryId != null) 'parent_category_id': parentCategoryId,
      if (category != null) 'category': category,
      if (image != null) 'image': image,
      if (phone != null) 'phone': phone,
      if (description != null) 'description': description,
      if (customFieldsJson != null) 'custom_fields_json': customFieldsJson,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
    });
  }

  ProvidersCompanion copyWith(
      {Value<int>? id,
      Value<int?>? companyId,
      Value<String?>? uuid,
      Value<String>? name,
      Value<int?>? categoryId,
      Value<int?>? parentCategoryId,
      Value<String?>? category,
      Value<String?>? image,
      Value<String?>? phone,
      Value<String?>? description,
      Value<Map<String, dynamic>?>? customFieldsJson,
      Value<String?>? updatedAt,
      Value<bool>? isDeleted}) {
    return ProvidersCompanion(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      parentCategoryId: parentCategoryId ?? this.parentCategoryId,
      category: category ?? this.category,
      image: image ?? this.image,
      phone: phone ?? this.phone,
      description: description ?? this.description,
      customFieldsJson: customFieldsJson ?? this.customFieldsJson,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<int>(companyId.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (parentCategoryId.present) {
      map['parent_category_id'] = Variable<int>(parentCategoryId.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (customFieldsJson.present) {
      map['custom_fields_json'] = Variable<String>($ProvidersTable
          .$convertercustomFieldsJson
          .toSql(customFieldsJson.value));
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProvidersCompanion(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('categoryId: $categoryId, ')
          ..write('parentCategoryId: $parentCategoryId, ')
          ..write('category: $category, ')
          ..write('image: $image, ')
          ..write('phone: $phone, ')
          ..write('description: $description, ')
          ..write('customFieldsJson: $customFieldsJson, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, DbCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _parentIdMeta =
      const VerificationMeta('parentId');
  @override
  late final GeneratedColumn<int> parentId = GeneratedColumn<int>(
      'parent_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
      'slug', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
      'priority', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        parentId,
        name,
        slug,
        imageUrl,
        priority,
        isActive,
        isDeleted,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<DbCategory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('parent_id')) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
          _slugMeta, slug.isAcceptableOrUnknown(data['slug']!, _slugMeta));
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbCategory(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      parentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parent_id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      slug: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}slug']),
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url']),
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}priority'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class DbCategory extends DataClass implements Insertable<DbCategory> {
  final int id;
  final int? parentId;
  final String name;
  final String? slug;
  final String? imageUrl;
  final int priority;
  final bool isActive;
  final bool isDeleted;
  final String? updatedAt;
  const DbCategory(
      {required this.id,
      this.parentId,
      required this.name,
      this.slug,
      this.imageUrl,
      required this.priority,
      required this.isActive,
      required this.isDeleted,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<int>(parentId);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || slug != null) {
      map['slug'] = Variable<String>(slug);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    map['priority'] = Variable<int>(priority);
    map['is_active'] = Variable<bool>(isActive);
    map['is_deleted'] = Variable<bool>(isDeleted);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      name: Value(name),
      slug: slug == null && nullToAbsent ? const Value.absent() : Value(slug),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      priority: Value(priority),
      isActive: Value(isActive),
      isDeleted: Value(isDeleted),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory DbCategory.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbCategory(
      id: serializer.fromJson<int>(json['id']),
      parentId: serializer.fromJson<int?>(json['parentId']),
      name: serializer.fromJson<String>(json['name']),
      slug: serializer.fromJson<String?>(json['slug']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      priority: serializer.fromJson<int>(json['priority']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      updatedAt: serializer.fromJson<String?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'parentId': serializer.toJson<int?>(parentId),
      'name': serializer.toJson<String>(name),
      'slug': serializer.toJson<String?>(slug),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'priority': serializer.toJson<int>(priority),
      'isActive': serializer.toJson<bool>(isActive),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'updatedAt': serializer.toJson<String?>(updatedAt),
    };
  }

  DbCategory copyWith(
          {int? id,
          Value<int?> parentId = const Value.absent(),
          String? name,
          Value<String?> slug = const Value.absent(),
          Value<String?> imageUrl = const Value.absent(),
          int? priority,
          bool? isActive,
          bool? isDeleted,
          Value<String?> updatedAt = const Value.absent()}) =>
      DbCategory(
        id: id ?? this.id,
        parentId: parentId.present ? parentId.value : this.parentId,
        name: name ?? this.name,
        slug: slug.present ? slug.value : this.slug,
        imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
        priority: priority ?? this.priority,
        isActive: isActive ?? this.isActive,
        isDeleted: isDeleted ?? this.isDeleted,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  DbCategory copyWithCompanion(CategoriesCompanion data) {
    return DbCategory(
      id: data.id.present ? data.id.value : this.id,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      name: data.name.present ? data.name.value : this.name,
      slug: data.slug.present ? data.slug.value : this.slug,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      priority: data.priority.present ? data.priority.value : this.priority,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbCategory(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('name: $name, ')
          ..write('slug: $slug, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('priority: $priority, ')
          ..write('isActive: $isActive, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, parentId, name, slug, imageUrl, priority,
      isActive, isDeleted, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbCategory &&
          other.id == this.id &&
          other.parentId == this.parentId &&
          other.name == this.name &&
          other.slug == this.slug &&
          other.imageUrl == this.imageUrl &&
          other.priority == this.priority &&
          other.isActive == this.isActive &&
          other.isDeleted == this.isDeleted &&
          other.updatedAt == this.updatedAt);
}

class CategoriesCompanion extends UpdateCompanion<DbCategory> {
  final Value<int> id;
  final Value<int?> parentId;
  final Value<String> name;
  final Value<String?> slug;
  final Value<String?> imageUrl;
  final Value<int> priority;
  final Value<bool> isActive;
  final Value<bool> isDeleted;
  final Value<String?> updatedAt;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    this.name = const Value.absent(),
    this.slug = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.priority = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    required String name,
    this.slug = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.priority = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<DbCategory> custom({
    Expression<int>? id,
    Expression<int>? parentId,
    Expression<String>? name,
    Expression<String>? slug,
    Expression<String>? imageUrl,
    Expression<int>? priority,
    Expression<bool>? isActive,
    Expression<bool>? isDeleted,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (parentId != null) 'parent_id': parentId,
      if (name != null) 'name': name,
      if (slug != null) 'slug': slug,
      if (imageUrl != null) 'image_url': imageUrl,
      if (priority != null) 'priority': priority,
      if (isActive != null) 'is_active': isActive,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CategoriesCompanion copyWith(
      {Value<int>? id,
      Value<int?>? parentId,
      Value<String>? name,
      Value<String?>? slug,
      Value<String?>? imageUrl,
      Value<int>? priority,
      Value<bool>? isActive,
      Value<bool>? isDeleted,
      Value<String?>? updatedAt}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      imageUrl: imageUrl ?? this.imageUrl,
      priority: priority ?? this.priority,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<int>(parentId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('name: $name, ')
          ..write('slug: $slug, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('priority: $priority, ')
          ..write('isActive: $isActive, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  $AppDbManager get managers => $AppDbManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $CompaniesTable companies = $CompaniesTable(this);
  late final $UserCompaniesTable userCompanies = $UserCompaniesTable(this);
  late final $ProvidersTable providers = $ProvidersTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final UserDao userDao = UserDao(this as AppDb);
  late final CompanyDao companyDao = CompanyDao(this as AppDb);
  late final ProvidersDao providersDao = ProvidersDao(this as AppDb);
  late final CategoriesDao categoriesDao = CategoriesDao(this as AppDb);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [users, companies, userCompanies, providers, categories];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('users',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('user_companies', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('companies',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('user_companies', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  required String name,
  required String email,
  Value<String?> image,
  Value<Map<String, dynamic>?> customFieldsJson,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> email,
  Value<String?> image,
  Value<Map<String, dynamic>?> customFieldsJson,
});

final class $$UsersTableReferences
    extends BaseReferences<_$AppDb, $UsersTable, DbUser> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UserCompaniesTable, List<DbUserCompany>>
      _userCompaniesRefsTable(_$AppDb db) =>
          MultiTypedResultKey.fromTable(db.userCompanies,
              aliasName:
                  $_aliasNameGenerator(db.users.id, db.userCompanies.userId));

  $$UserCompaniesTableProcessedTableManager get userCompaniesRefs {
    final manager = $$UserCompaniesTableTableManager($_db, $_db.userCompanies)
        .filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_userCompaniesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDb, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get image => $composableBuilder(
      column: $table.image, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Map<String, dynamic>?, Map<String, dynamic>,
          String>
      get customFieldsJson => $composableBuilder(
          column: $table.customFieldsJson,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  Expression<bool> userCompaniesRefs(
      Expression<bool> Function($$UserCompaniesTableFilterComposer f) f) {
    final $$UserCompaniesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.userCompanies,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserCompaniesTableFilterComposer(
              $db: $db,
              $table: $db.userCompanies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersTableOrderingComposer extends Composer<_$AppDb, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get image => $composableBuilder(
      column: $table.image, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customFieldsJson => $composableBuilder(
      column: $table.customFieldsJson,
      builder: (column) => ColumnOrderings(column));
}

class $$UsersTableAnnotationComposer extends Composer<_$AppDb, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
      get customFieldsJson => $composableBuilder(
          column: $table.customFieldsJson, builder: (column) => column);

  Expression<T> userCompaniesRefs<T extends Object>(
      Expression<T> Function($$UserCompaniesTableAnnotationComposer a) f) {
    final $$UserCompaniesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.userCompanies,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserCompaniesTableAnnotationComposer(
              $db: $db,
              $table: $db.userCompanies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersTableTableManager extends RootTableManager<
    _$AppDb,
    $UsersTable,
    DbUser,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (DbUser, $$UsersTableReferences),
    DbUser,
    PrefetchHooks Function({bool userCompaniesRefs})> {
  $$UsersTableTableManager(_$AppDb db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String?> image = const Value.absent(),
            Value<Map<String, dynamic>?> customFieldsJson =
                const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            name: name,
            email: email,
            image: image,
            customFieldsJson: customFieldsJson,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String email,
            Value<String?> image = const Value.absent(),
            Value<Map<String, dynamic>?> customFieldsJson =
                const Value.absent(),
          }) =>
              UsersCompanion.insert(
            id: id,
            name: name,
            email: email,
            image: image,
            customFieldsJson: customFieldsJson,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$UsersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({userCompaniesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (userCompaniesRefs) db.userCompanies
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (userCompaniesRefs)
                    await $_getPrefetchedData<DbUser, $UsersTable,
                            DbUserCompany>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._userCompaniesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0)
                                .userCompaniesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$UsersTableProcessedTableManager = ProcessedTableManager<
    _$AppDb,
    $UsersTable,
    DbUser,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (DbUser, $$UsersTableReferences),
    DbUser,
    PrefetchHooks Function({bool userCompaniesRefs})>;
typedef $$CompaniesTableCreateCompanionBuilder = CompaniesCompanion Function({
  Value<int> id,
  required String uuid,
  required String name,
  Value<String?> logo,
  required String ownerName,
  required String ownerEmail,
  required String plan,
  required String subscriptionStatus,
  Value<DateTime?> currentCycleEnd,
});
typedef $$CompaniesTableUpdateCompanionBuilder = CompaniesCompanion Function({
  Value<int> id,
  Value<String> uuid,
  Value<String> name,
  Value<String?> logo,
  Value<String> ownerName,
  Value<String> ownerEmail,
  Value<String> plan,
  Value<String> subscriptionStatus,
  Value<DateTime?> currentCycleEnd,
});

final class $$CompaniesTableReferences
    extends BaseReferences<_$AppDb, $CompaniesTable, DbCompany> {
  $$CompaniesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UserCompaniesTable, List<DbUserCompany>>
      _userCompaniesRefsTable(_$AppDb db) =>
          MultiTypedResultKey.fromTable(db.userCompanies,
              aliasName: $_aliasNameGenerator(
                  db.companies.id, db.userCompanies.companyId));

  $$UserCompaniesTableProcessedTableManager get userCompaniesRefs {
    final manager = $$UserCompaniesTableTableManager($_db, $_db.userCompanies)
        .filter((f) => f.companyId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_userCompaniesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CompaniesTableFilterComposer
    extends Composer<_$AppDb, $CompaniesTable> {
  $$CompaniesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get logo => $composableBuilder(
      column: $table.logo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ownerName => $composableBuilder(
      column: $table.ownerName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ownerEmail => $composableBuilder(
      column: $table.ownerEmail, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get plan => $composableBuilder(
      column: $table.plan, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get subscriptionStatus => $composableBuilder(
      column: $table.subscriptionStatus,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get currentCycleEnd => $composableBuilder(
      column: $table.currentCycleEnd,
      builder: (column) => ColumnFilters(column));

  Expression<bool> userCompaniesRefs(
      Expression<bool> Function($$UserCompaniesTableFilterComposer f) f) {
    final $$UserCompaniesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.userCompanies,
        getReferencedColumn: (t) => t.companyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserCompaniesTableFilterComposer(
              $db: $db,
              $table: $db.userCompanies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CompaniesTableOrderingComposer
    extends Composer<_$AppDb, $CompaniesTable> {
  $$CompaniesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get logo => $composableBuilder(
      column: $table.logo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ownerName => $composableBuilder(
      column: $table.ownerName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ownerEmail => $composableBuilder(
      column: $table.ownerEmail, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get plan => $composableBuilder(
      column: $table.plan, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get subscriptionStatus => $composableBuilder(
      column: $table.subscriptionStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get currentCycleEnd => $composableBuilder(
      column: $table.currentCycleEnd,
      builder: (column) => ColumnOrderings(column));
}

class $$CompaniesTableAnnotationComposer
    extends Composer<_$AppDb, $CompaniesTable> {
  $$CompaniesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get logo =>
      $composableBuilder(column: $table.logo, builder: (column) => column);

  GeneratedColumn<String> get ownerName =>
      $composableBuilder(column: $table.ownerName, builder: (column) => column);

  GeneratedColumn<String> get ownerEmail => $composableBuilder(
      column: $table.ownerEmail, builder: (column) => column);

  GeneratedColumn<String> get plan =>
      $composableBuilder(column: $table.plan, builder: (column) => column);

  GeneratedColumn<String> get subscriptionStatus => $composableBuilder(
      column: $table.subscriptionStatus, builder: (column) => column);

  GeneratedColumn<DateTime> get currentCycleEnd => $composableBuilder(
      column: $table.currentCycleEnd, builder: (column) => column);

  Expression<T> userCompaniesRefs<T extends Object>(
      Expression<T> Function($$UserCompaniesTableAnnotationComposer a) f) {
    final $$UserCompaniesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.userCompanies,
        getReferencedColumn: (t) => t.companyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserCompaniesTableAnnotationComposer(
              $db: $db,
              $table: $db.userCompanies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CompaniesTableTableManager extends RootTableManager<
    _$AppDb,
    $CompaniesTable,
    DbCompany,
    $$CompaniesTableFilterComposer,
    $$CompaniesTableOrderingComposer,
    $$CompaniesTableAnnotationComposer,
    $$CompaniesTableCreateCompanionBuilder,
    $$CompaniesTableUpdateCompanionBuilder,
    (DbCompany, $$CompaniesTableReferences),
    DbCompany,
    PrefetchHooks Function({bool userCompaniesRefs})> {
  $$CompaniesTableTableManager(_$AppDb db, $CompaniesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CompaniesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CompaniesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CompaniesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> uuid = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> logo = const Value.absent(),
            Value<String> ownerName = const Value.absent(),
            Value<String> ownerEmail = const Value.absent(),
            Value<String> plan = const Value.absent(),
            Value<String> subscriptionStatus = const Value.absent(),
            Value<DateTime?> currentCycleEnd = const Value.absent(),
          }) =>
              CompaniesCompanion(
            id: id,
            uuid: uuid,
            name: name,
            logo: logo,
            ownerName: ownerName,
            ownerEmail: ownerEmail,
            plan: plan,
            subscriptionStatus: subscriptionStatus,
            currentCycleEnd: currentCycleEnd,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String uuid,
            required String name,
            Value<String?> logo = const Value.absent(),
            required String ownerName,
            required String ownerEmail,
            required String plan,
            required String subscriptionStatus,
            Value<DateTime?> currentCycleEnd = const Value.absent(),
          }) =>
              CompaniesCompanion.insert(
            id: id,
            uuid: uuid,
            name: name,
            logo: logo,
            ownerName: ownerName,
            ownerEmail: ownerEmail,
            plan: plan,
            subscriptionStatus: subscriptionStatus,
            currentCycleEnd: currentCycleEnd,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CompaniesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({userCompaniesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (userCompaniesRefs) db.userCompanies
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (userCompaniesRefs)
                    await $_getPrefetchedData<DbCompany, $CompaniesTable,
                            DbUserCompany>(
                        currentTable: table,
                        referencedTable: $$CompaniesTableReferences
                            ._userCompaniesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CompaniesTableReferences(db, table, p0)
                                .userCompaniesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.companyId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CompaniesTableProcessedTableManager = ProcessedTableManager<
    _$AppDb,
    $CompaniesTable,
    DbCompany,
    $$CompaniesTableFilterComposer,
    $$CompaniesTableOrderingComposer,
    $$CompaniesTableAnnotationComposer,
    $$CompaniesTableCreateCompanionBuilder,
    $$CompaniesTableUpdateCompanionBuilder,
    (DbCompany, $$CompaniesTableReferences),
    DbCompany,
    PrefetchHooks Function({bool userCompaniesRefs})>;
typedef $$UserCompaniesTableCreateCompanionBuilder = UserCompaniesCompanion
    Function({
  required int userId,
  required int companyId,
  Value<bool> isOwner,
  Value<int> rowid,
});
typedef $$UserCompaniesTableUpdateCompanionBuilder = UserCompaniesCompanion
    Function({
  Value<int> userId,
  Value<int> companyId,
  Value<bool> isOwner,
  Value<int> rowid,
});

final class $$UserCompaniesTableReferences
    extends BaseReferences<_$AppDb, $UserCompaniesTable, DbUserCompany> {
  $$UserCompaniesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDb db) => db.users
      .createAlias($_aliasNameGenerator(db.userCompanies.userId, db.users.id));

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $CompaniesTable _companyIdTable(_$AppDb db) =>
      db.companies.createAlias(
          $_aliasNameGenerator(db.userCompanies.companyId, db.companies.id));

  $$CompaniesTableProcessedTableManager get companyId {
    final $_column = $_itemColumn<int>('company_id')!;

    final manager = $$CompaniesTableTableManager($_db, $_db.companies)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_companyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$UserCompaniesTableFilterComposer
    extends Composer<_$AppDb, $UserCompaniesTable> {
  $$UserCompaniesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<bool> get isOwner => $composableBuilder(
      column: $table.isOwner, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CompaniesTableFilterComposer get companyId {
    final $$CompaniesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.companyId,
        referencedTable: $db.companies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CompaniesTableFilterComposer(
              $db: $db,
              $table: $db.companies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserCompaniesTableOrderingComposer
    extends Composer<_$AppDb, $UserCompaniesTable> {
  $$UserCompaniesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<bool> get isOwner => $composableBuilder(
      column: $table.isOwner, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CompaniesTableOrderingComposer get companyId {
    final $$CompaniesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.companyId,
        referencedTable: $db.companies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CompaniesTableOrderingComposer(
              $db: $db,
              $table: $db.companies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserCompaniesTableAnnotationComposer
    extends Composer<_$AppDb, $UserCompaniesTable> {
  $$UserCompaniesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<bool> get isOwner =>
      $composableBuilder(column: $table.isOwner, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CompaniesTableAnnotationComposer get companyId {
    final $$CompaniesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.companyId,
        referencedTable: $db.companies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CompaniesTableAnnotationComposer(
              $db: $db,
              $table: $db.companies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserCompaniesTableTableManager extends RootTableManager<
    _$AppDb,
    $UserCompaniesTable,
    DbUserCompany,
    $$UserCompaniesTableFilterComposer,
    $$UserCompaniesTableOrderingComposer,
    $$UserCompaniesTableAnnotationComposer,
    $$UserCompaniesTableCreateCompanionBuilder,
    $$UserCompaniesTableUpdateCompanionBuilder,
    (DbUserCompany, $$UserCompaniesTableReferences),
    DbUserCompany,
    PrefetchHooks Function({bool userId, bool companyId})> {
  $$UserCompaniesTableTableManager(_$AppDb db, $UserCompaniesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserCompaniesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserCompaniesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserCompaniesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> userId = const Value.absent(),
            Value<int> companyId = const Value.absent(),
            Value<bool> isOwner = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserCompaniesCompanion(
            userId: userId,
            companyId: companyId,
            isOwner: isOwner,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int userId,
            required int companyId,
            Value<bool> isOwner = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserCompaniesCompanion.insert(
            userId: userId,
            companyId: companyId,
            isOwner: isOwner,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$UserCompaniesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({userId = false, companyId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable:
                        $$UserCompaniesTableReferences._userIdTable(db),
                    referencedColumn:
                        $$UserCompaniesTableReferences._userIdTable(db).id,
                  ) as T;
                }
                if (companyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.companyId,
                    referencedTable:
                        $$UserCompaniesTableReferences._companyIdTable(db),
                    referencedColumn:
                        $$UserCompaniesTableReferences._companyIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$UserCompaniesTableProcessedTableManager = ProcessedTableManager<
    _$AppDb,
    $UserCompaniesTable,
    DbUserCompany,
    $$UserCompaniesTableFilterComposer,
    $$UserCompaniesTableOrderingComposer,
    $$UserCompaniesTableAnnotationComposer,
    $$UserCompaniesTableCreateCompanionBuilder,
    $$UserCompaniesTableUpdateCompanionBuilder,
    (DbUserCompany, $$UserCompaniesTableReferences),
    DbUserCompany,
    PrefetchHooks Function({bool userId, bool companyId})>;
typedef $$ProvidersTableCreateCompanionBuilder = ProvidersCompanion Function({
  Value<int> id,
  Value<int?> companyId,
  Value<String?> uuid,
  required String name,
  Value<int?> categoryId,
  Value<int?> parentCategoryId,
  Value<String?> category,
  Value<String?> image,
  Value<String?> phone,
  Value<String?> description,
  Value<Map<String, dynamic>?> customFieldsJson,
  Value<String?> updatedAt,
  Value<bool> isDeleted,
});
typedef $$ProvidersTableUpdateCompanionBuilder = ProvidersCompanion Function({
  Value<int> id,
  Value<int?> companyId,
  Value<String?> uuid,
  Value<String> name,
  Value<int?> categoryId,
  Value<int?> parentCategoryId,
  Value<String?> category,
  Value<String?> image,
  Value<String?> phone,
  Value<String?> description,
  Value<Map<String, dynamic>?> customFieldsJson,
  Value<String?> updatedAt,
  Value<bool> isDeleted,
});

class $$ProvidersTableFilterComposer
    extends Composer<_$AppDb, $ProvidersTable> {
  $$ProvidersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get companyId => $composableBuilder(
      column: $table.companyId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get parentCategoryId => $composableBuilder(
      column: $table.parentCategoryId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get image => $composableBuilder(
      column: $table.image, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Map<String, dynamic>?, Map<String, dynamic>,
          String>
      get customFieldsJson => $composableBuilder(
          column: $table.customFieldsJson,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));
}

class $$ProvidersTableOrderingComposer
    extends Composer<_$AppDb, $ProvidersTable> {
  $$ProvidersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get companyId => $composableBuilder(
      column: $table.companyId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get parentCategoryId => $composableBuilder(
      column: $table.parentCategoryId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get image => $composableBuilder(
      column: $table.image, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customFieldsJson => $composableBuilder(
      column: $table.customFieldsJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));
}

class $$ProvidersTableAnnotationComposer
    extends Composer<_$AppDb, $ProvidersTable> {
  $$ProvidersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get companyId =>
      $composableBuilder(column: $table.companyId, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => column);

  GeneratedColumn<int> get parentCategoryId => $composableBuilder(
      column: $table.parentCategoryId, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
      get customFieldsJson => $composableBuilder(
          column: $table.customFieldsJson, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);
}

class $$ProvidersTableTableManager extends RootTableManager<
    _$AppDb,
    $ProvidersTable,
    DbProvider,
    $$ProvidersTableFilterComposer,
    $$ProvidersTableOrderingComposer,
    $$ProvidersTableAnnotationComposer,
    $$ProvidersTableCreateCompanionBuilder,
    $$ProvidersTableUpdateCompanionBuilder,
    (DbProvider, BaseReferences<_$AppDb, $ProvidersTable, DbProvider>),
    DbProvider,
    PrefetchHooks Function()> {
  $$ProvidersTableTableManager(_$AppDb db, $ProvidersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProvidersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProvidersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProvidersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> companyId = const Value.absent(),
            Value<String?> uuid = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int?> categoryId = const Value.absent(),
            Value<int?> parentCategoryId = const Value.absent(),
            Value<String?> category = const Value.absent(),
            Value<String?> image = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<Map<String, dynamic>?> customFieldsJson =
                const Value.absent(),
            Value<String?> updatedAt = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
          }) =>
              ProvidersCompanion(
            id: id,
            companyId: companyId,
            uuid: uuid,
            name: name,
            categoryId: categoryId,
            parentCategoryId: parentCategoryId,
            category: category,
            image: image,
            phone: phone,
            description: description,
            customFieldsJson: customFieldsJson,
            updatedAt: updatedAt,
            isDeleted: isDeleted,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> companyId = const Value.absent(),
            Value<String?> uuid = const Value.absent(),
            required String name,
            Value<int?> categoryId = const Value.absent(),
            Value<int?> parentCategoryId = const Value.absent(),
            Value<String?> category = const Value.absent(),
            Value<String?> image = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<Map<String, dynamic>?> customFieldsJson =
                const Value.absent(),
            Value<String?> updatedAt = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
          }) =>
              ProvidersCompanion.insert(
            id: id,
            companyId: companyId,
            uuid: uuid,
            name: name,
            categoryId: categoryId,
            parentCategoryId: parentCategoryId,
            category: category,
            image: image,
            phone: phone,
            description: description,
            customFieldsJson: customFieldsJson,
            updatedAt: updatedAt,
            isDeleted: isDeleted,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ProvidersTableProcessedTableManager = ProcessedTableManager<
    _$AppDb,
    $ProvidersTable,
    DbProvider,
    $$ProvidersTableFilterComposer,
    $$ProvidersTableOrderingComposer,
    $$ProvidersTableAnnotationComposer,
    $$ProvidersTableCreateCompanionBuilder,
    $$ProvidersTableUpdateCompanionBuilder,
    (DbProvider, BaseReferences<_$AppDb, $ProvidersTable, DbProvider>),
    DbProvider,
    PrefetchHooks Function()>;
typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  Value<int> id,
  Value<int?> parentId,
  required String name,
  Value<String?> slug,
  Value<String?> imageUrl,
  Value<int> priority,
  Value<bool> isActive,
  Value<bool> isDeleted,
  Value<String?> updatedAt,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<int> id,
  Value<int?> parentId,
  Value<String> name,
  Value<String?> slug,
  Value<String?> imageUrl,
  Value<int> priority,
  Value<bool> isActive,
  Value<bool> isDeleted,
  Value<String?> updatedAt,
});

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDb, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get parentId => $composableBuilder(
      column: $table.parentId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get slug => $composableBuilder(
      column: $table.slug, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDb, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get parentId => $composableBuilder(
      column: $table.parentId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get slug => $composableBuilder(
      column: $table.slug, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDb, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get parentId =>
      $composableBuilder(column: $table.parentId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CategoriesTableTableManager extends RootTableManager<
    _$AppDb,
    $CategoriesTable,
    DbCategory,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableAnnotationComposer,
    $$CategoriesTableCreateCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder,
    (DbCategory, BaseReferences<_$AppDb, $CategoriesTable, DbCategory>),
    DbCategory,
    PrefetchHooks Function()> {
  $$CategoriesTableTableManager(_$AppDb db, $CategoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> parentId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> slug = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            Value<int> priority = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<String?> updatedAt = const Value.absent(),
          }) =>
              CategoriesCompanion(
            id: id,
            parentId: parentId,
            name: name,
            slug: slug,
            imageUrl: imageUrl,
            priority: priority,
            isActive: isActive,
            isDeleted: isDeleted,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> parentId = const Value.absent(),
            required String name,
            Value<String?> slug = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            Value<int> priority = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<String?> updatedAt = const Value.absent(),
          }) =>
              CategoriesCompanion.insert(
            id: id,
            parentId: parentId,
            name: name,
            slug: slug,
            imageUrl: imageUrl,
            priority: priority,
            isActive: isActive,
            isDeleted: isDeleted,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CategoriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDb,
    $CategoriesTable,
    DbCategory,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableAnnotationComposer,
    $$CategoriesTableCreateCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder,
    (DbCategory, BaseReferences<_$AppDb, $CategoriesTable, DbCategory>),
    DbCategory,
    PrefetchHooks Function()>;

class $AppDbManager {
  final _$AppDb _db;
  $AppDbManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$CompaniesTableTableManager get companies =>
      $$CompaniesTableTableManager(_db, _db.companies);
  $$UserCompaniesTableTableManager get userCompanies =>
      $$UserCompaniesTableTableManager(_db, _db.userCompanies);
  $$ProvidersTableTableManager get providers =>
      $$ProvidersTableTableManager(_db, _db.providers);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
}
