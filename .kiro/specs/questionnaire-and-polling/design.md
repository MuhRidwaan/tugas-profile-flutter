# Design Document: Questionnaire and Polling Feature

## Overview

The Questionnaire and Polling feature adds interactive quiz and polling capabilities to the existing Flutter profile application. This feature enables users to answer quiz questions with immediate feedback and participate in sports hobby polling with real-time result visualization.

### Key Design Goals

1. **Seamless Integration**: Integrate naturally with the existing bottom navigation structure
2. **Immediate Feedback**: Provide instant visual feedback for user interactions
3. **Data Persistence**: Maintain user progress and votes across app sessions
4. **Responsive UI**: Ensure smooth animations and transitions under 200ms
5. **Maintainability**: Use clear separation of concerns between UI, business logic, and data layers

### Technology Stack

- **Framework**: Flutter 3.4.3+
- **State Management**: Provider pattern (lightweight, fits existing app architecture)
- **Local Storage**: SharedPreferences for simple key-value persistence
- **UI Components**: Material Design 3 widgets with custom styling

## Architecture

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                        Presentation Layer                    │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │  Quiz Page   │  │  Poll Page   │  │ Result Widget│      │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘      │
│         │                  │                  │              │
└─────────┼──────────────────┼──────────────────┼──────────────┘
          │                  │                  │
┌─────────┼──────────────────┼──────────────────┼──────────────┐
│         │     Business Logic Layer            │              │
│  ┌──────▼───────┐  ┌──────▼───────┐  ┌──────▼───────┐      │
│  │QuizProvider  │  │PollProvider  │  │ValidationSvc │      │
│  └──────┬───────┘  └──────┬───────┘  └──────────────┘      │
│         │                  │                                 │
└─────────┼──────────────────┼─────────────────────────────────┘
          │                  │
┌─────────┼──────────────────┼─────────────────────────────────┐
│         │       Data Layer │                                 │
│  ┌──────▼───────┐  ┌──────▼───────┐                         │
│  │QuizRepository│  │PollRepository│                         │
│  └──────┬───────┘  └──────┬───────┘                         │
│         │                  │                                 │
│  ┌──────▼──────────────────▼───────┐                        │
│  │     SharedPreferences            │                        │
│  └──────────────────────────────────┘                        │
└─────────────────────────────────────────────────────────────┘
```

### Layer Responsibilities

**Presentation Layer**
- Renders UI components and handles user interactions
- Observes state changes from providers
- Displays feedback and results
- Manages navigation and animations

**Business Logic Layer**
- Manages application state using Provider pattern
- Validates quiz answers against correct answers
- Calculates poll statistics (counts, percentages)
- Coordinates data persistence operations
- Enforces business rules (single selection, answer locking)

**Data Layer**
- Abstracts data persistence operations
- Provides repository interfaces for quiz and poll data
- Handles serialization/deserialization
- Manages SharedPreferences interactions

## Components and Interfaces

### Core Components

#### 1. QuizProvider

```dart
class QuizProvider extends ChangeNotifier {
  List<QuizQuestion> _questions;
  Map<String, QuizAnswer> _userAnswers;
  
  // Public interface
  List<QuizQuestion> get questions;
  QuizAnswer? getAnswerForQuestion(String questionId);
  bool isQuestionAnswered(String questionId);
  
  Future<void> loadQuestions();
  Future<void> submitAnswer(String questionId, List<int> selectedOptions);
  bool validateAnswer(String questionId, List<int> selectedOptions);
}
```

**Responsibilities:**
- Load quiz questions from repository
- Track user answers and submission state
- Validate answers against correct options
- Notify UI of state changes
- Persist answers through repository

#### 2. PollProvider

```dart
class PollProvider extends ChangeNotifier {
  Poll? _currentPoll;
  int? _userVote;
  Map<int, int> _voteDistribution;
  
  // Public interface
  Poll? get currentPoll;
  int? get userVote;
  Map<int, int> get voteDistribution;
  Map<int, double> get votePercentages;
  
  Future<void> loadPoll();
  Future<void> submitVote(int optionIndex);
  bool hasVoted();
}
```

**Responsibilities:**
- Load poll data and current results
- Track user's vote
- Calculate vote distribution and percentages
- Notify UI of result updates
- Persist vote through repository

#### 3. QuizRepository

```dart
class QuizRepository {
  final SharedPreferences _prefs;
  
  Future<List<QuizQuestion>> getQuestions();
  Future<void> saveAnswer(String questionId, QuizAnswer answer);
  Future<QuizAnswer?> getAnswer(String questionId);
  Future<Map<String, QuizAnswer>> getAllAnswers();
}
```

**Responsibilities:**
- Provide quiz questions (initially hardcoded, extensible to remote)
- Persist user answers to SharedPreferences
- Retrieve saved answers on app restart
- Serialize/deserialize quiz data

#### 4. PollRepository

```dart
class PollRepository {
  final SharedPreferences _prefs;
  
  Future<Poll> getPoll();
  Future<void> saveVote(int optionIndex);
  Future<int?> getUserVote();
  Future<Map<int, int>> getVoteDistribution();
  Future<void> updateVoteDistribution(int optionIndex);
}
```

**Responsibilities:**
- Provide poll definition (sports options)
- Persist user's vote
- Track vote distribution locally
- Calculate and return vote statistics

### UI Components

#### QuizPage

Main page displaying quiz questions with answer options.

**Key Features:**
- Scrollable list of quiz questions
- Single/multiple choice question cards
- Answer selection with radio buttons/checkboxes
- Immediate feedback display
- Disabled state after answer submission

#### PollPage

Page displaying sports hobby poll with results.

**Key Features:**
- Poll question and options display
- Single selection interface
- Real-time result visualization
- Progress bars showing vote distribution
- Highlighted user selection

#### FeedbackWidget

Reusable widget for displaying quiz answer feedback.

**Key Features:**
- Success/error visual indicators
- Color-coded feedback (green/red)
- Display of correct answers when wrong
- Smooth fade-in animation

#### PollResultWidget

Widget for visualizing poll results.

**Key Features:**
- Progress bars for each option
- Percentage and count display
- Highlighted user selection
- Responsive layout

## Data Models

### QuizQuestion

```dart
class QuizQuestion {
  final String id;
  final String questionText;
  final QuestionType type; // single or multiple
  final List<String> options; // exactly 5 options
  final List<int> correctAnswers; // indices of correct options
  
  QuizQuestion({
    required this.id,
    required this.questionText,
    required this.type,
    required this.options,
    required this.correctAnswers,
  });
  
  // Validation
  bool isValid() {
    return options.length == 5 && 
           correctAnswers.isNotEmpty &&
           correctAnswers.every((i) => i >= 0 && i < 5);
  }
  
  // Serialization
  Map<String, dynamic> toJson();
  factory QuizQuestion.fromJson(Map<String, dynamic> json);
}

enum QuestionType { single, multiple }
```

**Invariants:**
- Must have exactly 5 options
- Must have at least one correct answer
- Correct answer indices must be valid (0-4)
- Single choice questions have exactly 1 correct answer
- Multiple choice questions have 2+ correct answers

### QuizAnswer

```dart
class QuizAnswer {
  final String questionId;
  final List<int> selectedOptions; // indices selected by user
  final bool isCorrect;
  final DateTime submittedAt;
  
  QuizAnswer({
    required this.questionId,
    required this.selectedOptions,
    required this.isCorrect,
    required this.submittedAt,
  });
  
  // Serialization
  Map<String, dynamic> toJson();
  factory QuizAnswer.fromJson(Map<String, dynamic> json);
}
```

**Invariants:**
- Must reference a valid question ID
- Selected options must be valid indices (0-4)
- Single choice answers have exactly 1 selected option
- Multiple choice answers have exactly 1 selected option (per requirement)

### Poll

```dart
class Poll {
  final String id;
  final String question;
  final List<String> options; // exactly 5 sports options
  
  Poll({
    required this.id,
    required this.question,
    required this.options,
  });
  
  // Validation
  bool isValid() {
    return options.length == 5;
  }
  
  // Serialization
  Map<String, dynamic> toJson();
  factory Poll.fromJson(Map<String, dynamic> json);
}
```

**Invariants:**
- Must have exactly 5 options
- Options are: Badminton, Catur, Padel, Basket, Lari Marathon

### PollVote

```dart
class PollVote {
  final String pollId;
  final int selectedOption; // index of selected sport
  final DateTime votedAt;
  
  PollVote({
    required this.pollId,
    required this.selectedOption,
    required this.votedAt,
  });
  
  // Validation
  bool isValid() {
    return selectedOption >= 0 && selectedOption < 5;
  }
  
  // Serialization
  Map<String, dynamic> toJson();
  factory PollVote.fromJson(Map<String, dynamic> json);
}
```

**Invariants:**
- Selected option must be valid index (0-4)
- Must reference a valid poll ID

### PollResult

```dart
class PollResult {
  final Map<int, int> voteCounts; // option index -> vote count
  final int totalVotes;
  
  PollResult({
    required this.voteCounts,
    required this.totalVotes,
  });
  
  // Calculate percentage for an option
  double getPercentage(int optionIndex) {
    if (totalVotes == 0) return 0.0;
    final count = voteCounts[optionIndex] ?? 0;
    return (count / totalVotes) * 100.0;
  }
  
  // Get count for an option
  int getCount(int optionIndex) {
    return voteCounts[optionIndex] ?? 0;
  }
}
```

## State Management Approach

### Provider Pattern

We use the Provider pattern for state management because:

1. **Simplicity**: Fits the existing app's straightforward architecture
2. **Reactivity**: Automatic UI updates via ChangeNotifier
3. **Testability**: Easy to mock and test providers
4. **Performance**: Efficient rebuilds with Consumer widgets
5. **Learning Curve**: Minimal for team already familiar with Flutter

### Provider Setup

```dart
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuizProvider()),
        ChangeNotifierProvider(create: (_) => PollProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
```

### State Flow

**Quiz Answer Submission Flow:**
```
User taps option
  → QuizPage calls provider.submitAnswer()
    → Provider validates answer
      → Provider updates _userAnswers map
        → Provider calls repository.saveAnswer()
          → Provider notifies listeners
            → UI rebuilds with feedback
```

**Poll Vote Submission Flow:**
```
User selects sport
  → PollPage calls provider.submitVote()
    → Provider records vote
      → Provider updates vote distribution
        → Provider calls repository.saveVote()
          → Provider notifies listeners
            → UI rebuilds with results
```

### State Persistence

**SharedPreferences Keys:**
- `quiz_answers`: JSON map of question ID → QuizAnswer
- `poll_vote`: JSON object of user's PollVote
- `poll_results`: JSON map of option index → vote count

**Persistence Strategy:**
- Save immediately after user action (optimistic UI)
- Load on provider initialization
- Handle serialization errors gracefully
- Provide default values for missing data

## UI/UX Design Considerations

### Visual Design

**Color Scheme:**
- Success: Green (#4CAF50) for correct answers
- Error: Red (#F44336) for incorrect answers
- Primary: Blue (#1565C0) matching existing app theme
- Accent: Purple (#7B1FA2) for highlights
- Background: Light gray (#F5F5F5) for consistency

**Typography:**
- Question text: 18sp, bold
- Option text: 16sp, regular
- Feedback text: 14sp, medium
- Result percentages: 16sp, bold

### Interaction Design

**Quiz Interactions:**
1. User taps an option → Option highlights
2. System validates → Immediate feedback appears
3. Correct: Green checkmark + success message
4. Incorrect: Red X + correct answer shown
5. All options become disabled
6. User can scroll to next question

**Poll Interactions:**
1. User taps a sport option → Option highlights
2. System records vote → Results appear with animation
3. Progress bars animate to show distribution
4. User's choice is highlighted with accent color
5. Selection is locked (no re-voting)

### Responsive Behavior

**Loading States:**
- Show shimmer placeholders while loading questions
- Display loading indicator during vote submission
- Graceful error messages if data fails to load

**Empty States:**
- "No questions available" with retry button
- "Poll not found" with navigation back

**Performance Targets:**
- Answer feedback: < 100ms
- Poll result update: < 200ms
- Page navigation: < 300ms
- Smooth 60fps animations

### Accessibility

- Semantic labels for all interactive elements
- Sufficient color contrast (WCAG AA)
- Touch targets minimum 48x48dp
- Screen reader support for feedback messages
- Keyboard navigation support (web/desktop)

## Integration with Existing App

### Navigation Integration

Add new tab to bottom navigation bar:

```dart
// In main_screen.dart
final List<Widget> _pages = [
  HomePage(),
  const ExplorePage(),
  const QuizPollPage(), // NEW
  const SettingsPage(),
];

// Bottom navigation items
BottomNavigationBarItem(
  icon: Icon(Icons.quiz_outlined),
  activeIcon: Icon(Icons.quiz),
  label: 'Quiz & Poll',
),
```

### Alternative: Nested Navigation

If bottom nav is full, use nested navigation from ExplorePage:

```dart
// In explore_page.dart
Card(
  child: ListTile(
    leading: Icon(Icons.quiz),
    title: Text('Quiz & Polling'),
    subtitle: Text('Test your knowledge'),
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => QuizPollPage()),
    ),
  ),
)
```

### Shared Resources

**Reuse existing patterns:**
- Gradient backgrounds (similar to profile cards)
- Card-based layouts (consistent with home page)
- Navigation transitions (MaterialPageRoute)
- Color scheme (primary blue, accent purple)

**New dependencies to add:**
```yaml
dependencies:
  provider: ^6.1.1
  shared_preferences: ^2.2.2
```

### File Structure

```
lib/
├── main.dart (updated with providers)
├── pages/
│   ├── main_screen.dart (updated navigation)
│   ├── quiz_poll/
│   │   ├── quiz_poll_page.dart (main entry)
│   │   ├── quiz_page.dart
│   │   ├── poll_page.dart
│   │   └── widgets/
│   │       ├── quiz_question_card.dart
│   │       ├── feedback_widget.dart
│   │       ├── poll_option_card.dart
│   │       └── poll_result_widget.dart
├── providers/
│   ├── quiz_provider.dart
│   └── poll_provider.dart
├── repositories/
│   ├── quiz_repository.dart
│   └── poll_repository.dart
└── models/
    ├── quiz_question.dart
    ├── quiz_answer.dart
    ├── poll.dart
    ├── poll_vote.dart
    └── poll_result.dart
```


## Correctness Properties

*A property is a characteristic or behavior that should hold true across all valid executions of a system—essentially, a formal statement about what the system should do. Properties serve as the bridge between human-readable specifications and machine-verifiable correctness guarantees.*

While this feature is primarily UI-focused, there are core business logic components that benefit from property-based testing: vote percentage calculation and data serialization for persistence.

### Property 1: Vote Percentage Calculation Correctness

*For any* valid vote distribution map where total votes > 0, the calculated percentage for each option SHALL equal (option_count / total_votes) * 100, and all percentages SHALL sum to 100% (within floating-point precision tolerance).

**Validates: Requirements 4.4, 5.2**

**Rationale:** Percentage calculation is critical for displaying accurate poll results. Testing across various vote distributions (including edge cases like single vote, equal distribution, skewed distribution) ensures correctness.

### Property 2: Quiz Answer Serialization Round-Trip

*For any* valid QuizAnswer object, serializing to JSON and then deserializing SHALL produce an equivalent QuizAnswer object with the same questionId, selectedOptions, isCorrect flag, and submittedAt timestamp.

**Validates: Requirements 7.1**

**Rationale:** Data persistence relies on correct serialization. Round-trip testing ensures no data loss or corruption when saving and loading quiz answers from SharedPreferences.

### Property 3: Poll Vote Serialization Round-Trip

*For any* valid PollVote object, serializing to JSON and then deserializing SHALL produce an equivalent PollVote object with the same pollId, selectedOption, and votedAt timestamp.

**Validates: Requirements 7.2**

**Rationale:** Poll votes must persist correctly across app sessions. Round-trip testing ensures vote data integrity.

### Property 4: Answer Validation Correctness

*For any* QuizQuestion with defined correct answers, validating a user's selected options SHALL return true if and only if the selected options exactly match the correct answer indices (order-independent for multiple choice).

**Validates: Requirements 1.2, 2.2**

**Rationale:** Answer validation is the core business logic of the quiz system. Testing across various question types and answer combinations ensures correct feedback is always provided.

### Testing Strategy Notes

**Property-Based Testing:**
- Use a Dart PBT library such as `test_api` with custom generators or `faker` for data generation
- Minimum 100 iterations per property test
- Each test must reference its design property in a comment tag
- Tag format: `// Feature: questionnaire-and-polling, Property {number}: {property_text}`

**Example-Based Testing:**
- UI widget tests for rendering and interaction
- Integration tests for navigation and state restoration
- Performance tests for responsiveness requirements (100ms, 200ms targets)
- Stress tests for rapid user interactions

**Test Coverage Strategy:**
- Property tests: Core business logic (validation, calculation, serialization)
- Unit tests: Individual components and widgets
- Widget tests: UI interactions and state management
- Integration tests: End-to-end user flows and persistence


## Error Handling

### Error Categories and Strategies

#### 1. Data Loading Errors

**Scenario:** SharedPreferences fails to load or returns corrupted data

**Handling:**
```dart
try {
  final answers = await _repository.getAllAnswers();
  _userAnswers = answers;
} catch (e) {
  // Log error for debugging
  debugPrint('Failed to load quiz answers: $e');
  // Provide default empty state
  _userAnswers = {};
  // Show user-friendly message
  _errorMessage = 'Could not load previous answers. Starting fresh.';
}
```

**User Experience:**
- Display non-blocking snackbar with error message
- Allow user to continue with empty state
- Provide retry button if appropriate

#### 2. Data Persistence Errors

**Scenario:** SharedPreferences fails to save user data

**Handling:**
```dart
try {
  await _repository.saveAnswer(questionId, answer);
} catch (e) {
  debugPrint('Failed to save answer: $e');
  // Keep in-memory state but warn user
  _showPersistenceWarning = true;
  // Attempt retry on next interaction
  _pendingSaves.add(() => _repository.saveAnswer(questionId, answer));
}
```

**User Experience:**
- Show warning icon indicating data may not be saved
- Display message: "Having trouble saving your progress"
- Attempt automatic retry in background
- Maintain in-memory state so user can continue

#### 3. Validation Errors

**Scenario:** Invalid data structure or corrupted question data

**Handling:**
```dart
bool validateQuestion(QuizQuestion question) {
  if (question.options.length != 5) {
    debugPrint('Invalid question: must have 5 options');
    return false;
  }
  if (question.correctAnswers.isEmpty) {
    debugPrint('Invalid question: must have correct answers');
    return false;
  }
  if (question.type == QuestionType.single && 
      question.correctAnswers.length != 1) {
    debugPrint('Invalid single choice: must have exactly 1 correct answer');
    return false;
  }
  return true;
}
```

**User Experience:**
- Skip invalid questions silently
- Log errors for developer debugging
- Show "Some questions unavailable" if many are invalid

#### 4. State Inconsistency Errors

**Scenario:** User attempts to answer already-answered question

**Handling:**
```dart
Future<void> submitAnswer(String questionId, List<int> selectedOptions) async {
  if (isQuestionAnswered(questionId)) {
    // Silently ignore - UI should prevent this
    debugPrint('Attempted to re-answer question: $questionId');
    return;
  }
  // Proceed with submission
}
```

**User Experience:**
- UI prevents interaction (disabled state)
- No error message needed (expected behavior)

#### 5. Network Errors (Future Extension)

**Scenario:** Remote question/poll loading fails (if implemented)

**Handling:**
```dart
try {
  final questions = await _api.fetchQuestions();
  return questions;
} catch (e) {
  debugPrint('Network error: $e');
  // Fall back to cached/local questions
  return _getCachedQuestions();
}
```

**User Experience:**
- Show "Using offline content" message
- Provide refresh button to retry
- Graceful degradation to local data

### Error Recovery Strategies

**Automatic Recovery:**
- Retry failed persistence operations on next user interaction
- Fall back to default/empty state for corrupted data
- Use cached data when remote loading fails

**User-Initiated Recovery:**
- "Retry" button for loading failures
- "Clear data" option in settings for corrupted state
- "Refresh" action to reload questions/polls

**Error Logging:**
- Use `debugPrint` for development debugging
- Consider adding crash reporting (e.g., Sentry) for production
- Log error context (operation, data involved, timestamp)

### Validation Rules

**Input Validation:**
- Question ID must be non-empty string
- Selected options must be valid indices (0-4)
- Timestamps must be valid DateTime objects
- Vote counts must be non-negative integers

**State Validation:**
- Verify question exists before allowing answer
- Ensure user hasn't already voted before recording vote
- Validate serialized data structure before deserialization

**Business Rule Validation:**
- Single choice: exactly 1 option selected
- Multiple choice: exactly 1 option selected (per requirements)
- Poll: exactly 1 sport selected
- No answer changes after submission

## Testing Strategy

### Testing Approach Overview

This feature requires a multi-layered testing approach:

1. **Property-Based Tests**: Core business logic (4 properties)
2. **Unit Tests**: Individual components and functions
3. **Widget Tests**: UI components and interactions
4. **Integration Tests**: End-to-end user flows
5. **Performance Tests**: Responsiveness requirements

### Property-Based Testing

**Library:** Use Dart's built-in test framework with custom generators, or consider `faker` package for data generation.

**Test Configuration:**
- Minimum 100 iterations per property test
- Use seed for reproducibility during debugging
- Tag each test with property reference

**Property Test Examples:**

```dart
// Feature: questionnaire-and-polling, Property 1: Vote Percentage Calculation Correctness
test('vote percentages sum to 100% for any distribution', () {
  final generator = VoteDistributionGenerator();
  
  for (int i = 0; i < 100; i++) {
    final distribution = generator.generate();
    final result = PollResult(
      voteCounts: distribution,
      totalVotes: distribution.values.reduce((a, b) => a + b),
    );
    
    double sum = 0.0;
    for (int option = 0; option < 5; option++) {
      sum += result.getPercentage(option);
    }
    
    expect(sum, closeTo(100.0, 0.01)); // Within floating-point tolerance
  }
});

// Feature: questionnaire-and-polling, Property 2: Quiz Answer Serialization Round-Trip
test('quiz answer serialization round-trip preserves data', () {
  final generator = QuizAnswerGenerator();
  
  for (int i = 0; i < 100; i++) {
    final original = generator.generate();
    final json = original.toJson();
    final deserialized = QuizAnswer.fromJson(json);
    
    expect(deserialized.questionId, equals(original.questionId));
    expect(deserialized.selectedOptions, equals(original.selectedOptions));
    expect(deserialized.isCorrect, equals(original.isCorrect));
    expect(deserialized.submittedAt, equals(original.submittedAt));
  }
});
```

**Custom Generators:**

```dart
class VoteDistributionGenerator {
  final Random _random = Random();
  
  Map<int, int> generate() {
    final distribution = <int, int>{};
    final totalVotes = _random.nextInt(1000) + 1; // 1-1000 votes
    
    // Distribute votes randomly across 5 options
    int remaining = totalVotes;
    for (int i = 0; i < 4; i++) {
      final votes = _random.nextInt(remaining + 1);
      distribution[i] = votes;
      remaining -= votes;
    }
    distribution[4] = remaining; // Last option gets remaining votes
    
    return distribution;
  }
}

class QuizAnswerGenerator {
  final Random _random = Random();
  
  QuizAnswer generate() {
    final questionId = 'q_${_random.nextInt(100)}';
    final selectedOptions = [_random.nextInt(5)];
    final isCorrect = _random.nextBool();
    final submittedAt = DateTime.now().subtract(
      Duration(hours: _random.nextInt(24)),
    );
    
    return QuizAnswer(
      questionId: questionId,
      selectedOptions: selectedOptions,
      isCorrect: isCorrect,
      submittedAt: submittedAt,
    );
  }
}
```

### Unit Testing

**Coverage Areas:**
- Model validation methods
- Repository CRUD operations
- Provider state management logic
- Percentage calculation functions
- Answer validation logic

**Example Unit Tests:**

```dart
group('QuizQuestion validation', () {
  test('valid question with 5 options passes', () {
    final question = QuizQuestion(
      id: 'q1',
      questionText: 'Test?',
      type: QuestionType.single,
      options: ['A', 'B', 'C', 'D', 'E'],
      correctAnswers: [0],
    );
    expect(question.isValid(), isTrue);
  });
  
  test('question with 4 options fails', () {
    final question = QuizQuestion(
      id: 'q1',
      questionText: 'Test?',
      type: QuestionType.single,
      options: ['A', 'B', 'C', 'D'],
      correctAnswers: [0],
    );
    expect(question.isValid(), isFalse);
  });
});

group('PollResult calculations', () {
  test('getPercentage returns correct value', () {
    final result = PollResult(
      voteCounts: {0: 25, 1: 25, 2: 25, 3: 25, 4: 0},
      totalVotes: 100,
    );
    expect(result.getPercentage(0), equals(25.0));
    expect(result.getPercentage(4), equals(0.0));
  });
  
  test('getPercentage handles zero total votes', () {
    final result = PollResult(
      voteCounts: {},
      totalVotes: 0,
    );
    expect(result.getPercentage(0), equals(0.0));
  });
});
```

### Widget Testing

**Coverage Areas:**
- Quiz question card rendering
- Answer selection interaction
- Feedback widget display
- Poll option selection
- Result visualization
- Loading and error states

**Example Widget Tests:**

```dart
testWidgets('quiz question displays 5 options', (tester) async {
  final question = QuizQuestion(
    id: 'q1',
    questionText: 'What is 2+2?',
    type: QuestionType.single,
    options: ['2', '3', '4', '5', '6'],
    correctAnswers: [2],
  );
  
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: QuizQuestionCard(question: question),
      ),
    ),
  );
  
  expect(find.text('What is 2+2?'), findsOneWidget);
  expect(find.byType(RadioListTile), findsNWidgets(5));
});

testWidgets('selecting answer shows feedback', (tester) async {
  // Setup provider and widget
  final provider = QuizProvider();
  
  await tester.pumpWidget(
    ChangeNotifierProvider.value(
      value: provider,
      child: MaterialApp(home: QuizPage()),
    ),
  );
  
  // Tap an answer option
  await tester.tap(find.byType(RadioListTile).first);
  await tester.pumpAndSettle();
  
  // Verify feedback appears
  expect(find.byType(FeedbackWidget), findsOneWidget);
});
```

### Integration Testing

**Coverage Areas:**
- Navigation from main app to quiz/poll
- Complete quiz flow (answer multiple questions)
- Complete poll flow (vote and see results)
- Data persistence across app restarts
- Back navigation

**Example Integration Tests:**

```dart
testWidgets('complete quiz flow', (tester) async {
  await tester.pumpWidget(MyApp());
  
  // Navigate to quiz
  await tester.tap(find.text('Quiz & Poll'));
  await tester.pumpAndSettle();
  
  // Answer first question
  await tester.tap(find.byType(RadioListTile).first);
  await tester.pumpAndSettle();
  
  // Verify feedback
  expect(find.byType(FeedbackWidget), findsOneWidget);
  
  // Scroll to next question
  await tester.drag(find.byType(ListView), const Offset(0, -300));
  await tester.pumpAndSettle();
  
  // Answer second question
  await tester.tap(find.byType(RadioListTile).at(1));
  await tester.pumpAndSettle();
  
  // Verify both answers are saved
  final provider = Provider.of<QuizProvider>(
    tester.element(find.byType(QuizPage)),
    listen: false,
  );
  expect(provider.getAllAnswers().length, equals(2));
});
```

### Performance Testing

**Requirements:**
- Answer feedback: < 100ms
- Poll result update: < 200ms
- Page navigation: < 300ms

**Example Performance Tests:**

```dart
testWidgets('answer feedback appears within 100ms', (tester) async {
  await tester.pumpWidget(MyApp());
  
  final stopwatch = Stopwatch()..start();
  
  // Tap answer
  await tester.tap(find.byType(RadioListTile).first);
  await tester.pump(); // Single frame
  
  stopwatch.stop();
  
  // Verify feedback exists
  expect(find.byType(FeedbackWidget), findsOneWidget);
  
  // Verify timing
  expect(stopwatch.elapsedMilliseconds, lessThan(100));
});
```

### Test Organization

```
test/
├── unit/
│   ├── models/
│   │   ├── quiz_question_test.dart
│   │   ├── quiz_answer_test.dart
│   │   ├── poll_test.dart
│   │   └── poll_result_test.dart
│   ├── providers/
│   │   ├── quiz_provider_test.dart
│   │   └── poll_provider_test.dart
│   └── repositories/
│       ├── quiz_repository_test.dart
│       └── poll_repository_test.dart
├── widget/
│   ├── quiz_question_card_test.dart
│   ├── feedback_widget_test.dart
│   ├── poll_option_card_test.dart
│   └── poll_result_widget_test.dart
├── integration/
│   ├── quiz_flow_test.dart
│   ├── poll_flow_test.dart
│   └── persistence_test.dart
├── property/
│   ├── vote_calculation_property_test.dart
│   ├── quiz_serialization_property_test.dart
│   ├── poll_serialization_property_test.dart
│   └── answer_validation_property_test.dart
└── performance/
    ├── feedback_timing_test.dart
    └── poll_update_timing_test.dart
```

### Test Execution Strategy

**Development:**
- Run unit tests on every file save (watch mode)
- Run widget tests before committing
- Run property tests before pull request

**CI/CD:**
- Run all tests on pull request
- Require 80%+ code coverage
- Run performance tests on main branch
- Generate coverage reports

**Test Commands:**
```bash
# Run all tests
flutter test

# Run specific test suite
flutter test test/unit/
flutter test test/property/

# Run with coverage
flutter test --coverage

# Run performance tests
flutter test test/performance/ --reporter expanded
```

### Mocking Strategy

**Mock SharedPreferences:**
```dart
class MockSharedPreferences extends Mock implements SharedPreferences {}

test('repository saves answer', () async {
  final mockPrefs = MockSharedPreferences();
  final repository = QuizRepository(mockPrefs);
  
  when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
  
  await repository.saveAnswer('q1', answer);
  
  verify(mockPrefs.setString('quiz_answers', any)).called(1);
});
```

**Mock Providers:**
```dart
class MockQuizProvider extends Mock implements QuizProvider {}

testWidgets('quiz page displays questions', (tester) async {
  final mockProvider = MockQuizProvider();
  when(mockProvider.questions).thenReturn([question1, question2]);
  
  await tester.pumpWidget(
    ChangeNotifierProvider<QuizProvider>.value(
      value: mockProvider,
      child: MaterialApp(home: QuizPage()),
    ),
  );
  
  expect(find.byType(QuizQuestionCard), findsNWidgets(2));
});
```

### Coverage Goals

- **Overall**: 80%+ code coverage
- **Business Logic**: 95%+ (providers, repositories, validation)
- **Models**: 90%+ (serialization, validation)
- **UI Widgets**: 70%+ (focus on interaction logic)
- **Property Tests**: 100% of identified properties

## Summary

This design provides a comprehensive blueprint for implementing the Questionnaire and Polling feature:

- **Architecture**: Clean separation between presentation, business logic, and data layers
- **State Management**: Provider pattern for reactive UI updates
- **Data Models**: Well-defined models with validation and serialization
- **UI/UX**: Responsive, accessible interface matching existing app design
- **Integration**: Seamless addition to existing navigation structure
- **Error Handling**: Robust error recovery and user-friendly messaging
- **Testing**: Multi-layered strategy with property-based testing for core logic

The design prioritizes maintainability, testability, and user experience while integrating naturally with the existing Flutter profile application.
