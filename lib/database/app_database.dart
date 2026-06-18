import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'tables/zodiac_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [ZodiacTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(QueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          await _insertInitialData();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          // Implement upgrades here when schemaVersion changes
        },
      );

  Future<void> _insertInitialData() async {
    final initialZodiacs = [
      ZodiacTableCompanion.insert(
        namaZodiac: 'Aries',
        tanggalAwal: DateTime(2024, 3, 21),
        tanggalAkhir: DateTime(2024, 4, 19),
        deskripsiAsmara: 'Asmara Aries dipenuhi dengan gairah dan kejujuran. Mereka menyukai tantangan dalam hubungan.',
        deskripsiKarir: 'Aries adalah pemimpin alami di tempat kerja. Mereka berani mengambil risiko dan sangat kompetitif.',
        deskripsiKepribadian: const Value('Aries memiliki kepribadian yang enerjik, mandiri, dan penuh semangat juang tinggi.'),
        deskripsiKesehatan: const Value('Aries harus waspada terhadap stres karena aktivitas berlebihan dan sering sakit kepala.'),
      ),
      ZodiacTableCompanion.insert(
        namaZodiac: 'Taurus',
        tanggalAwal: DateTime(2024, 4, 20),
        tanggalAkhir: DateTime(2024, 5, 20),
        deskripsiAsmara: 'Taurus mendambakan stabilitas dan kesetiaan. Mereka adalah pasangan yang sabar dan penyayang.',
        deskripsiKarir: 'Taurus sangat tekun, praktis, dan dapat diandalkan. Mereka menyukai stabilitas finansial.',
        deskripsiKepribadian: const Value('Taurus berkepribadian tenang, sabar, keras kepala, tetapi sangat setia kawan.'),
        deskripsiKesehatan: const Value('Taurus cenderung memiliki pencernaan yang sensitif dan perlu menjaga pola makan sehat.'),
      ),
      ZodiacTableCompanion.insert(
        namaZodiac: 'Gemini',
        tanggalAwal: DateTime(2024, 5, 21),
        tanggalAkhir: DateTime(2024, 6, 20),
        deskripsiAsmara: 'Gemini menyukai percakapan intelektual dan kebebasan. Hubungan harus terus bervariasi agar menarik.',
        deskripsiKarir: 'Gemini sangat komunikatif dan pandai beradaptasi. Cocok di bidang media atau hubungan masyarakat.',
        deskripsiKepribadian: const Value('Gemini memiliki kepribadian yang ramah, serbaguna, penuh rasa ingin tahu, namun mudah bosan.'),
        deskripsiKesehatan: const Value('Gemini perlu menjaga sistem pernapasan dan menghindari kelelahan mental.'),
      ),
      ZodiacTableCompanion.insert(
        namaZodiac: 'Cancer',
        tanggalAwal: DateTime(2024, 6, 21),
        tanggalAkhir: DateTime(2024, 7, 22),
        deskripsiAsmara: 'Cancer sangat emosional dan protektif terhadap pasangan. Mereka mendambakan kehangatan keluarga.',
        deskripsiKarir: 'Cancer bekerja paling baik di lingkungan yang mendukung secara emosional. Sangat setia pada tim.',
        deskripsiKepribadian: const Value('Cancer penuh empati, sensitif, intuitif, dan sangat menghargai kenangan masa lalu.'),
        deskripsiKesehatan: const Value('Cancer rentan terhadap masalah lambung ketika sedang stres atau cemas.'),
      ),
      ZodiacTableCompanion.insert(
        namaZodiac: 'Leo',
        tanggalAwal: DateTime(2024, 7, 23),
        tanggalAkhir: DateTime(2024, 8, 22),
        deskripsiAsmara: 'Leo menyukai perhatian dan romansa yang megah. Mereka sangat setia dan murah hati.',
        deskripsiKarir: 'Leo suka berada di pusat perhatian. Pemimpin yang berkarisma dan kreatif.',
        deskripsiKepribadian: const Value('Leo memiliki kepribadian yang percaya diri, hangat, dramatis, dan sangat berani.'),
        deskripsiKesehatan: const Value('Leo perlu menjaga kesehatan jantung dan punggung dengan rutin berolahraga.'),
      ),
      ZodiacTableCompanion.insert(
        namaZodiac: 'Virgo',
        tanggalAwal: DateTime(2024, 8, 23),
        tanggalAkhir: DateTime(2024, 9, 22),
        deskripsiAsmara: 'Virgo mengekspresikan cinta lewat tindakan nyata dan perhatian pada hal-hal kecil.',
        deskripsiKarir: 'Virgo sangat teratur, analitis, dan perfeksionis. Ahli dalam memecahkan masalah rumit.',
        deskripsiKepribadian: const Value('Virgo berkepribadian teliti, praktis, suka menolong, tetapi terkadang terlalu kritis.'),
        deskripsiKesehatan: const Value('Virgo perlu menjaga kesehatan pencernaan karena sering memikirkan hal-hal kecil.'),
      ),
      ZodiacTableCompanion.insert(
        namaZodiac: 'Libra',
        tanggalAwal: DateTime(2024, 9, 23),
        tanggalAkhir: DateTime(2024, 10, 22),
        deskripsiAsmara: 'Libra mencari harmoni dan keseimbangan. Mereka adalah pasangan yang romantis dan diplomatis.',
        deskripsiKarir: 'Libra unggul dalam kerja sama tim dan diplomasi. Mereka menyukai keadilan dan estetika.',
        deskripsiKepribadian: const Value('Libra berkepribadian menyenangkan, adil, artistik, namun terkadang sulit mengambil keputusan.'),
        deskripsiKesehatan: const Value('Libra harus menjaga kesehatan ginjal dengan minum air putih yang cukup.'),
      ),
      ZodiacTableCompanion.insert(
        namaZodiac: 'Scorpio',
        tanggalAwal: DateTime(2024, 10, 23),
        tanggalAkhir: DateTime(2024, 11, 21),
        deskripsiAsmara: 'Asmara Scorpio sangat intens, penuh komitmen, dan cemburuan. Mereka setia hingga akhir.',
        deskripsiKarir: 'Scorpio memiliki fokus luar biasa dan tekad kuat. Sangat mandiri dan intuitif di tempat kerja.',
        deskripsiKepribadian: const Value('Scorpio misterius, kuat, penuh gairah, dan memiliki intuisi yang tajam.'),
        deskripsiKesehatan: const Value('Scorpio perlu menjaga kesehatan sistem reproduksi dan keseimbangan emosional.'),
      ),
      ZodiacTableCompanion.insert(
        namaZodiac: 'Sagittarius',
        tanggalAwal: DateTime(2024, 11, 22),
        tanggalAkhir: DateTime(2024, 12, 21),
        deskripsiAsmara: 'Sagittarius mencintai kebebasan dan petualangan. Hubungan harus menyenangkan dan tidak mengekang.',
        deskripsiKarir: 'Sagittarius menyukai tantangan baru dan pembelajaran. Cocok di bidang pendidikan atau perjalanan.',
        deskripsiKepribadian: const Value('Sagittarius optimistis, jujur, berjiwa petualang, dan menyukai kebenaran filosofis.'),
        deskripsiKesehatan: const Value('Sagittarius perlu menjaga kesehatan paha dan pinggul dengan peregangan rutin.'),
      ),
      ZodiacTableCompanion.insert(
        namaZodiac: 'Capricorn',
        tanggalAwal: DateTime(2024, 12, 22),
        tanggalAkhir: DateTime(2024, 1, 19),
        deskripsiAsmara: 'Capricorn lambat dalam membuka hati, namun sangat serius dan bertanggung jawab dalam hubungan.',
        deskripsiKarir: 'Capricorn sangat ambisius, disiplin, dan pekerja keras. Mereka meniti karier dengan sabar.',
        deskripsiKepribadian: const Value('Capricorn berkepribadian praktis, disiplin, bertanggung jawab, dan memiliki kontrol diri yang baik.'),
        deskripsiKesehatan: const Value('Capricorn perlu memperhatikan kesehatan tulang, persendian, dan gigi.'),
      ),
      ZodiacTableCompanion.insert(
        namaZodiac: 'Aquarius',
        tanggalAwal: DateTime(2024, 1, 20),
        tanggalAkhir: DateTime(2024, 2, 18),
        deskripsiAsmara: 'Aquarius menyukai hubungan yang didasarkan pada persahabatan dan kebebasan berpikir.',
        deskripsiKarir: 'Aquarius inovatif, visioner, dan suka berkolaborasi. Cocok di bidang teknologi dan kemanusiaan.',
        deskripsiKepribadian: const Value('Aquarius berjiwa sosial, orisinal, mandiri, namun terkadang terlihat dingin atau acuh.'),
        deskripsiKesehatan: const Value('Aquarius perlu menjaga kelancaran sirkulasi darah dan kesehatan pergelangan kaki.'),
      ),
      ZodiacTableCompanion.insert(
        namaZodiac: 'Pisces',
        tanggalAwal: DateTime(2024, 2, 19),
        tanggalAkhir: DateTime(2024, 3, 20),
        deskripsiAsmara: 'Pisces adalah sosok romantis sejati yang penuh fantasi. Mereka rela berkorban demi pasangan.',
        deskripsiKarir: 'Pisces sangat kreatif dan intuitif. Cocok bekerja di bidang seni, musik, atau pelayanan sosial.',
        deskripsiKepribadian: const Value('Pisces penuh belas kasih, artistik, sensitif, dan memiliki imajinasi yang kaya.'),
        deskripsiKesehatan: const Value('Pisces perlu menjaga kesehatan kaki dan menghindari kebiasaan melarikan diri dari kenyataan.'),
      ),
    ];

    for (final companion in initialZodiacs) {
      await into(zodiacTable).insert(companion);
    }
  }

  Future<void> insertInitialDataForRecovery() async {
    await _insertInitialData();
  }

  // Exposed helper to clean/recreate the DB file for recovery
  Future<void> deleteDatabaseFile() async {
    await close();
    try {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'zodiac_database.db'));
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      print('Could not delete physical database file: $e');
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'zodiac_database.db'));
    return NativeDatabase.createInBackground(file);
  });
}
