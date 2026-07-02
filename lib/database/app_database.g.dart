// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ZodiacTableTable extends ZodiacTable
    with TableInfo<$ZodiacTableTable, ZodiacData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ZodiacTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _namaZodiacMeta =
      const VerificationMeta('namaZodiac');
  @override
  late final GeneratedColumn<String> namaZodiac = GeneratedColumn<String>(
      'nama_zodiac', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _tanggalAwalMeta =
      const VerificationMeta('tanggalAwal');
  @override
  late final GeneratedColumn<DateTime> tanggalAwal = GeneratedColumn<DateTime>(
      'tanggal_awal', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _tanggalAkhirMeta =
      const VerificationMeta('tanggalAkhir');
  @override
  late final GeneratedColumn<DateTime> tanggalAkhir = GeneratedColumn<DateTime>(
      'tanggal_akhir', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deskripsiAsmaraMeta =
      const VerificationMeta('deskripsiAsmara');
  @override
  late final GeneratedColumn<String> deskripsiAsmara = GeneratedColumn<String>(
      'deskripsi_asmara', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _deskripsiKarirMeta =
      const VerificationMeta('deskripsiKarir');
  @override
  late final GeneratedColumn<String> deskripsiKarir = GeneratedColumn<String>(
      'deskripsi_karir', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _deskripsiKepribadianMeta =
      const VerificationMeta('deskripsiKepribadian');
  @override
  late final GeneratedColumn<String> deskripsiKepribadian =
      GeneratedColumn<String>('deskripsi_kepribadian', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _deskripsiKesehatanMeta =
      const VerificationMeta('deskripsiKesehatan');
  @override
  late final GeneratedColumn<String> deskripsiKesehatan =
      GeneratedColumn<String>('deskripsi_kesehatan', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        namaZodiac,
        tanggalAwal,
        tanggalAkhir,
        deskripsiAsmara,
        deskripsiKarir,
        deskripsiKepribadian,
        deskripsiKesehatan
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'zodiac_table';
  @override
  VerificationContext validateIntegrity(Insertable<ZodiacData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nama_zodiac')) {
      context.handle(
          _namaZodiacMeta,
          namaZodiac.isAcceptableOrUnknown(
              data['nama_zodiac']!, _namaZodiacMeta));
    } else if (isInserting) {
      context.missing(_namaZodiacMeta);
    }
    if (data.containsKey('tanggal_awal')) {
      context.handle(
          _tanggalAwalMeta,
          tanggalAwal.isAcceptableOrUnknown(
              data['tanggal_awal']!, _tanggalAwalMeta));
    } else if (isInserting) {
      context.missing(_tanggalAwalMeta);
    }
    if (data.containsKey('tanggal_akhir')) {
      context.handle(
          _tanggalAkhirMeta,
          tanggalAkhir.isAcceptableOrUnknown(
              data['tanggal_akhir']!, _tanggalAkhirMeta));
    } else if (isInserting) {
      context.missing(_tanggalAkhirMeta);
    }
    if (data.containsKey('deskripsi_asmara')) {
      context.handle(
          _deskripsiAsmaraMeta,
          deskripsiAsmara.isAcceptableOrUnknown(
              data['deskripsi_asmara']!, _deskripsiAsmaraMeta));
    } else if (isInserting) {
      context.missing(_deskripsiAsmaraMeta);
    }
    if (data.containsKey('deskripsi_karir')) {
      context.handle(
          _deskripsiKarirMeta,
          deskripsiKarir.isAcceptableOrUnknown(
              data['deskripsi_karir']!, _deskripsiKarirMeta));
    } else if (isInserting) {
      context.missing(_deskripsiKarirMeta);
    }
    if (data.containsKey('deskripsi_kepribadian')) {
      context.handle(
          _deskripsiKepribadianMeta,
          deskripsiKepribadian.isAcceptableOrUnknown(
              data['deskripsi_kepribadian']!, _deskripsiKepribadianMeta));
    }
    if (data.containsKey('deskripsi_kesehatan')) {
      context.handle(
          _deskripsiKesehatanMeta,
          deskripsiKesehatan.isAcceptableOrUnknown(
              data['deskripsi_kesehatan']!, _deskripsiKesehatanMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ZodiacData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ZodiacData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      namaZodiac: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nama_zodiac'])!,
      tanggalAwal: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}tanggal_awal'])!,
      tanggalAkhir: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}tanggal_akhir'])!,
      deskripsiAsmara: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}deskripsi_asmara'])!,
      deskripsiKarir: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}deskripsi_karir'])!,
      deskripsiKepribadian: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}deskripsi_kepribadian']),
      deskripsiKesehatan: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}deskripsi_kesehatan']),
    );
  }

  @override
  $ZodiacTableTable createAlias(String alias) {
    return $ZodiacTableTable(attachedDatabase, alias);
  }
}

class ZodiacData extends DataClass implements Insertable<ZodiacData> {
  final int id;
  final String namaZodiac;
  final DateTime tanggalAwal;
  final DateTime tanggalAkhir;
  final String deskripsiAsmara;
  final String deskripsiKarir;
  final String? deskripsiKepribadian;
  final String? deskripsiKesehatan;
  const ZodiacData(
      {required this.id,
      required this.namaZodiac,
      required this.tanggalAwal,
      required this.tanggalAkhir,
      required this.deskripsiAsmara,
      required this.deskripsiKarir,
      this.deskripsiKepribadian,
      this.deskripsiKesehatan});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nama_zodiac'] = Variable<String>(namaZodiac);
    map['tanggal_awal'] = Variable<DateTime>(tanggalAwal);
    map['tanggal_akhir'] = Variable<DateTime>(tanggalAkhir);
    map['deskripsi_asmara'] = Variable<String>(deskripsiAsmara);
    map['deskripsi_karir'] = Variable<String>(deskripsiKarir);
    if (!nullToAbsent || deskripsiKepribadian != null) {
      map['deskripsi_kepribadian'] = Variable<String>(deskripsiKepribadian);
    }
    if (!nullToAbsent || deskripsiKesehatan != null) {
      map['deskripsi_kesehatan'] = Variable<String>(deskripsiKesehatan);
    }
    return map;
  }

  ZodiacTableCompanion toCompanion(bool nullToAbsent) {
    return ZodiacTableCompanion(
      id: Value(id),
      namaZodiac: Value(namaZodiac),
      tanggalAwal: Value(tanggalAwal),
      tanggalAkhir: Value(tanggalAkhir),
      deskripsiAsmara: Value(deskripsiAsmara),
      deskripsiKarir: Value(deskripsiKarir),
      deskripsiKepribadian: deskripsiKepribadian == null && nullToAbsent
          ? const Value.absent()
          : Value(deskripsiKepribadian),
      deskripsiKesehatan: deskripsiKesehatan == null && nullToAbsent
          ? const Value.absent()
          : Value(deskripsiKesehatan),
    );
  }

  factory ZodiacData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ZodiacData(
      id: serializer.fromJson<int>(json['id']),
      namaZodiac: serializer.fromJson<String>(json['namaZodiac']),
      tanggalAwal: serializer.fromJson<DateTime>(json['tanggalAwal']),
      tanggalAkhir: serializer.fromJson<DateTime>(json['tanggalAkhir']),
      deskripsiAsmara: serializer.fromJson<String>(json['deskripsiAsmara']),
      deskripsiKarir: serializer.fromJson<String>(json['deskripsiKarir']),
      deskripsiKepribadian:
          serializer.fromJson<String?>(json['deskripsiKepribadian']),
      deskripsiKesehatan:
          serializer.fromJson<String?>(json['deskripsiKesehatan']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'namaZodiac': serializer.toJson<String>(namaZodiac),
      'tanggalAwal': serializer.toJson<DateTime>(tanggalAwal),
      'tanggalAkhir': serializer.toJson<DateTime>(tanggalAkhir),
      'deskripsiAsmara': serializer.toJson<String>(deskripsiAsmara),
      'deskripsiKarir': serializer.toJson<String>(deskripsiKarir),
      'deskripsiKepribadian': serializer.toJson<String?>(deskripsiKepribadian),
      'deskripsiKesehatan': serializer.toJson<String?>(deskripsiKesehatan),
    };
  }

  ZodiacData copyWith(
          {int? id,
          String? namaZodiac,
          DateTime? tanggalAwal,
          DateTime? tanggalAkhir,
          String? deskripsiAsmara,
          String? deskripsiKarir,
          Value<String?> deskripsiKepribadian = const Value.absent(),
          Value<String?> deskripsiKesehatan = const Value.absent()}) =>
      ZodiacData(
        id: id ?? this.id,
        namaZodiac: namaZodiac ?? this.namaZodiac,
        tanggalAwal: tanggalAwal ?? this.tanggalAwal,
        tanggalAkhir: tanggalAkhir ?? this.tanggalAkhir,
        deskripsiAsmara: deskripsiAsmara ?? this.deskripsiAsmara,
        deskripsiKarir: deskripsiKarir ?? this.deskripsiKarir,
        deskripsiKepribadian: deskripsiKepribadian.present
            ? deskripsiKepribadian.value
            : this.deskripsiKepribadian,
        deskripsiKesehatan: deskripsiKesehatan.present
            ? deskripsiKesehatan.value
            : this.deskripsiKesehatan,
      );
  ZodiacData copyWithCompanion(ZodiacTableCompanion data) {
    return ZodiacData(
      id: data.id.present ? data.id.value : this.id,
      namaZodiac:
          data.namaZodiac.present ? data.namaZodiac.value : this.namaZodiac,
      tanggalAwal:
          data.tanggalAwal.present ? data.tanggalAwal.value : this.tanggalAwal,
      tanggalAkhir: data.tanggalAkhir.present
          ? data.tanggalAkhir.value
          : this.tanggalAkhir,
      deskripsiAsmara: data.deskripsiAsmara.present
          ? data.deskripsiAsmara.value
          : this.deskripsiAsmara,
      deskripsiKarir: data.deskripsiKarir.present
          ? data.deskripsiKarir.value
          : this.deskripsiKarir,
      deskripsiKepribadian: data.deskripsiKepribadian.present
          ? data.deskripsiKepribadian.value
          : this.deskripsiKepribadian,
      deskripsiKesehatan: data.deskripsiKesehatan.present
          ? data.deskripsiKesehatan.value
          : this.deskripsiKesehatan,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ZodiacData(')
          ..write('id: $id, ')
          ..write('namaZodiac: $namaZodiac, ')
          ..write('tanggalAwal: $tanggalAwal, ')
          ..write('tanggalAkhir: $tanggalAkhir, ')
          ..write('deskripsiAsmara: $deskripsiAsmara, ')
          ..write('deskripsiKarir: $deskripsiKarir, ')
          ..write('deskripsiKepribadian: $deskripsiKepribadian, ')
          ..write('deskripsiKesehatan: $deskripsiKesehatan')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      namaZodiac,
      tanggalAwal,
      tanggalAkhir,
      deskripsiAsmara,
      deskripsiKarir,
      deskripsiKepribadian,
      deskripsiKesehatan);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ZodiacData &&
          other.id == this.id &&
          other.namaZodiac == this.namaZodiac &&
          other.tanggalAwal == this.tanggalAwal &&
          other.tanggalAkhir == this.tanggalAkhir &&
          other.deskripsiAsmara == this.deskripsiAsmara &&
          other.deskripsiKarir == this.deskripsiKarir &&
          other.deskripsiKepribadian == this.deskripsiKepribadian &&
          other.deskripsiKesehatan == this.deskripsiKesehatan);
}

class ZodiacTableCompanion extends UpdateCompanion<ZodiacData> {
  final Value<int> id;
  final Value<String> namaZodiac;
  final Value<DateTime> tanggalAwal;
  final Value<DateTime> tanggalAkhir;
  final Value<String> deskripsiAsmara;
  final Value<String> deskripsiKarir;
  final Value<String?> deskripsiKepribadian;
  final Value<String?> deskripsiKesehatan;
  const ZodiacTableCompanion({
    this.id = const Value.absent(),
    this.namaZodiac = const Value.absent(),
    this.tanggalAwal = const Value.absent(),
    this.tanggalAkhir = const Value.absent(),
    this.deskripsiAsmara = const Value.absent(),
    this.deskripsiKarir = const Value.absent(),
    this.deskripsiKepribadian = const Value.absent(),
    this.deskripsiKesehatan = const Value.absent(),
  });
  ZodiacTableCompanion.insert({
    this.id = const Value.absent(),
    required String namaZodiac,
    required DateTime tanggalAwal,
    required DateTime tanggalAkhir,
    required String deskripsiAsmara,
    required String deskripsiKarir,
    this.deskripsiKepribadian = const Value.absent(),
    this.deskripsiKesehatan = const Value.absent(),
  })  : namaZodiac = Value(namaZodiac),
        tanggalAwal = Value(tanggalAwal),
        tanggalAkhir = Value(tanggalAkhir),
        deskripsiAsmara = Value(deskripsiAsmara),
        deskripsiKarir = Value(deskripsiKarir);
  static Insertable<ZodiacData> custom({
    Expression<int>? id,
    Expression<String>? namaZodiac,
    Expression<DateTime>? tanggalAwal,
    Expression<DateTime>? tanggalAkhir,
    Expression<String>? deskripsiAsmara,
    Expression<String>? deskripsiKarir,
    Expression<String>? deskripsiKepribadian,
    Expression<String>? deskripsiKesehatan,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (namaZodiac != null) 'nama_zodiac': namaZodiac,
      if (tanggalAwal != null) 'tanggal_awal': tanggalAwal,
      if (tanggalAkhir != null) 'tanggal_akhir': tanggalAkhir,
      if (deskripsiAsmara != null) 'deskripsi_asmara': deskripsiAsmara,
      if (deskripsiKarir != null) 'deskripsi_karir': deskripsiKarir,
      if (deskripsiKepribadian != null)
        'deskripsi_kepribadian': deskripsiKepribadian,
      if (deskripsiKesehatan != null) 'deskripsi_kesehatan': deskripsiKesehatan,
    });
  }

  ZodiacTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? namaZodiac,
      Value<DateTime>? tanggalAwal,
      Value<DateTime>? tanggalAkhir,
      Value<String>? deskripsiAsmara,
      Value<String>? deskripsiKarir,
      Value<String?>? deskripsiKepribadian,
      Value<String?>? deskripsiKesehatan}) {
    return ZodiacTableCompanion(
      id: id ?? this.id,
      namaZodiac: namaZodiac ?? this.namaZodiac,
      tanggalAwal: tanggalAwal ?? this.tanggalAwal,
      tanggalAkhir: tanggalAkhir ?? this.tanggalAkhir,
      deskripsiAsmara: deskripsiAsmara ?? this.deskripsiAsmara,
      deskripsiKarir: deskripsiKarir ?? this.deskripsiKarir,
      deskripsiKepribadian: deskripsiKepribadian ?? this.deskripsiKepribadian,
      deskripsiKesehatan: deskripsiKesehatan ?? this.deskripsiKesehatan,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (namaZodiac.present) {
      map['nama_zodiac'] = Variable<String>(namaZodiac.value);
    }
    if (tanggalAwal.present) {
      map['tanggal_awal'] = Variable<DateTime>(tanggalAwal.value);
    }
    if (tanggalAkhir.present) {
      map['tanggal_akhir'] = Variable<DateTime>(tanggalAkhir.value);
    }
    if (deskripsiAsmara.present) {
      map['deskripsi_asmara'] = Variable<String>(deskripsiAsmara.value);
    }
    if (deskripsiKarir.present) {
      map['deskripsi_karir'] = Variable<String>(deskripsiKarir.value);
    }
    if (deskripsiKepribadian.present) {
      map['deskripsi_kepribadian'] =
          Variable<String>(deskripsiKepribadian.value);
    }
    if (deskripsiKesehatan.present) {
      map['deskripsi_kesehatan'] = Variable<String>(deskripsiKesehatan.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ZodiacTableCompanion(')
          ..write('id: $id, ')
          ..write('namaZodiac: $namaZodiac, ')
          ..write('tanggalAwal: $tanggalAwal, ')
          ..write('tanggalAkhir: $tanggalAkhir, ')
          ..write('deskripsiAsmara: $deskripsiAsmara, ')
          ..write('deskripsiKarir: $deskripsiKarir, ')
          ..write('deskripsiKepribadian: $deskripsiKepribadian, ')
          ..write('deskripsiKesehatan: $deskripsiKesehatan')
          ..write(')'))
        .toString();
  }
}

class $UserTableTable extends UserTable with TableInfo<$UserTableTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _roleIdMeta = const VerificationMeta('roleId');
  @override
  late final GeneratedColumn<int> roleId = GeneratedColumn<int>(
      'role_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, username, password, roleId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_table';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('role_id')) {
      context.handle(_roleIdMeta,
          roleId.isAcceptableOrUnknown(data['role_id']!, _roleIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password'])!,
      roleId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}role_id']),
    );
  }

  @override
  $UserTableTable createAlias(String alias) {
    return $UserTableTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String username;
  final String password;
  final int? roleId;
  const User(
      {required this.id,
      required this.username,
      required this.password,
      this.roleId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['password'] = Variable<String>(password);
    if (!nullToAbsent || roleId != null) {
      map['role_id'] = Variable<int>(roleId);
    }
    return map;
  }

  UserTableCompanion toCompanion(bool nullToAbsent) {
    return UserTableCompanion(
      id: Value(id),
      username: Value(username),
      password: Value(password),
      roleId:
          roleId == null && nullToAbsent ? const Value.absent() : Value(roleId),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String>(json['password']),
      roleId: serializer.fromJson<int?>(json['roleId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String>(password),
      'roleId': serializer.toJson<int?>(roleId),
    };
  }

  User copyWith(
          {int? id,
          String? username,
          String? password,
          Value<int?> roleId = const Value.absent()}) =>
      User(
        id: id ?? this.id,
        username: username ?? this.username,
        password: password ?? this.password,
        roleId: roleId.present ? roleId.value : this.roleId,
      );
  User copyWithCompanion(UserTableCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      password: data.password.present ? data.password.value : this.password,
      roleId: data.roleId.present ? data.roleId.value : this.roleId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('roleId: $roleId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, username, password, roleId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.username == this.username &&
          other.password == this.password &&
          other.roleId == this.roleId);
}

class UserTableCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> password;
  final Value<int?> roleId;
  const UserTableCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.roleId = const Value.absent(),
  });
  UserTableCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String password,
    this.roleId = const Value.absent(),
  })  : username = Value(username),
        password = Value(password);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? password,
    Expression<int>? roleId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (roleId != null) 'role_id': roleId,
    });
  }

  UserTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? username,
      Value<String>? password,
      Value<int?>? roleId}) {
    return UserTableCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      roleId: roleId ?? this.roleId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (roleId.present) {
      map['role_id'] = Variable<int>(roleId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserTableCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('roleId: $roleId')
          ..write(')'))
        .toString();
  }
}

class $RoleTableTable extends RoleTable with TableInfo<$RoleTableTable, Role> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoleTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _roleNameMeta =
      const VerificationMeta('roleName');
  @override
  late final GeneratedColumn<String> roleName = GeneratedColumn<String>(
      'role_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [id, roleName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'role_table';
  @override
  VerificationContext validateIntegrity(Insertable<Role> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('role_name')) {
      context.handle(_roleNameMeta,
          roleName.isAcceptableOrUnknown(data['role_name']!, _roleNameMeta));
    } else if (isInserting) {
      context.missing(_roleNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Role map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Role(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      roleName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role_name'])!,
    );
  }

  @override
  $RoleTableTable createAlias(String alias) {
    return $RoleTableTable(attachedDatabase, alias);
  }
}

class Role extends DataClass implements Insertable<Role> {
  final int id;
  final String roleName;
  const Role({required this.id, required this.roleName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['role_name'] = Variable<String>(roleName);
    return map;
  }

  RoleTableCompanion toCompanion(bool nullToAbsent) {
    return RoleTableCompanion(
      id: Value(id),
      roleName: Value(roleName),
    );
  }

  factory Role.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Role(
      id: serializer.fromJson<int>(json['id']),
      roleName: serializer.fromJson<String>(json['roleName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'roleName': serializer.toJson<String>(roleName),
    };
  }

  Role copyWith({int? id, String? roleName}) => Role(
        id: id ?? this.id,
        roleName: roleName ?? this.roleName,
      );
  Role copyWithCompanion(RoleTableCompanion data) {
    return Role(
      id: data.id.present ? data.id.value : this.id,
      roleName: data.roleName.present ? data.roleName.value : this.roleName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Role(')
          ..write('id: $id, ')
          ..write('roleName: $roleName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, roleName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Role && other.id == this.id && other.roleName == this.roleName);
}

class RoleTableCompanion extends UpdateCompanion<Role> {
  final Value<int> id;
  final Value<String> roleName;
  const RoleTableCompanion({
    this.id = const Value.absent(),
    this.roleName = const Value.absent(),
  });
  RoleTableCompanion.insert({
    this.id = const Value.absent(),
    required String roleName,
  }) : roleName = Value(roleName);
  static Insertable<Role> custom({
    Expression<int>? id,
    Expression<String>? roleName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (roleName != null) 'role_name': roleName,
    });
  }

  RoleTableCompanion copyWith({Value<int>? id, Value<String>? roleName}) {
    return RoleTableCompanion(
      id: id ?? this.id,
      roleName: roleName ?? this.roleName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (roleName.present) {
      map['role_name'] = Variable<String>(roleName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoleTableCompanion(')
          ..write('id: $id, ')
          ..write('roleName: $roleName')
          ..write(')'))
        .toString();
  }
}

class $PermissionTableTable extends PermissionTable
    with TableInfo<$PermissionTableTable, Permission> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PermissionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _permissionNameMeta =
      const VerificationMeta('permissionName');
  @override
  late final GeneratedColumn<String> permissionName = GeneratedColumn<String>(
      'permission_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [id, permissionName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'permission_table';
  @override
  VerificationContext validateIntegrity(Insertable<Permission> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('permission_name')) {
      context.handle(
          _permissionNameMeta,
          permissionName.isAcceptableOrUnknown(
              data['permission_name']!, _permissionNameMeta));
    } else if (isInserting) {
      context.missing(_permissionNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Permission map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Permission(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      permissionName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}permission_name'])!,
    );
  }

  @override
  $PermissionTableTable createAlias(String alias) {
    return $PermissionTableTable(attachedDatabase, alias);
  }
}

class Permission extends DataClass implements Insertable<Permission> {
  final int id;
  final String permissionName;
  const Permission({required this.id, required this.permissionName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['permission_name'] = Variable<String>(permissionName);
    return map;
  }

  PermissionTableCompanion toCompanion(bool nullToAbsent) {
    return PermissionTableCompanion(
      id: Value(id),
      permissionName: Value(permissionName),
    );
  }

  factory Permission.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Permission(
      id: serializer.fromJson<int>(json['id']),
      permissionName: serializer.fromJson<String>(json['permissionName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'permissionName': serializer.toJson<String>(permissionName),
    };
  }

  Permission copyWith({int? id, String? permissionName}) => Permission(
        id: id ?? this.id,
        permissionName: permissionName ?? this.permissionName,
      );
  Permission copyWithCompanion(PermissionTableCompanion data) {
    return Permission(
      id: data.id.present ? data.id.value : this.id,
      permissionName: data.permissionName.present
          ? data.permissionName.value
          : this.permissionName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Permission(')
          ..write('id: $id, ')
          ..write('permissionName: $permissionName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, permissionName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Permission &&
          other.id == this.id &&
          other.permissionName == this.permissionName);
}

class PermissionTableCompanion extends UpdateCompanion<Permission> {
  final Value<int> id;
  final Value<String> permissionName;
  const PermissionTableCompanion({
    this.id = const Value.absent(),
    this.permissionName = const Value.absent(),
  });
  PermissionTableCompanion.insert({
    this.id = const Value.absent(),
    required String permissionName,
  }) : permissionName = Value(permissionName);
  static Insertable<Permission> custom({
    Expression<int>? id,
    Expression<String>? permissionName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (permissionName != null) 'permission_name': permissionName,
    });
  }

  PermissionTableCompanion copyWith(
      {Value<int>? id, Value<String>? permissionName}) {
    return PermissionTableCompanion(
      id: id ?? this.id,
      permissionName: permissionName ?? this.permissionName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (permissionName.present) {
      map['permission_name'] = Variable<String>(permissionName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PermissionTableCompanion(')
          ..write('id: $id, ')
          ..write('permissionName: $permissionName')
          ..write(')'))
        .toString();
  }
}

class $RolePermissionTableTable extends RolePermissionTable
    with TableInfo<$RolePermissionTableTable, RolePermission> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RolePermissionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _roleIdMeta = const VerificationMeta('roleId');
  @override
  late final GeneratedColumn<int> roleId = GeneratedColumn<int>(
      'role_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _permissionIdMeta =
      const VerificationMeta('permissionId');
  @override
  late final GeneratedColumn<int> permissionId = GeneratedColumn<int>(
      'permission_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [roleId, permissionId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'role_permission_table';
  @override
  VerificationContext validateIntegrity(Insertable<RolePermission> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('role_id')) {
      context.handle(_roleIdMeta,
          roleId.isAcceptableOrUnknown(data['role_id']!, _roleIdMeta));
    } else if (isInserting) {
      context.missing(_roleIdMeta);
    }
    if (data.containsKey('permission_id')) {
      context.handle(
          _permissionIdMeta,
          permissionId.isAcceptableOrUnknown(
              data['permission_id']!, _permissionIdMeta));
    } else if (isInserting) {
      context.missing(_permissionIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {roleId, permissionId};
  @override
  RolePermission map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RolePermission(
      roleId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}role_id'])!,
      permissionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}permission_id'])!,
    );
  }

  @override
  $RolePermissionTableTable createAlias(String alias) {
    return $RolePermissionTableTable(attachedDatabase, alias);
  }
}

class RolePermission extends DataClass implements Insertable<RolePermission> {
  final int roleId;
  final int permissionId;
  const RolePermission({required this.roleId, required this.permissionId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['role_id'] = Variable<int>(roleId);
    map['permission_id'] = Variable<int>(permissionId);
    return map;
  }

  RolePermissionTableCompanion toCompanion(bool nullToAbsent) {
    return RolePermissionTableCompanion(
      roleId: Value(roleId),
      permissionId: Value(permissionId),
    );
  }

  factory RolePermission.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RolePermission(
      roleId: serializer.fromJson<int>(json['roleId']),
      permissionId: serializer.fromJson<int>(json['permissionId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'roleId': serializer.toJson<int>(roleId),
      'permissionId': serializer.toJson<int>(permissionId),
    };
  }

  RolePermission copyWith({int? roleId, int? permissionId}) => RolePermission(
        roleId: roleId ?? this.roleId,
        permissionId: permissionId ?? this.permissionId,
      );
  RolePermission copyWithCompanion(RolePermissionTableCompanion data) {
    return RolePermission(
      roleId: data.roleId.present ? data.roleId.value : this.roleId,
      permissionId: data.permissionId.present
          ? data.permissionId.value
          : this.permissionId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RolePermission(')
          ..write('roleId: $roleId, ')
          ..write('permissionId: $permissionId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(roleId, permissionId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RolePermission &&
          other.roleId == this.roleId &&
          other.permissionId == this.permissionId);
}

class RolePermissionTableCompanion extends UpdateCompanion<RolePermission> {
  final Value<int> roleId;
  final Value<int> permissionId;
  final Value<int> rowid;
  const RolePermissionTableCompanion({
    this.roleId = const Value.absent(),
    this.permissionId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RolePermissionTableCompanion.insert({
    required int roleId,
    required int permissionId,
    this.rowid = const Value.absent(),
  })  : roleId = Value(roleId),
        permissionId = Value(permissionId);
  static Insertable<RolePermission> custom({
    Expression<int>? roleId,
    Expression<int>? permissionId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (roleId != null) 'role_id': roleId,
      if (permissionId != null) 'permission_id': permissionId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RolePermissionTableCompanion copyWith(
      {Value<int>? roleId, Value<int>? permissionId, Value<int>? rowid}) {
    return RolePermissionTableCompanion(
      roleId: roleId ?? this.roleId,
      permissionId: permissionId ?? this.permissionId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (roleId.present) {
      map['role_id'] = Variable<int>(roleId.value);
    }
    if (permissionId.present) {
      map['permission_id'] = Variable<int>(permissionId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RolePermissionTableCompanion(')
          ..write('roleId: $roleId, ')
          ..write('permissionId: $permissionId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ClassPollTableTable extends ClassPollTable
    with TableInfo<$ClassPollTableTable, ClassPoll> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClassPollTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES user_table (id)'));
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
      'height', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _shirtSizeMeta =
      const VerificationMeta('shirtSize');
  @override
  late final GeneratedColumn<String> shirtSize = GeneratedColumn<String>(
      'shirt_size', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _shoeSizeMeta =
      const VerificationMeta('shoeSize');
  @override
  late final GeneratedColumn<int> shoeSize = GeneratedColumn<int>(
      'shoe_size', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
      'age', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, weight, height, shirtSize, shoeSize, age, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'class_poll_table';
  @override
  VerificationContext validateIntegrity(Insertable<ClassPoll> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('height')) {
      context.handle(_heightMeta,
          height.isAcceptableOrUnknown(data['height']!, _heightMeta));
    } else if (isInserting) {
      context.missing(_heightMeta);
    }
    if (data.containsKey('shirt_size')) {
      context.handle(_shirtSizeMeta,
          shirtSize.isAcceptableOrUnknown(data['shirt_size']!, _shirtSizeMeta));
    } else if (isInserting) {
      context.missing(_shirtSizeMeta);
    }
    if (data.containsKey('shoe_size')) {
      context.handle(_shoeSizeMeta,
          shoeSize.isAcceptableOrUnknown(data['shoe_size']!, _shoeSizeMeta));
    } else if (isInserting) {
      context.missing(_shoeSizeMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
          _ageMeta, age.isAcceptableOrUnknown(data['age']!, _ageMeta));
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ClassPoll map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClassPoll(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight'])!,
      height: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}height'])!,
      shirtSize: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}shirt_size'])!,
      shoeSize: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}shoe_size'])!,
      age: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}age'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ClassPollTableTable createAlias(String alias) {
    return $ClassPollTableTable(attachedDatabase, alias);
  }
}

class ClassPoll extends DataClass implements Insertable<ClassPoll> {
  final int id;
  final int userId;
  final double weight;
  final double height;
  final String shirtSize;
  final int shoeSize;
  final int age;
  final DateTime createdAt;
  const ClassPoll(
      {required this.id,
      required this.userId,
      required this.weight,
      required this.height,
      required this.shirtSize,
      required this.shoeSize,
      required this.age,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['weight'] = Variable<double>(weight);
    map['height'] = Variable<double>(height);
    map['shirt_size'] = Variable<String>(shirtSize);
    map['shoe_size'] = Variable<int>(shoeSize);
    map['age'] = Variable<int>(age);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ClassPollTableCompanion toCompanion(bool nullToAbsent) {
    return ClassPollTableCompanion(
      id: Value(id),
      userId: Value(userId),
      weight: Value(weight),
      height: Value(height),
      shirtSize: Value(shirtSize),
      shoeSize: Value(shoeSize),
      age: Value(age),
      createdAt: Value(createdAt),
    );
  }

  factory ClassPoll.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClassPoll(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      weight: serializer.fromJson<double>(json['weight']),
      height: serializer.fromJson<double>(json['height']),
      shirtSize: serializer.fromJson<String>(json['shirtSize']),
      shoeSize: serializer.fromJson<int>(json['shoeSize']),
      age: serializer.fromJson<int>(json['age']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'weight': serializer.toJson<double>(weight),
      'height': serializer.toJson<double>(height),
      'shirtSize': serializer.toJson<String>(shirtSize),
      'shoeSize': serializer.toJson<int>(shoeSize),
      'age': serializer.toJson<int>(age),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ClassPoll copyWith(
          {int? id,
          int? userId,
          double? weight,
          double? height,
          String? shirtSize,
          int? shoeSize,
          int? age,
          DateTime? createdAt}) =>
      ClassPoll(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        weight: weight ?? this.weight,
        height: height ?? this.height,
        shirtSize: shirtSize ?? this.shirtSize,
        shoeSize: shoeSize ?? this.shoeSize,
        age: age ?? this.age,
        createdAt: createdAt ?? this.createdAt,
      );
  ClassPoll copyWithCompanion(ClassPollTableCompanion data) {
    return ClassPoll(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      weight: data.weight.present ? data.weight.value : this.weight,
      height: data.height.present ? data.height.value : this.height,
      shirtSize: data.shirtSize.present ? data.shirtSize.value : this.shirtSize,
      shoeSize: data.shoeSize.present ? data.shoeSize.value : this.shoeSize,
      age: data.age.present ? data.age.value : this.age,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClassPoll(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('weight: $weight, ')
          ..write('height: $height, ')
          ..write('shirtSize: $shirtSize, ')
          ..write('shoeSize: $shoeSize, ')
          ..write('age: $age, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, userId, weight, height, shirtSize, shoeSize, age, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClassPoll &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.weight == this.weight &&
          other.height == this.height &&
          other.shirtSize == this.shirtSize &&
          other.shoeSize == this.shoeSize &&
          other.age == this.age &&
          other.createdAt == this.createdAt);
}

class ClassPollTableCompanion extends UpdateCompanion<ClassPoll> {
  final Value<int> id;
  final Value<int> userId;
  final Value<double> weight;
  final Value<double> height;
  final Value<String> shirtSize;
  final Value<int> shoeSize;
  final Value<int> age;
  final Value<DateTime> createdAt;
  const ClassPollTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.weight = const Value.absent(),
    this.height = const Value.absent(),
    this.shirtSize = const Value.absent(),
    this.shoeSize = const Value.absent(),
    this.age = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ClassPollTableCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required double weight,
    required double height,
    required String shirtSize,
    required int shoeSize,
    required int age,
    this.createdAt = const Value.absent(),
  })  : userId = Value(userId),
        weight = Value(weight),
        height = Value(height),
        shirtSize = Value(shirtSize),
        shoeSize = Value(shoeSize),
        age = Value(age);
  static Insertable<ClassPoll> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<double>? weight,
    Expression<double>? height,
    Expression<String>? shirtSize,
    Expression<int>? shoeSize,
    Expression<int>? age,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (weight != null) 'weight': weight,
      if (height != null) 'height': height,
      if (shirtSize != null) 'shirt_size': shirtSize,
      if (shoeSize != null) 'shoe_size': shoeSize,
      if (age != null) 'age': age,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ClassPollTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? userId,
      Value<double>? weight,
      Value<double>? height,
      Value<String>? shirtSize,
      Value<int>? shoeSize,
      Value<int>? age,
      Value<DateTime>? createdAt}) {
    return ClassPollTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      shirtSize: shirtSize ?? this.shirtSize,
      shoeSize: shoeSize ?? this.shoeSize,
      age: age ?? this.age,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (shirtSize.present) {
      map['shirt_size'] = Variable<String>(shirtSize.value);
    }
    if (shoeSize.present) {
      map['shoe_size'] = Variable<int>(shoeSize.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClassPollTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('weight: $weight, ')
          ..write('height: $height, ')
          ..write('shirtSize: $shirtSize, ')
          ..write('shoeSize: $shoeSize, ')
          ..write('age: $age, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ZodiacTableTable zodiacTable = $ZodiacTableTable(this);
  late final $UserTableTable userTable = $UserTableTable(this);
  late final $RoleTableTable roleTable = $RoleTableTable(this);
  late final $PermissionTableTable permissionTable =
      $PermissionTableTable(this);
  late final $RolePermissionTableTable rolePermissionTable =
      $RolePermissionTableTable(this);
  late final $ClassPollTableTable classPollTable = $ClassPollTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        zodiacTable,
        userTable,
        roleTable,
        permissionTable,
        rolePermissionTable,
        classPollTable
      ];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$ZodiacTableTableCreateCompanionBuilder = ZodiacTableCompanion
    Function({
  Value<int> id,
  required String namaZodiac,
  required DateTime tanggalAwal,
  required DateTime tanggalAkhir,
  required String deskripsiAsmara,
  required String deskripsiKarir,
  Value<String?> deskripsiKepribadian,
  Value<String?> deskripsiKesehatan,
});
typedef $$ZodiacTableTableUpdateCompanionBuilder = ZodiacTableCompanion
    Function({
  Value<int> id,
  Value<String> namaZodiac,
  Value<DateTime> tanggalAwal,
  Value<DateTime> tanggalAkhir,
  Value<String> deskripsiAsmara,
  Value<String> deskripsiKarir,
  Value<String?> deskripsiKepribadian,
  Value<String?> deskripsiKesehatan,
});

class $$ZodiacTableTableFilterComposer
    extends Composer<_$AppDatabase, $ZodiacTableTable> {
  $$ZodiacTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get namaZodiac => $composableBuilder(
      column: $table.namaZodiac, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get tanggalAwal => $composableBuilder(
      column: $table.tanggalAwal, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get tanggalAkhir => $composableBuilder(
      column: $table.tanggalAkhir, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deskripsiAsmara => $composableBuilder(
      column: $table.deskripsiAsmara,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deskripsiKarir => $composableBuilder(
      column: $table.deskripsiKarir,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deskripsiKepribadian => $composableBuilder(
      column: $table.deskripsiKepribadian,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deskripsiKesehatan => $composableBuilder(
      column: $table.deskripsiKesehatan,
      builder: (column) => ColumnFilters(column));
}

class $$ZodiacTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ZodiacTableTable> {
  $$ZodiacTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get namaZodiac => $composableBuilder(
      column: $table.namaZodiac, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get tanggalAwal => $composableBuilder(
      column: $table.tanggalAwal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get tanggalAkhir => $composableBuilder(
      column: $table.tanggalAkhir,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deskripsiAsmara => $composableBuilder(
      column: $table.deskripsiAsmara,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deskripsiKarir => $composableBuilder(
      column: $table.deskripsiKarir,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deskripsiKepribadian => $composableBuilder(
      column: $table.deskripsiKepribadian,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deskripsiKesehatan => $composableBuilder(
      column: $table.deskripsiKesehatan,
      builder: (column) => ColumnOrderings(column));
}

class $$ZodiacTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ZodiacTableTable> {
  $$ZodiacTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get namaZodiac => $composableBuilder(
      column: $table.namaZodiac, builder: (column) => column);

  GeneratedColumn<DateTime> get tanggalAwal => $composableBuilder(
      column: $table.tanggalAwal, builder: (column) => column);

  GeneratedColumn<DateTime> get tanggalAkhir => $composableBuilder(
      column: $table.tanggalAkhir, builder: (column) => column);

  GeneratedColumn<String> get deskripsiAsmara => $composableBuilder(
      column: $table.deskripsiAsmara, builder: (column) => column);

  GeneratedColumn<String> get deskripsiKarir => $composableBuilder(
      column: $table.deskripsiKarir, builder: (column) => column);

  GeneratedColumn<String> get deskripsiKepribadian => $composableBuilder(
      column: $table.deskripsiKepribadian, builder: (column) => column);

  GeneratedColumn<String> get deskripsiKesehatan => $composableBuilder(
      column: $table.deskripsiKesehatan, builder: (column) => column);
}

class $$ZodiacTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ZodiacTableTable,
    ZodiacData,
    $$ZodiacTableTableFilterComposer,
    $$ZodiacTableTableOrderingComposer,
    $$ZodiacTableTableAnnotationComposer,
    $$ZodiacTableTableCreateCompanionBuilder,
    $$ZodiacTableTableUpdateCompanionBuilder,
    (ZodiacData, BaseReferences<_$AppDatabase, $ZodiacTableTable, ZodiacData>),
    ZodiacData,
    PrefetchHooks Function()> {
  $$ZodiacTableTableTableManager(_$AppDatabase db, $ZodiacTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ZodiacTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ZodiacTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ZodiacTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> namaZodiac = const Value.absent(),
            Value<DateTime> tanggalAwal = const Value.absent(),
            Value<DateTime> tanggalAkhir = const Value.absent(),
            Value<String> deskripsiAsmara = const Value.absent(),
            Value<String> deskripsiKarir = const Value.absent(),
            Value<String?> deskripsiKepribadian = const Value.absent(),
            Value<String?> deskripsiKesehatan = const Value.absent(),
          }) =>
              ZodiacTableCompanion(
            id: id,
            namaZodiac: namaZodiac,
            tanggalAwal: tanggalAwal,
            tanggalAkhir: tanggalAkhir,
            deskripsiAsmara: deskripsiAsmara,
            deskripsiKarir: deskripsiKarir,
            deskripsiKepribadian: deskripsiKepribadian,
            deskripsiKesehatan: deskripsiKesehatan,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String namaZodiac,
            required DateTime tanggalAwal,
            required DateTime tanggalAkhir,
            required String deskripsiAsmara,
            required String deskripsiKarir,
            Value<String?> deskripsiKepribadian = const Value.absent(),
            Value<String?> deskripsiKesehatan = const Value.absent(),
          }) =>
              ZodiacTableCompanion.insert(
            id: id,
            namaZodiac: namaZodiac,
            tanggalAwal: tanggalAwal,
            tanggalAkhir: tanggalAkhir,
            deskripsiAsmara: deskripsiAsmara,
            deskripsiKarir: deskripsiKarir,
            deskripsiKepribadian: deskripsiKepribadian,
            deskripsiKesehatan: deskripsiKesehatan,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ZodiacTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ZodiacTableTable,
    ZodiacData,
    $$ZodiacTableTableFilterComposer,
    $$ZodiacTableTableOrderingComposer,
    $$ZodiacTableTableAnnotationComposer,
    $$ZodiacTableTableCreateCompanionBuilder,
    $$ZodiacTableTableUpdateCompanionBuilder,
    (ZodiacData, BaseReferences<_$AppDatabase, $ZodiacTableTable, ZodiacData>),
    ZodiacData,
    PrefetchHooks Function()>;
typedef $$UserTableTableCreateCompanionBuilder = UserTableCompanion Function({
  Value<int> id,
  required String username,
  required String password,
  Value<int?> roleId,
});
typedef $$UserTableTableUpdateCompanionBuilder = UserTableCompanion Function({
  Value<int> id,
  Value<String> username,
  Value<String> password,
  Value<int?> roleId,
});

final class $$UserTableTableReferences
    extends BaseReferences<_$AppDatabase, $UserTableTable, User> {
  $$UserTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ClassPollTableTable, List<ClassPoll>>
      _classPollTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.classPollTable,
              aliasName: $_aliasNameGenerator(
                  db.userTable.id, db.classPollTable.userId));

  $$ClassPollTableTableProcessedTableManager get classPollTableRefs {
    final manager = $$ClassPollTableTableTableManager($_db, $_db.classPollTable)
        .filter((f) => f.userId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_classPollTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$UserTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserTableTable> {
  $$UserTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get password => $composableBuilder(
      column: $table.password, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get roleId => $composableBuilder(
      column: $table.roleId, builder: (column) => ColumnFilters(column));

  Expression<bool> classPollTableRefs(
      Expression<bool> Function($$ClassPollTableTableFilterComposer f) f) {
    final $$ClassPollTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.classPollTable,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassPollTableTableFilterComposer(
              $db: $db,
              $table: $db.classPollTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UserTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserTableTable> {
  $$UserTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get password => $composableBuilder(
      column: $table.password, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get roleId => $composableBuilder(
      column: $table.roleId, builder: (column) => ColumnOrderings(column));
}

class $$UserTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserTableTable> {
  $$UserTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<int> get roleId =>
      $composableBuilder(column: $table.roleId, builder: (column) => column);

  Expression<T> classPollTableRefs<T extends Object>(
      Expression<T> Function($$ClassPollTableTableAnnotationComposer a) f) {
    final $$ClassPollTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.classPollTable,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassPollTableTableAnnotationComposer(
              $db: $db,
              $table: $db.classPollTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UserTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserTableTable,
    User,
    $$UserTableTableFilterComposer,
    $$UserTableTableOrderingComposer,
    $$UserTableTableAnnotationComposer,
    $$UserTableTableCreateCompanionBuilder,
    $$UserTableTableUpdateCompanionBuilder,
    (User, $$UserTableTableReferences),
    User,
    PrefetchHooks Function({bool classPollTableRefs})> {
  $$UserTableTableTableManager(_$AppDatabase db, $UserTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> username = const Value.absent(),
            Value<String> password = const Value.absent(),
            Value<int?> roleId = const Value.absent(),
          }) =>
              UserTableCompanion(
            id: id,
            username: username,
            password: password,
            roleId: roleId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String username,
            required String password,
            Value<int?> roleId = const Value.absent(),
          }) =>
              UserTableCompanion.insert(
            id: id,
            username: username,
            password: password,
            roleId: roleId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$UserTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({classPollTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (classPollTableRefs) db.classPollTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (classPollTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$UserTableTableReferences
                            ._classPollTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UserTableTableReferences(db, table, p0)
                                .classPollTableRefs,
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

typedef $$UserTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserTableTable,
    User,
    $$UserTableTableFilterComposer,
    $$UserTableTableOrderingComposer,
    $$UserTableTableAnnotationComposer,
    $$UserTableTableCreateCompanionBuilder,
    $$UserTableTableUpdateCompanionBuilder,
    (User, $$UserTableTableReferences),
    User,
    PrefetchHooks Function({bool classPollTableRefs})>;
typedef $$RoleTableTableCreateCompanionBuilder = RoleTableCompanion Function({
  Value<int> id,
  required String roleName,
});
typedef $$RoleTableTableUpdateCompanionBuilder = RoleTableCompanion Function({
  Value<int> id,
  Value<String> roleName,
});

class $$RoleTableTableFilterComposer
    extends Composer<_$AppDatabase, $RoleTableTable> {
  $$RoleTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get roleName => $composableBuilder(
      column: $table.roleName, builder: (column) => ColumnFilters(column));
}

class $$RoleTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RoleTableTable> {
  $$RoleTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get roleName => $composableBuilder(
      column: $table.roleName, builder: (column) => ColumnOrderings(column));
}

class $$RoleTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoleTableTable> {
  $$RoleTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get roleName =>
      $composableBuilder(column: $table.roleName, builder: (column) => column);
}

class $$RoleTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RoleTableTable,
    Role,
    $$RoleTableTableFilterComposer,
    $$RoleTableTableOrderingComposer,
    $$RoleTableTableAnnotationComposer,
    $$RoleTableTableCreateCompanionBuilder,
    $$RoleTableTableUpdateCompanionBuilder,
    (Role, BaseReferences<_$AppDatabase, $RoleTableTable, Role>),
    Role,
    PrefetchHooks Function()> {
  $$RoleTableTableTableManager(_$AppDatabase db, $RoleTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoleTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoleTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoleTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> roleName = const Value.absent(),
          }) =>
              RoleTableCompanion(
            id: id,
            roleName: roleName,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String roleName,
          }) =>
              RoleTableCompanion.insert(
            id: id,
            roleName: roleName,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RoleTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RoleTableTable,
    Role,
    $$RoleTableTableFilterComposer,
    $$RoleTableTableOrderingComposer,
    $$RoleTableTableAnnotationComposer,
    $$RoleTableTableCreateCompanionBuilder,
    $$RoleTableTableUpdateCompanionBuilder,
    (Role, BaseReferences<_$AppDatabase, $RoleTableTable, Role>),
    Role,
    PrefetchHooks Function()>;
typedef $$PermissionTableTableCreateCompanionBuilder = PermissionTableCompanion
    Function({
  Value<int> id,
  required String permissionName,
});
typedef $$PermissionTableTableUpdateCompanionBuilder = PermissionTableCompanion
    Function({
  Value<int> id,
  Value<String> permissionName,
});

class $$PermissionTableTableFilterComposer
    extends Composer<_$AppDatabase, $PermissionTableTable> {
  $$PermissionTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get permissionName => $composableBuilder(
      column: $table.permissionName,
      builder: (column) => ColumnFilters(column));
}

class $$PermissionTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PermissionTableTable> {
  $$PermissionTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get permissionName => $composableBuilder(
      column: $table.permissionName,
      builder: (column) => ColumnOrderings(column));
}

class $$PermissionTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PermissionTableTable> {
  $$PermissionTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get permissionName => $composableBuilder(
      column: $table.permissionName, builder: (column) => column);
}

class $$PermissionTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PermissionTableTable,
    Permission,
    $$PermissionTableTableFilterComposer,
    $$PermissionTableTableOrderingComposer,
    $$PermissionTableTableAnnotationComposer,
    $$PermissionTableTableCreateCompanionBuilder,
    $$PermissionTableTableUpdateCompanionBuilder,
    (
      Permission,
      BaseReferences<_$AppDatabase, $PermissionTableTable, Permission>
    ),
    Permission,
    PrefetchHooks Function()> {
  $$PermissionTableTableTableManager(
      _$AppDatabase db, $PermissionTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PermissionTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PermissionTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PermissionTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> permissionName = const Value.absent(),
          }) =>
              PermissionTableCompanion(
            id: id,
            permissionName: permissionName,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String permissionName,
          }) =>
              PermissionTableCompanion.insert(
            id: id,
            permissionName: permissionName,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PermissionTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PermissionTableTable,
    Permission,
    $$PermissionTableTableFilterComposer,
    $$PermissionTableTableOrderingComposer,
    $$PermissionTableTableAnnotationComposer,
    $$PermissionTableTableCreateCompanionBuilder,
    $$PermissionTableTableUpdateCompanionBuilder,
    (
      Permission,
      BaseReferences<_$AppDatabase, $PermissionTableTable, Permission>
    ),
    Permission,
    PrefetchHooks Function()>;
typedef $$RolePermissionTableTableCreateCompanionBuilder
    = RolePermissionTableCompanion Function({
  required int roleId,
  required int permissionId,
  Value<int> rowid,
});
typedef $$RolePermissionTableTableUpdateCompanionBuilder
    = RolePermissionTableCompanion Function({
  Value<int> roleId,
  Value<int> permissionId,
  Value<int> rowid,
});

class $$RolePermissionTableTableFilterComposer
    extends Composer<_$AppDatabase, $RolePermissionTableTable> {
  $$RolePermissionTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get roleId => $composableBuilder(
      column: $table.roleId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get permissionId => $composableBuilder(
      column: $table.permissionId, builder: (column) => ColumnFilters(column));
}

class $$RolePermissionTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RolePermissionTableTable> {
  $$RolePermissionTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get roleId => $composableBuilder(
      column: $table.roleId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get permissionId => $composableBuilder(
      column: $table.permissionId,
      builder: (column) => ColumnOrderings(column));
}

class $$RolePermissionTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RolePermissionTableTable> {
  $$RolePermissionTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get roleId =>
      $composableBuilder(column: $table.roleId, builder: (column) => column);

  GeneratedColumn<int> get permissionId => $composableBuilder(
      column: $table.permissionId, builder: (column) => column);
}

class $$RolePermissionTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RolePermissionTableTable,
    RolePermission,
    $$RolePermissionTableTableFilterComposer,
    $$RolePermissionTableTableOrderingComposer,
    $$RolePermissionTableTableAnnotationComposer,
    $$RolePermissionTableTableCreateCompanionBuilder,
    $$RolePermissionTableTableUpdateCompanionBuilder,
    (
      RolePermission,
      BaseReferences<_$AppDatabase, $RolePermissionTableTable, RolePermission>
    ),
    RolePermission,
    PrefetchHooks Function()> {
  $$RolePermissionTableTableTableManager(
      _$AppDatabase db, $RolePermissionTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RolePermissionTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RolePermissionTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RolePermissionTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> roleId = const Value.absent(),
            Value<int> permissionId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RolePermissionTableCompanion(
            roleId: roleId,
            permissionId: permissionId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int roleId,
            required int permissionId,
            Value<int> rowid = const Value.absent(),
          }) =>
              RolePermissionTableCompanion.insert(
            roleId: roleId,
            permissionId: permissionId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RolePermissionTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RolePermissionTableTable,
    RolePermission,
    $$RolePermissionTableTableFilterComposer,
    $$RolePermissionTableTableOrderingComposer,
    $$RolePermissionTableTableAnnotationComposer,
    $$RolePermissionTableTableCreateCompanionBuilder,
    $$RolePermissionTableTableUpdateCompanionBuilder,
    (
      RolePermission,
      BaseReferences<_$AppDatabase, $RolePermissionTableTable, RolePermission>
    ),
    RolePermission,
    PrefetchHooks Function()>;
typedef $$ClassPollTableTableCreateCompanionBuilder = ClassPollTableCompanion
    Function({
  Value<int> id,
  required int userId,
  required double weight,
  required double height,
  required String shirtSize,
  required int shoeSize,
  required int age,
  Value<DateTime> createdAt,
});
typedef $$ClassPollTableTableUpdateCompanionBuilder = ClassPollTableCompanion
    Function({
  Value<int> id,
  Value<int> userId,
  Value<double> weight,
  Value<double> height,
  Value<String> shirtSize,
  Value<int> shoeSize,
  Value<int> age,
  Value<DateTime> createdAt,
});

final class $$ClassPollTableTableReferences
    extends BaseReferences<_$AppDatabase, $ClassPollTableTable, ClassPoll> {
  $$ClassPollTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $UserTableTable _userIdTable(_$AppDatabase db) =>
      db.userTable.createAlias(
          $_aliasNameGenerator(db.classPollTable.userId, db.userTable.id));

  $$UserTableTableProcessedTableManager? get userId {
    if ($_item.userId == null) return null;
    final manager = $$UserTableTableTableManager($_db, $_db.userTable)
        .filter((f) => f.id($_item.userId!));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ClassPollTableTableFilterComposer
    extends Composer<_$AppDatabase, $ClassPollTableTable> {
  $$ClassPollTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get shirtSize => $composableBuilder(
      column: $table.shirtSize, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get shoeSize => $composableBuilder(
      column: $table.shoeSize, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$UserTableTableFilterComposer get userId {
    final $$UserTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableFilterComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ClassPollTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ClassPollTableTable> {
  $$ClassPollTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get shirtSize => $composableBuilder(
      column: $table.shirtSize, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get shoeSize => $composableBuilder(
      column: $table.shoeSize, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$UserTableTableOrderingComposer get userId {
    final $$UserTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableOrderingComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ClassPollTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClassPollTableTable> {
  $$ClassPollTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<double> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<String> get shirtSize =>
      $composableBuilder(column: $table.shirtSize, builder: (column) => column);

  GeneratedColumn<int> get shoeSize =>
      $composableBuilder(column: $table.shoeSize, builder: (column) => column);

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$UserTableTableAnnotationComposer get userId {
    final $$UserTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableAnnotationComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ClassPollTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ClassPollTableTable,
    ClassPoll,
    $$ClassPollTableTableFilterComposer,
    $$ClassPollTableTableOrderingComposer,
    $$ClassPollTableTableAnnotationComposer,
    $$ClassPollTableTableCreateCompanionBuilder,
    $$ClassPollTableTableUpdateCompanionBuilder,
    (ClassPoll, $$ClassPollTableTableReferences),
    ClassPoll,
    PrefetchHooks Function({bool userId})> {
  $$ClassPollTableTableTableManager(
      _$AppDatabase db, $ClassPollTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClassPollTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClassPollTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClassPollTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<double> weight = const Value.absent(),
            Value<double> height = const Value.absent(),
            Value<String> shirtSize = const Value.absent(),
            Value<int> shoeSize = const Value.absent(),
            Value<int> age = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ClassPollTableCompanion(
            id: id,
            userId: userId,
            weight: weight,
            height: height,
            shirtSize: shirtSize,
            shoeSize: shoeSize,
            age: age,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int userId,
            required double weight,
            required double height,
            required String shirtSize,
            required int shoeSize,
            required int age,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ClassPollTableCompanion.insert(
            id: id,
            userId: userId,
            weight: weight,
            height: height,
            shirtSize: shirtSize,
            shoeSize: shoeSize,
            age: age,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ClassPollTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
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
                        $$ClassPollTableTableReferences._userIdTable(db),
                    referencedColumn:
                        $$ClassPollTableTableReferences._userIdTable(db).id,
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

typedef $$ClassPollTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ClassPollTableTable,
    ClassPoll,
    $$ClassPollTableTableFilterComposer,
    $$ClassPollTableTableOrderingComposer,
    $$ClassPollTableTableAnnotationComposer,
    $$ClassPollTableTableCreateCompanionBuilder,
    $$ClassPollTableTableUpdateCompanionBuilder,
    (ClassPoll, $$ClassPollTableTableReferences),
    ClassPoll,
    PrefetchHooks Function({bool userId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ZodiacTableTableTableManager get zodiacTable =>
      $$ZodiacTableTableTableManager(_db, _db.zodiacTable);
  $$UserTableTableTableManager get userTable =>
      $$UserTableTableTableManager(_db, _db.userTable);
  $$RoleTableTableTableManager get roleTable =>
      $$RoleTableTableTableManager(_db, _db.roleTable);
  $$PermissionTableTableTableManager get permissionTable =>
      $$PermissionTableTableTableManager(_db, _db.permissionTable);
  $$RolePermissionTableTableTableManager get rolePermissionTable =>
      $$RolePermissionTableTableTableManager(_db, _db.rolePermissionTable);
  $$ClassPollTableTableTableManager get classPollTable =>
      $$ClassPollTableTableTableManager(_db, _db.classPollTable);
}
