import 'package:drift/drift.dart';

@DataClassName('ZodiacData')
class ZodiacTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get namaZodiac => text().unique()();
  DateTimeColumn get tanggalAwal => dateTime()();
  DateTimeColumn get tanggalAkhir => dateTime()();
  TextColumn get deskripsiAsmara => text()();
  TextColumn get deskripsiKarir => text()();
  TextColumn get deskripsiKepribadian => text().nullable()();
  TextColumn get deskripsiKesehatan => text().nullable()();
}
