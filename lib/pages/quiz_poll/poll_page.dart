import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/poll_provider.dart';
import 'widgets/poll_option_card.dart';
import 'widgets/poll_result_widget.dart';

/// Main poll page displaying the sports hobby poll.
///
/// Uses [Consumer<PollProvider>] to observe state changes and rebuild
/// automatically. Handles loading, error, voting, and result states.
///
/// Requirements: 4.1, 4.2, 4.3, 4.4, 4.5, 6.4, 7.4, 8.2, 8.4
class PollPage extends StatefulWidget {
  const PollPage({super.key});

  @override
  State<PollPage> createState() => _PollPageState();
}

class _PollPageState extends State<PollPage> {
  // ---------------------------------------------------------------------------
  // Constants
  // ---------------------------------------------------------------------------

  static const Color _primaryBlue = Color(0xFF1565C0);
  static const Color _accentPurple = Color(0xFF7B1FA2);

  // ---------------------------------------------------------------------------
  // Local state
  // ---------------------------------------------------------------------------

  /// Temporarily selected option before submission (pre-vote state).
  int? _pendingSelection;

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<PollProvider>().loadPoll();
      }
    });
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Consumer<PollProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return _buildLoading();
        }

        if (provider.errorMessage != null && provider.currentPoll == null) {
          return _buildError(provider);
        }

        if (provider.currentPoll == null) {
          return const Center(
            child: Text(
              'Polling tidak tersedia.',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
          );
        }

        return _buildPollContent(provider);
      },
    );
  }

  // ---------------------------------------------------------------------------
  // State builders
  // ---------------------------------------------------------------------------

  Widget _buildLoading() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(color: _primaryBlue),
          SizedBox(height: 16),
          Text(
            'Memuat polling...',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildError(PollProvider provider) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              provider.errorMessage ?? 'Terjadi kesalahan.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => provider.loadPoll(),
              icon: const Icon(Icons.refresh),
              label: const Text('Coba Lagi'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryBlue,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPollContent(PollProvider provider) {
    final poll = provider.currentPoll!;
    final hasVoted = provider.hasVoted();
    final userVoteIndex = provider.userVote?.selectedOption;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Poll question header
          _buildPollHeader(poll.question),
          const SizedBox(height: 20),

          // Options or results
          if (!hasVoted) ...[
            _buildVotingSection(provider, poll.options),
          ] else ...[
            _buildVotedSection(provider, poll, userVoteIndex),
          ],
        ],
      ),
    );
  }

  Widget _buildPollHeader(String question) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1565C0), Color(0xFF7B1FA2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.poll, color: Colors.white70, size: 18),
              SizedBox(width: 8),
              Text(
                'Polling Hobi Olahraga',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            question,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVotingSection(PollProvider provider, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Pilih olahraga favoritmu:',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        ...List.generate(options.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: PollOptionCard(
              optionText: options[index],
              optionIndex: index,
              isSelected: _pendingSelection == index,
              isDisabled: false,
              onTap: () {
                setState(() {
                  _pendingSelection = index;
                });
              },
            ),
          );
        }),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _pendingSelection != null
              ? () => provider.submitVote(_pendingSelection!)
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _accentPurple,
            disabledBackgroundColor: Colors.grey.shade300,
            foregroundColor: Colors.white,
            disabledForegroundColor: Colors.grey,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
          child: const Text(
            'Kirim Vote',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVotedSection(
    PollProvider provider,
    dynamic poll,
    int? userVoteIndex,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Voted confirmation banner
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF4CAF50), width: 1.5),
          ),
          child: const Row(
            children: [
              Icon(Icons.check_circle, color: Color(0xFF4CAF50), size: 20),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Terima kasih! Vote kamu sudah tercatat.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Results widget
        Card(
          elevation: 3,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: PollResultWidget(
            poll: poll,
            voteDistribution: provider.voteDistribution,
            userSelectedOptionIndex: userVoteIndex,
          ),
        ),
      ],
    );
  }
}
