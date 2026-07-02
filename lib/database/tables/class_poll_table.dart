import 'package:drift/drift.dart';
import 'user_table.dart';

@DataClassName('ClassPoll')
class ClassPollTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(UserTable, #id)();
  
  // Berat badan (kg) - Untuk Line Chart
  RealColumn get weight => real()();
  
  // Tinggi badan (cm) - Untuk Bar Chart 1
  RealColumn get height => real()();
  
  // Ukuran Baju (S, M, L, XL, dll) - Untuk Pie Chart
  TextColumn get shirtSize => text()();
  
  // Ukuran Sepatu - Untuk Scatter Chart / Bar Chart 2
  IntColumn get shoeSize => integer()();
  
  // Usia (Umur) - Untuk Radar Chart / Donut Chart
  IntColumn get age => integer()();
  
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
