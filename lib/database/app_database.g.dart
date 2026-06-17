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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ZodiacTableTable zodiacTable = $ZodiacTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [zodiacTable];
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

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ZodiacTableTableTableManager get zodiacTable =>
      $$ZodiacTableTableTableManager(_db, _db.zodiacTable);
}
