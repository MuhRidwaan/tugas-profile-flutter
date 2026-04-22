import 'package:flutter/foundation.dart';

import '../models/poll.dart';
import '../models/poll_result.dart';
import '../models/poll_vote.dart';
import '../repositories/poll_repository.dart';

/// Provider managing poll state: current poll, user vote, vote distribution,
/// loading state, and errors.
///
/// Integrates with [PollRepository] for data persistence and notifies
/// listeners on every state change so the UI can rebuild automatically.
class PollProvider extends ChangeNotifier {
  final PollRepository _repository;

  // ---------------------------------------------------------------------------
  // State
  // ---------------------------------------------------------------------------

  Poll? _currentPoll;
  PollVote? _userVote;
  PollResult _voteDistribution = PollResult.empty();
  bool _isLoading = false;
  String? _errorMessage;

  // ---------------------------------------------------------------------------
  // Constructor
  // ---------------------------------------------------------------------------

  PollProvider(this._repository);

  // ---------------------------------------------------------------------------
  // Public getters
  // ---------------------------------------------------------------------------

  /// The currently loaded poll, or null if not yet loaded.
  Poll? get currentPoll => _currentPoll;

  /// The user's vote, or null if the user has not voted yet.
  PollVote? get userVote => _userVote;

  /// The current vote distribution across all options.
  PollResult get voteDistribution => _voteDistribution;

  /// Whether a loading operation is in progress.
  bool get isLoading => _isLoading;

  /// Non-null when the last operation produced an error.
  String? get errorMessage => _errorMessage;

  // ---------------------------------------------------------------------------
  // Public methods
  // ---------------------------------------------------------------------------

  /// Loads the poll, the user's previous vote, and the current vote
  /// distribution from the repository.
  ///
  /// Sets [isLoading] to `true` while working and clears it when done.
  /// On failure, [errorMessage] is set with a user-friendly description.
  Future<void> loadPoll() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final poll = await _repository.getPoll();
      _currentPoll = poll;

      // Restore previously saved vote
      try {
        final savedVote = await _repository.getUserVote();
        _userVote = savedVote;
      } catch (e) {
        debugPrint('Failed to load saved vote: $e');
        _userVote = null;
        _errorMessage = 'Could not load previous vote. Starting fresh.';
      }

      // Load current vote distribution
      try {
        final distribution = await _repository.getVoteDistribution();
        _voteDistribution = distribution;
      } catch (e) {
        debugPrint('Failed to load vote distribution: $e');
        _voteDistribution = PollResult.empty();
      }
    } catch (e) {
      debugPrint('Failed to load poll: $e');
      _currentPoll = null;
      _errorMessage = 'Could not load poll. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Records the user's vote for [optionIndex], persists it via the
  /// repository, updates the local vote distribution, and notifies listeners.
  ///
  /// Silently ignores attempts to vote more than once.
  /// On persistence failure the in-memory state is still updated so the UI
  /// remains consistent.
  Future<void> submitVote(int optionIndex) async {
    // Guard against voting twice
    if (hasVoted()) {
      debugPrint('User has already voted. Ignoring duplicate vote.');
      return;
    }

    if (_currentPoll == null) {
      debugPrint('Cannot submit vote: poll not loaded.');
      return;
    }

    final vote = PollVote(
      pollId: _currentPoll!.id,
      selectedOption: optionIndex,
      votedAt: DateTime.now(),
    );

    // Update in-memory state immediately (optimistic UI)
    _userVote = vote;

    // Increment the local distribution optimistically
    final updatedCounts = Map<int, int>.from(_voteDistribution.voteCounts);
    updatedCounts[optionIndex] = (updatedCounts[optionIndex] ?? 0) + 1;
    _voteDistribution = PollResult.fromDistribution(updatedCounts);

    notifyListeners();

    // Persist vote asynchronously
    try {
      await _repository.saveVote(vote);
    } catch (e) {
      debugPrint('Failed to save vote: $e');
      _errorMessage = 'Having trouble saving your vote.';
      notifyListeners();
    }

    // Update persisted vote distribution
    try {
      await _repository.updateVoteDistribution(optionIndex);
    } catch (e) {
      debugPrint('Failed to update vote distribution: $e');
    }
  }

  /// Returns `true` if the user has already submitted a vote.
  bool hasVoted() {
    return _userVote != null;
  }

  /// Returns the percentage of votes for [optionIndex] (0–100).
  ///
  /// Delegates to [PollResult.getPercentage].
  double getPercentage(int optionIndex) {
    return _voteDistribution.getPercentage(optionIndex);
  }

  /// Returns the vote count for [optionIndex].
  ///
  /// Delegates to [PollResult.getCount].
  int getVoteCount(int optionIndex) {
    return _voteDistribution.getCount(optionIndex);
  }
}
