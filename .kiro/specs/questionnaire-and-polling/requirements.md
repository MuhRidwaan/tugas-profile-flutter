# Requirements Document

## Introduction

Fitur Kuesioner dan Polling adalah fitur baru dalam aplikasi Flutter profile yang memungkinkan pengguna untuk menjawab kuesioner dengan dua tipe pertanyaan (single choice dan multiple choice) serta berpartisipasi dalam polling hobi olahraga. Fitur ini memberikan feedback langsung kepada pengguna tentang jawaban mereka dan menampilkan hasil polling secara real-time.

## Glossary

- **Quiz_System**: Sistem yang mengelola kuesioner dengan pertanyaan single choice dan multiple choice
- **Single_Choice_Question**: Pertanyaan dengan 5 pilihan jawaban dimana hanya 1 jawaban yang benar
- **Multiple_Choice_Question**: Pertanyaan dengan 5 pilihan jawaban dimana lebih dari 1 jawaban yang benar
- **Polling_System**: Sistem yang mengelola polling hobi olahraga
- **User**: Pengguna aplikasi Flutter profile
- **Feedback_Display**: Komponen UI yang menampilkan hasil benar/salah dari jawaban
- **Poll_Result**: Hasil polling yang menampilkan distribusi pilihan dari semua pengguna
- **Answer_Selection**: Proses pemilihan jawaban oleh pengguna
- **Correct_Answer**: Jawaban yang benar untuk pertanyaan kuesioner

## Requirements

### Requirement 1: Single Choice Quiz Management

**User Story:** As a user, I want to answer single choice quiz questions with immediate feedback, so that I can learn from my answers instantly.

#### Acceptance Criteria

1. THE Quiz_System SHALL display Single_Choice_Question with exactly 5 answer options
2. WHEN User selects an answer option, THE Quiz_System SHALL immediately display Feedback_Display indicating correct or incorrect
3. IF User selects incorrect answer, THEN THE Feedback_Display SHALL show the Correct_Answer
4. THE Quiz_System SHALL allow User to select only one answer option per Single_Choice_Question
5. WHEN User selects an answer option, THE Quiz_System SHALL disable further answer selection for that Single_Choice_Question

### Requirement 2: Multiple Choice Quiz Management

**User Story:** As a user, I want to answer multiple choice quiz questions with immediate feedback, so that I can understand all correct answers.

#### Acceptance Criteria

1. THE Quiz_System SHALL display Multiple_Choice_Question with exactly 5 answer options
2. WHEN User selects an answer option, THE Quiz_System SHALL immediately display Feedback_Display indicating correct or incorrect
3. IF User selects incorrect answer, THEN THE Feedback_Display SHALL show all Correct_Answer options
4. THE Quiz_System SHALL allow User to select one answer option per Multiple_Choice_Question
5. WHEN User selects an answer option, THE Quiz_System SHALL disable further answer selection for that Multiple_Choice_Question

### Requirement 3: Quiz Feedback Display

**User Story:** As a user, I want to see clear visual feedback on my quiz answers, so that I can easily understand my performance.

#### Acceptance Criteria

1. WHEN User selects correct answer, THE Feedback_Display SHALL show success indicator with green color
2. WHEN User selects incorrect answer, THE Feedback_Display SHALL show error indicator with red color
3. THE Feedback_Display SHALL display the selected answer option
4. IF answer is incorrect, THEN THE Feedback_Display SHALL display all Correct_Answer options with distinct visual styling
5. THE Feedback_Display SHALL remain visible after answer selection until User navigates away

### Requirement 4: Sports Hobby Polling

**User Story:** As a user, I want to vote for my favorite sports hobby and see the results, so that I can see what others prefer.

#### Acceptance Criteria

1. THE Polling_System SHALL display exactly 5 sports options: Badminton, Catur, Padel, Basket, and Lari Marathon
2. WHEN User selects a sports option, THE Polling_System SHALL record the vote
3. WHEN User selects a sports option, THE Polling_System SHALL display Poll_Result showing vote distribution
4. THE Poll_Result SHALL show the percentage or count for each sports option
5. THE Polling_System SHALL allow User to select only one sports option

### Requirement 5: Poll Result Visualization

**User Story:** As a user, I want to see poll results in an easy-to-understand format, so that I can quickly compare preferences.

#### Acceptance Criteria

1. THE Poll_Result SHALL display vote count for each sports option
2. THE Poll_Result SHALL display percentage for each sports option
3. THE Poll_Result SHALL update immediately after User votes
4. THE Poll_Result SHALL use visual indicators such as progress bars or charts
5. THE Poll_Result SHALL highlight the User's selected option with distinct visual styling

### Requirement 6: Navigation and Integration

**User Story:** As a user, I want to easily access the questionnaire and polling features from the main app, so that I can use them conveniently.

#### Acceptance Criteria

1. THE Quiz_System SHALL be accessible from the main navigation menu
2. THE Polling_System SHALL be accessible from the main navigation menu
3. WHEN User navigates to Quiz_System, THE Quiz_System SHALL display all available questions
4. WHEN User navigates to Polling_System, THE Polling_System SHALL display the sports polling interface
5. THE Quiz_System SHALL allow User to navigate back to the main app

### Requirement 7: Data Persistence

**User Story:** As a user, I want my quiz answers and poll votes to be saved, so that I don't lose my progress.

#### Acceptance Criteria

1. WHEN User selects an answer in Quiz_System, THE Quiz_System SHALL persist the answer state locally
2. WHEN User votes in Polling_System, THE Polling_System SHALL persist the vote locally
3. WHEN User reopens Quiz_System, THE Quiz_System SHALL display previously answered questions with their results
4. WHEN User reopens Polling_System, THE Polling_System SHALL display the previous vote and current Poll_Result
5. THE Quiz_System SHALL prevent User from changing answers after submission

### Requirement 8: User Interface Responsiveness

**User Story:** As a user, I want the quiz and polling interfaces to be responsive and smooth, so that I have a good user experience.

#### Acceptance Criteria

1. WHEN User selects an answer option, THE Quiz_System SHALL provide visual feedback within 100 milliseconds
2. WHEN User votes in polling, THE Polling_System SHALL update Poll_Result within 200 milliseconds
3. THE Quiz_System SHALL display loading indicators while processing answer validation
4. THE Polling_System SHALL display loading indicators while updating Poll_Result
5. THE Quiz_System SHALL handle rapid user interactions without errors or crashes
