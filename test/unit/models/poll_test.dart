import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/models/poll.dart';

void main() {
  group('Poll', () {
    group('validation', () {
      test('valid poll with 5 correct sports options passes', () {
        final poll = Poll(
          id: 'poll1',
          question: 'Apa hobi olahraga favorit Anda?',
          options: ['Badminton', 'Catur', 'Padel', 'Basket', 'Lari Marathon'],
        );

        expect(poll.isValid(), isTrue);
      });

      test('valid poll with options in different order passes', () {
        final poll = Poll(
          id: 'poll2',
          question: 'Pilih olahraga favorit',
          options: ['Basket', 'Badminton', 'Lari Marathon', 'Catur', 'Padel'],
        );

        expect(poll.isValid(), isTrue);
      });

      test('poll with 4 options fails', () {
        final poll = Poll(
          id: 'poll3',
          question: 'Test?',
          options: ['Badminton', 'Catur', 'Padel', 'Basket'],
        );

        expect(poll.isValid(), isFalse);
      });

      test('poll with 6 options fails', () {
        final poll = Poll(
          id: 'poll4',
          question: 'Test?',
          options: [
            'Badminton',
            'Catur',
            'Padel',
            'Basket',
            'Lari Marathon',
            'Sepak Bola'
          ],
        );

        expect(poll.isValid(), isFalse);
      });

      test('poll with invalid sports option fails', () {
        final poll = Poll(
          id: 'poll5',
          question: 'Test?',
          options: ['Badminton', 'Catur', 'Padel', 'Basket', 'Sepak Bola'],
        );

        expect(poll.isValid(), isFalse);
      });

      test('poll with missing required sport fails', () {
        final poll = Poll(
          id: 'poll6',
          question: 'Test?',
          options: ['Badminton', 'Catur', 'Padel', 'Basket', 'Basket'],
        );

        expect(poll.isValid(), isFalse);
      });

      test('poll with empty options fails', () {
        final poll = Poll(
          id: 'poll7',
          question: 'Test?',
          options: [],
        );

        expect(poll.isValid(), isFalse);
      });

      test('poll with duplicate sports fails', () {
        final poll = Poll(
          id: 'poll8',
          question: 'Test?',
          options: [
            'Badminton',
            'Badminton',
            'Padel',
            'Basket',
            'Lari Marathon'
          ],
        );

        expect(poll.isValid(), isFalse);
      });
    });

    group('JSON serialization', () {
      test('toJson converts poll to map correctly', () {
        final poll = Poll(
          id: 'poll1',
          question: 'Apa hobi olahraga favorit Anda?',
          options: ['Badminton', 'Catur', 'Padel', 'Basket', 'Lari Marathon'],
        );

        final json = poll.toJson();

        expect(json['id'], equals('poll1'));
        expect(json['question'], equals('Apa hobi olahraga favorit Anda?'));
        expect(json['options'],
            equals(['Badminton', 'Catur', 'Padel', 'Basket', 'Lari Marathon']));
      });

      test('fromJson creates poll from map correctly', () {
        final json = {
          'id': 'poll1',
          'question': 'Apa hobi olahraga favorit Anda?',
          'options': ['Badminton', 'Catur', 'Padel', 'Basket', 'Lari Marathon'],
        };

        final poll = Poll.fromJson(json);

        expect(poll.id, equals('poll1'));
        expect(poll.question, equals('Apa hobi olahraga favorit Anda?'));
        expect(poll.options,
            equals(['Badminton', 'Catur', 'Padel', 'Basket', 'Lari Marathon']));
      });

      test('round-trip serialization preserves data', () {
        final original = Poll(
          id: 'poll1',
          question: 'Pilih olahraga favorit',
          options: ['Basket', 'Badminton', 'Lari Marathon', 'Catur', 'Padel'],
        );

        final json = original.toJson();
        final deserialized = Poll.fromJson(json);

        expect(deserialized, equals(original));
      });

      test('fromJson handles options in different order', () {
        final json = {
          'id': 'poll2',
          'question': 'Test?',
          'options': ['Lari Marathon', 'Basket', 'Padel', 'Catur', 'Badminton'],
        };

        final poll = Poll.fromJson(json);

        expect(poll.options,
            equals(['Lari Marathon', 'Basket', 'Padel', 'Catur', 'Badminton']));
      });
    });

    group('defaultPoll factory', () {
      test('creates poll with standard sports options', () {
        final poll = Poll.defaultPoll();

        expect(poll.id, equals('sports_poll_1'));
        expect(poll.question, equals('Apa hobi olahraga favorit Anda?'));
        expect(poll.options,
            equals(['Badminton', 'Catur', 'Padel', 'Basket', 'Lari Marathon']));
        expect(poll.isValid(), isTrue);
      });

      test('default poll has exactly 5 options', () {
        final poll = Poll.defaultPoll();

        expect(poll.options.length, equals(5));
      });

      test('default poll contains all required sports', () {
        final poll = Poll.defaultPoll();

        expect(poll.options.contains('Badminton'), isTrue);
        expect(poll.options.contains('Catur'), isTrue);
        expect(poll.options.contains('Padel'), isTrue);
        expect(poll.options.contains('Basket'), isTrue);
        expect(poll.options.contains('Lari Marathon'), isTrue);
      });
    });

    group('equality', () {
      test('identical polls are equal', () {
        final p1 = Poll(
          id: 'poll1',
          question: 'Test?',
          options: ['Badminton', 'Catur', 'Padel', 'Basket', 'Lari Marathon'],
        );

        final p2 = Poll(
          id: 'poll1',
          question: 'Test?',
          options: ['Badminton', 'Catur', 'Padel', 'Basket', 'Lari Marathon'],
        );

        expect(p1, equals(p2));
        expect(p1.hashCode, equals(p2.hashCode));
      });

      test('different polls are not equal', () {
        final p1 = Poll(
          id: 'poll1',
          question: 'Test?',
          options: ['Badminton', 'Catur', 'Padel', 'Basket', 'Lari Marathon'],
        );

        final p2 = Poll(
          id: 'poll2',
          question: 'Test?',
          options: ['Badminton', 'Catur', 'Padel', 'Basket', 'Lari Marathon'],
        );

        expect(p1, isNot(equals(p2)));
      });

      test('polls with different option order are not equal', () {
        final p1 = Poll(
          id: 'poll1',
          question: 'Test?',
          options: ['Badminton', 'Catur', 'Padel', 'Basket', 'Lari Marathon'],
        );

        final p2 = Poll(
          id: 'poll1',
          question: 'Test?',
          options: ['Basket', 'Badminton', 'Lari Marathon', 'Catur', 'Padel'],
        );

        expect(p1, isNot(equals(p2)));
      });
    });

    group('validSportsOptions constant', () {
      test('contains exactly 5 sports', () {
        expect(Poll.validSportsOptions.length, equals(5));
      });

      test('contains all required sports', () {
        expect(Poll.validSportsOptions, contains('Badminton'));
        expect(Poll.validSportsOptions, contains('Catur'));
        expect(Poll.validSportsOptions, contains('Padel'));
        expect(Poll.validSportsOptions, contains('Basket'));
        expect(Poll.validSportsOptions, contains('Lari Marathon'));
      });
    });

    group('toString', () {
      test('returns string representation of poll', () {
        final poll = Poll(
          id: 'poll1',
          question: 'Test?',
          options: ['Badminton', 'Catur', 'Padel', 'Basket', 'Lari Marathon'],
        );

        final str = poll.toString();

        expect(str, contains('poll1'));
        expect(str, contains('Test?'));
        expect(str, contains('Badminton'));
      });
    });
  });
}
