# Implementation Plan: Questionnaire and Polling Feature

## Overview

This implementation plan breaks down the Questionnaire and Polling feature into discrete, incremental coding tasks. The feature adds interactive quiz and polling capabilities to the existing Flutter profile application using a 3-layer architecture (Presentation, Business Logic, Data). Implementation follows the Provider pattern for state management and SharedPreferences for local data persistence.

## Tasks

- [x] 1. Setup dependencies and project structure
  - Add `provider: ^6.1.1` and `shared_preferences: ^2.2.2` to pubspec.yaml
  - Create directory structure: `lib/models/`, `lib/providers/`, `lib/repositories/`, `lib/pages/quiz_poll/`, `lib/pages/quiz_poll/widgets/`
  - Run `flutter pub get` to install dependencies
  - _Requirements: 6.1, 6.2_

- [x] 2. Implement data models with validation and serialization
  - [x] 2.1 Create QuizQuestion model
    - Implement `lib/models/quiz_question.dart` with QuestionType enum, validation method, and JSON serialization
    - Enforce invariants: exactly 5 options, at least 1 correct answer, valid indices (0-4)
    - _Requirements: 1.1, 2.1_

  - [x] 2.2 Create QuizAnswer model
    - Implement `lib/models/quiz_answer.dart` with validation and JSON serialization
    - Include questionId, selectedOptions, isCorrect flag, and submittedAt timestamp
    - _Requirements: 1.2, 1.5, 7.1_

  - [x] 2.3 Create Poll model
    - Implement `lib/models/poll.dart` with validation and JSON serialization
    - Enforce exactly 5 sports options: Badminton, Catur, Padel, Basket, Lari Marathon
    - _Requirements: 4.1_

  - [x] 2.4 Create PollVote model
    - Implement `lib/models/poll_vote.dart` with validation and JSON serialization
    - Include pollId, selectedOption index, and votedAt timestamp
    - _Requirements: 4.2, 7.2_

  - [x] 2.5 Create PollResult model
    - Implement `lib/models/poll_result.dart` with vote count and percentage calculation methods
    - Implement `getPercentage()` and `getCount()` methods with zero-division handling
    - _Requirements: 4.4, 5.1, 5.2_

- [x] 3. Implement data layer repositories
  - [x] 3.1 Create QuizRepository
    - Implement `lib/repositories/quiz_repository.dart` with SharedPreferences integration
    - Implement methods: `getQuestions()`, `saveAnswer()`, `getAnswer()`, `getAllAnswers()`
    - Use hardcoded quiz questions initially (extensible to remote API later)
    - Handle serialization/deserialization with error handling
    - _Requirements: 1.1, 1.2, 7.1, 7.3_

  - [x] 3.2 Create PollRepository
    - Implement `lib/repositories/poll_repository.dart` with SharedPreferences integration
    - Implement methods: `getPoll()`, `saveVote()`, `getUserVote()`, `getVoteDistribution()`, `updateVoteDistribution()`
    - Use SharedPreferences keys: `poll_vote`, `poll_results`
    - _Requirements: 4.1, 4.2, 7.2, 7.4_

- [x] 4. Implement business logic providers
  - [x] 4.1 Create QuizProvider
    - Implement `lib/providers/quiz_provider.dart` extending ChangeNotifier
    - Implement state management: questions list, user answers map, loading state
    - Implement methods: `loadQuestions()`, `submitAnswer()`, `validateAnswer()`, `isQuestionAnswered()`
    - Integrate with QuizRepository for data persistence
    - Add error handling for loading and persistence failures
    - _Requirements: 1.2, 1.4, 1.5, 2.2, 2.4, 2.5, 7.1, 7.3, 7.5_

  - [x] 4.2 Create PollProvider
    - Implement `lib/providers/poll_provider.dart` extending ChangeNotifier
    - Implement state management: current poll, user vote, vote distribution, loading state
    - Implement methods: `loadPoll()`, `submitVote()`, `hasVoted()`, calculate vote percentages
    - Integrate with PollRepository for data persistence
    - Add error handling for loading and persistence failures
    - _Requirements: 4.2, 4.3, 4.5, 5.1, 5.2, 5.3, 7.2, 7.4_

- [x] 5. Checkpoint - Verify data layer and business logic
  - Ensure all tests pass, ask the user if questions arise.

- [x] 6. Implement UI widgets
  - [x] 6.1 Create QuizQuestionCard widget
    - Implement `lib/pages/quiz_poll/widgets/quiz_question_card.dart`
    - Display question text, 5 answer options with RadioListTile for single choice
    - Handle answer selection and disabled state after submission
    - Apply Material Design 3 styling with existing app color scheme
    - _Requirements: 1.1, 1.4, 1.5, 2.1, 2.4, 2.5_

  - [x] 6.2 Create FeedbackWidget
    - Implement `lib/pages/quiz_poll/widgets/feedback_widget.dart`
    - Display success (green) or error (red) indicators based on answer correctness
    - Show selected answer and correct answers when incorrect
    - Add smooth fade-in animation (< 100ms)
    - _Requirements: 1.2, 1.3, 2.2, 2.3, 3.1, 3.2, 3.3, 3.4, 3.5, 8.1_

  - [x] 6.3 Create PollOptionCard widget
    - Implement `lib/pages/quiz_poll/widgets/poll_option_card.dart`
    - Display sports option with selection state
    - Handle single selection with visual feedback
    - Apply accent color highlighting for selected option
    - _Requirements: 4.1, 4.5, 5.5_

  - [x] 6.4 Create PollResultWidget
    - Implement `lib/pages/quiz_poll/widgets/poll_result_widget.dart`
    - Display vote distribution with progress bars
    - Show percentage and count for each option
    - Highlight user's selected option with distinct styling
    - Add smooth animation for result updates (< 200ms)
    - _Requirements: 4.3, 4.4, 5.1, 5.2, 5.3, 5.4, 5.5, 8.2_

- [x] 7. Implement main pages
  - [x] 7.1 Create QuizPage
    - Implement `lib/pages/quiz_poll/quiz_page.dart` with Consumer<QuizProvider>
    - Display scrollable list of QuizQuestionCard widgets
    - Show loading indicators and error states
    - Handle answer submission through provider
    - Display FeedbackWidget for each answered question
    - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 6.3, 7.3, 8.1, 8.3_

  - [x] 7.2 Create PollPage
    - Implement `lib/pages/quiz_poll/poll_page.dart` with Consumer<PollProvider>
    - Display poll question and PollOptionCard widgets
    - Show loading indicators and error states
    - Handle vote submission through provider
    - Display PollResultWidget after voting
    - _Requirements: 4.1, 4.2, 4.3, 4.4, 4.5, 6.4, 7.4, 8.2, 8.4_

  - [x] 7.3 Create QuizPollPage (main entry point)
    - Implement `lib/pages/quiz_poll/quiz_poll_page.dart` with TabBar navigation
    - Create tabs for "Kuesioner" and "Polling"
    - Use TabBarView to switch between QuizPage and PollPage
    - Apply consistent styling with existing app theme
    - _Requirements: 6.1, 6.2, 6.3, 6.4_

- [x] 8. Integrate with main app navigation
  - [x] 8.1 Update main.dart with Provider setup
    - Wrap MyApp with MultiProvider
    - Register QuizProvider and PollProvider
    - Initialize providers with repository instances
    - _Requirements: 6.1, 6.2_

  - [x] 8.2 Update MainScreen with new navigation tab
    - Add QuizPollPage to _pages list in `lib/pages/main_screen.dart`
    - Add new BottomNavigationBarItem with quiz icon and "Quiz & Poll" label
    - Update _currentIndex handling for 4 tabs
    - _Requirements: 6.1, 6.2, 6.5_

- [x] 9. Checkpoint - Verify UI integration and navigation
  - Ensure all tests pass, ask the user if questions arise.

- [x] 10. Implement property-based tests
  - [x]* 10.1 Write property test for vote percentage calculation
    - **Property 1: Vote Percentage Calculation Correctness**
    - **Validates: Requirements 4.4, 5.2**
    - Create `test/property/vote_calculation_property_test.dart`
    - Generate random vote distributions (100+ iterations)
    - Verify percentages sum to 100% within floating-point tolerance
    - Test edge cases: single vote, equal distribution, skewed distribution

  - [x]* 10.2 Write property test for QuizAnswer serialization
    - **Property 2: Quiz Answer Serialization Round-Trip**
    - **Validates: Requirements 7.1**
    - Create `test/property/quiz_serialization_property_test.dart`
    - Generate random QuizAnswer objects (100+ iterations)
    - Verify round-trip: serialize to JSON, deserialize, compare equality
    - Test all fields: questionId, selectedOptions, isCorrect, submittedAt

  - [x]* 10.3 Write property test for PollVote serialization
    - **Property 3: Poll Vote Serialization Round-Trip**
    - **Validates: Requirements 7.2**
    - Create `test/property/poll_serialization_property_test.dart`
    - Generate random PollVote objects (100+ iterations)
    - Verify round-trip: serialize to JSON, deserialize, compare equality
    - Test all fields: pollId, selectedOption, votedAt

  - [x]* 10.4 Write property test for answer validation
    - **Property 4: Answer Validation Correctness**
    - **Validates: Requirements 1.2, 2.2**
    - Create `test/property/answer_validation_property_test.dart`
    - Generate random QuizQuestion and answer combinations (100+ iterations)
    - Verify validation returns true only when selected options match correct answers
    - Test both single choice and multiple choice question types

- [x] 11. Implement unit tests
  - [x]* 11.1 Write unit tests for data models
    - Create `test/unit/models/quiz_question_test.dart`, `quiz_answer_test.dart`, `poll_test.dart`, `poll_vote_test.dart`, `poll_result_test.dart`
    - Test validation methods: valid and invalid cases
    - Test JSON serialization/deserialization
    - Test edge cases: empty options, invalid indices, zero votes
    - _Requirements: 1.1, 2.1, 4.1, 7.1, 7.2_

  - [x]* 11.2 Write unit tests for repositories
    - Create `test/unit/repositories/quiz_repository_test.dart`, `poll_repository_test.dart`
    - Mock SharedPreferences for isolated testing
    - Test CRUD operations: save, load, update
    - Test error handling: corrupted data, missing keys
    - _Requirements: 7.1, 7.2, 7.3, 7.4_

  - [x]* 11.3 Write unit tests for providers
    - Create `test/unit/providers/quiz_provider_test.dart`, `poll_provider_test.dart`
    - Mock repositories for isolated testing
    - Test state management: loading, submission, validation
    - Test notifyListeners calls
    - Test error handling and recovery
    - _Requirements: 1.2, 1.4, 1.5, 2.2, 2.4, 2.5, 4.2, 4.3, 4.5, 7.5_

- [x] 12. Implement widget tests
  - [x]* 12.1 Write widget tests for QuizQuestionCard
    - Create `test/widget/quiz_question_card_test.dart`
    - Test rendering: question text, 5 options, radio buttons
    - Test interaction: option selection, disabled state
    - Test visual styling: colors, fonts, spacing
    - _Requirements: 1.1, 1.4, 1.5_

  - [x]* 12.2 Write widget tests for FeedbackWidget
    - Create `test/widget/feedback_widget_test.dart`
    - Test success state: green indicator, correct message
    - Test error state: red indicator, correct answers shown
    - Test animation: fade-in timing
    - _Requirements: 3.1, 3.2, 3.3, 3.4, 3.5_

  - [x]* 12.3 Write widget tests for PollOptionCard and PollResultWidget
    - Create `test/widget/poll_option_card_test.dart`, `poll_result_widget_test.dart`
    - Test option rendering and selection
    - Test result visualization: progress bars, percentages, counts
    - Test highlighted selection styling
    - _Requirements: 4.1, 4.5, 5.1, 5.2, 5.4, 5.5_

  - [x]* 12.4 Write widget tests for main pages
    - Create `test/widget/quiz_page_test.dart`, `poll_page_test.dart`, `quiz_poll_page_test.dart`
    - Mock providers for isolated testing
    - Test page rendering with loading, loaded, and error states
    - Test user interactions: answer submission, vote submission
    - Test navigation: tab switching, back navigation
    - _Requirements: 6.1, 6.2, 6.3, 6.4, 6.5_

- [x] 13. Implement integration tests
  - [x]* 13.1 Write integration test for complete quiz flow
    - Create `test/integration/quiz_flow_test.dart`
    - Test navigation from main app to quiz page
    - Test answering multiple questions with feedback
    - Test data persistence across provider lifecycle
    - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 6.1, 6.3, 7.1, 7.3_

  - [ ]* 13.2 Write integration test for complete poll flow
    - Create `test/integration/poll_flow_test.dart`
    - Test navigation from main app to poll page
    - Test voting and result visualization
    - Test data persistence across provider lifecycle
    - _Requirements: 4.1, 4.2, 4.3, 4.4, 4.5, 6.2, 6.4, 7.2, 7.4_

  - [x]* 13.3 Write integration test for data persistence
    - Create `test/integration/persistence_test.dart`
    - Test app restart scenario: save data, restart, verify data loaded
    - Test quiz answers persistence
    - Test poll vote persistence
    - _Requirements: 7.1, 7.2, 7.3, 7.4_

- [x] 14. Implement performance tests
  - [x]* 14.1 Write performance test for answer feedback timing
    - Create `test/performance/feedback_timing_test.dart`
    - Measure time from answer selection to feedback display
    - Verify feedback appears within 100ms requirement
    - _Requirements: 8.1_

  - [x]* 14.2 Write performance test for poll result update timing
    - Create `test/performance/poll_update_timing_test.dart`
    - Measure time from vote submission to result display
    - Verify results update within 200ms requirement
    - _Requirements: 8.2_

  - [x]* 14.3 Write stress test for rapid interactions
    - Create `test/performance/rapid_interaction_test.dart`
    - Test rapid answer selections and navigation
    - Verify no errors or crashes occur
    - _Requirements: 8.5_

- [x] 15. Final checkpoint and polish
  - Run all tests and verify 80%+ code coverage
  - Test on physical devices (Android and iOS)
  - Verify accessibility: screen reader support, color contrast, touch targets
  - Verify responsive behavior on different screen sizes
  - Ensure all tests pass, ask the user if questions arise.

## Notes

- Tasks marked with `*` are optional and can be skipped for faster MVP
- Each task references specific requirements for traceability
- Checkpoints ensure incremental validation and user feedback
- Property tests validate universal correctness properties from design
- Unit tests validate specific examples and edge cases
- Widget tests validate UI components and interactions
- Integration tests validate end-to-end user flows
- Performance tests validate responsiveness requirements (100ms, 200ms)
- Implementation uses Dart/Flutter with Provider pattern and SharedPreferences
- All code should follow existing app conventions and styling
- Test coverage goal: 80%+ overall, 95%+ for business logic
