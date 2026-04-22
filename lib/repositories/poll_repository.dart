import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/poll.dart';
import '../models/poll_result.dart';
import '../models/poll_vote.dart';

/// Repository for managing poll data and user votes.
///
/// Persists the user's vote and vote distribution using SharedPreferences.
class PollRepository {
  static const String _voteKey = 'poll_vote';
  static const String _resultsKey = 'poll_results';

  final SharedPreferences _prefs;

  PollRepository(this._prefs);

  // ---------------------------------------------------------------------------
  // Public API
  // ---------------------------------------------------------------------------

  /// Returns the default sports hobby poll.
  Future<Poll> getPoll() async {
    try {
      return Poll.defaultPoll();
    } catch (e) {
      return Poll.defaultPoll();
    }
  }

  /// Saves the user's [vote] to SharedPreferences under [_voteKey].
  Future<void> saveVote(PollVote vote) async {
    try {
      final encoded = jsonEncode(vote.toJson());
      await _prefs.setString(_voteKey, encoded);
    } catch (e) {
      // Silently fail — in-memory state is still valid
    }
  }

  /// Retrieves the user's previously saved vote, or `null` if not found.
  Future<PollVote?> getUserVote() async {
    try {
      final raw = _prefs.getString(_voteKey);
      if (raw == null || raw.isEmpty) return null;

      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) return null;

      return PollVote.fromJson(decoded);
    } catch (e) {
      return null;
    }
  }

  /// Retrieves the current vote distribution from SharedPreferences.
  ///
  /// Returns [PollResult.empty()] if no distribution has been saved yet.
  Future<PollResult> getVoteDistribution() async {
    try {
      final raw = _prefs.getString(_resultsKey);
      if (raw == null || raw.isEmpty) return PollResult.empty();

      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) return PollResult.empty();

      return PollResult.fromJson(decoded);
    } catch (e) {
      return PollResult.empty();
    }
  }

  /// Increments the vote count for [optionIndex] in SharedPreferences.
  ///
  /// Loads the current distribution, increments the count for the given
  /// option, and saves the updated distribution back.
  Future<void> updateVoteDistribution(int optionIndex) async {
    try {
      final current = await getVoteDistribution();

      // Build updated vote counts
      final updatedCounts = Map<int, int>.from(current.voteCounts);
      updatedCounts[optionIndex] = (updatedCounts[optionIndex] ?? 0) + 1;

      final updatedResult = PollResult.fromDistribution(updatedCounts);
      final encoded = jsonEncode(updatedResult.toJson());
      await _prefs.setString(_resultsKey, encoded);
    } catch (e) {
      // Silently fail — in-memory state is still valid
    }
  }
}
