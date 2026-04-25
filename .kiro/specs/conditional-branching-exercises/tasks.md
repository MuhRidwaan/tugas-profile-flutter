# Implementation Plan: Conditional Branching Exercises

## Overview

This implementation plan breaks down the Conditional Branching Exercises feature into discrete, incremental coding tasks. The feature consists of three interactive exercises demonstrating IF statements, Nested IF, and Switch-Case constructs through practical calculation scenarios. Each task builds upon previous work, with property-based tests integrated throughout to validate correctness properties defined in the design document.

## Tasks

- [x] 1. Set up project structure and shared components
  - Create directory structure: `lib/pages/conditional_branching/` and `lib/pages/conditional_branching/widgets/`
  - Define data models: `ExerciseConfig`, `DiscountTier` enum with extension, and `ValidationResult` class
  - Implement utility functions: `formatCurrency()`, `formatPercentage()`, and `validateNumericInput()`
  - Create string constants class `ConditionalBranchingStrings` for all user-facing text
  - _Requirements: 4.4, 4.5, 5.1, 5.2, 5.3, 5.4, 6.8_

- [ ]* 1.1 Write unit tests for utility functions
  - Test currency formatting with various amounts (positive, negative, zero, large numbers)
  - Test percentage formatting for all discount rates (0%, 10%, 20%, 30%)
  - Test input validation for empty, non-numeric, negative, and valid inputs
  - Test thousand separator insertion and rounding behavior
  - _Requirements: 4.4, 4.5, 5.1, 5.2, 6.8_

- [x] 2. Create reusable widget components
  - [x] 2.1 Implement ExerciseCard widget
    - Create stateless widget with properties: title, description, icon, color, onTap
    - Design card UI with gradient background, icon, title, description, and arrow indicator
    - Add tap gesture handling for navigation
    - _Requirements: 4.1, 4.2_

  - [x] 2.2 Implement CalculatorInputField widget
    - Create stateful widget with properties: controller, label, hint, errorText, keyboardType, onChanged
    - Implement automatic error state styling with red border and error message display
    - Add consistent border radius, padding, and icon prefix support
    - _Requirements: 5.6_

  - [x] 2.3 Implement ResultDisplayCard widget
    - Create stateless widget for max/min calculator results
    - Display max and min values or equality message based on isEqual flag
    - Style with white card background, shadow, and proper spacing
    - _Requirements: 1.6, 1.7, 4.6_

  - [x] 2.4 Implement DiscountResultCard widget
    - Create stateless widget for discount calculation results
    - Display original amount, discount rate, discount amount, and final payment
    - Format currency values with Rupiah prefix and percentage values with % suffix
    - Style with white card background, shadow, and clear visual hierarchy
    - _Requirements: 2.8, 2.9, 2.10, 2.11, 3.9, 3.10, 3.11, 3.12, 4.4, 4.5, 4.6_

- [ ]* 2.5 Write widget tests for reusable components
  - Test ExerciseCard tap behavior and rendering
  - Test CalculatorInputField validation display and error state styling
  - Test ResultDisplayCard rendering with different states (max/min vs equal)
  - Test DiscountResultCard rendering with formatted values
  - _Requirements: 4.1, 4.2, 4.6, 5.6_

- [x] 3. Implement Max-Min Calculator (IF Statement Exercise)
  - [x] 3.1 Create MaxMinCalculatorPage stateful widget
    - Set up state variables: `_number1Controller`, `_number2Controller`, `_maxValue`, `_minValue`, `_isEqual`, `_isCalculated`, `_errorMessage`
    - Implement `dispose()` method to clean up controllers
    - Build UI with AppBar, two input fields, calculate button, reset button, and result display area
    - _Requirements: 1.1, 4.3, 4.7, 4.8_

  - [x] 3.2 Implement validation and calculation logic
    - Implement `_validateInputs()` method to check for empty and non-numeric inputs
    - Implement `_calculate()` method using IF statements to compare numbers and determine max/min
    - Handle three cases: num1 > num2, num2 > num1, and num1 == num2
    - Implement `_reset()` method to clear all inputs and results
    - Implement `_showError()` method to display validation errors
    - _Requirements: 1.2, 1.3, 1.4, 1.5, 1.8, 5.1, 5.2, 5.3, 5.5, 5.7_

  - [x] 3.3 Integrate ResultDisplayCard and wire up UI interactions
    - Connect calculate button to `_calculate()` method with validation
    - Connect reset button to `_reset()` method
    - Display ResultDisplayCard when `_isCalculated` is true
    - Display error messages when validation fails
    - _Requirements: 1.6, 1.7, 4.6, 5.6, 5.7_

- [ ]* 3.4 Write property test for Max-Min Comparison Correctness
  - **Property 1: Max-Min Comparison Correctness**
  - **Validates: Requirements 1.2, 1.3, 1.4**
  - Generate 100 random pairs of numbers (including positive, negative, decimals)
  - Verify max >= min for all pairs
  - Verify both max and min are present in original input set
  - _Requirements: 1.2, 1.3, 1.4, 6.1_

- [ ]* 3.5 Write property test for Max-Min Equality Handling
  - **Property 2: Max-Min Equality Handling**
  - **Validates: Requirements 1.5**
  - Generate 100 random numbers and compare each with itself
  - Verify isEqual flag is true when num1 == num2
  - Verify max and min are null when numbers are equal
  - _Requirements: 1.5_

- [ ]* 3.6 Write unit tests for Max-Min Calculator
  - Test calculation with num1 > num2
  - Test calculation with num2 > num1
  - Test calculation with num1 == num2
  - Test validation with empty inputs
  - Test validation with non-numeric inputs
  - Test acceptance of negative values
  - Test reset functionality
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 1.8, 5.1, 5.2, 5.3, 6.1_

- [ ] 4. Checkpoint - Verify Max-Min Calculator
  - Ensure all tests pass, ask the user if questions arise.

- [x] 5. Implement Nested IF Discount Calculator
  - [x] 5.1 Create NestedIfDiscountPage stateful widget
    - Set up state variables: `_purchaseAmountController`, `_originalAmount`, `_discountRate`, `_discountAmount`, `_finalPayment`, `_isCalculated`, `_errorMessage`
    - Implement `dispose()` method to clean up controller
    - Build UI with AppBar, purchase amount input field, calculate button, reset button, and result display area
    - _Requirements: 2.1, 4.3, 4.7, 4.8_

  - [x] 5.2 Implement validation and nested IF calculation logic
    - Implement `_validateInput()` method to check for empty, non-numeric, negative, and zero inputs
    - Implement `_calculateDiscount()` method using nested IF statements for tier determination
    - Apply discount rates: >= 1500000 → 30%, >= 1000000 → 20%, >= 500000 → 10%, < 500000 → 0%
    - Calculate discount amount and final payment
    - Implement `_reset()` method to clear all inputs and results
    - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 2.7, 2.12, 5.1, 5.2, 5.4, 5.5, 5.7, 6.2, 6.4, 6.5_

  - [x] 5.3 Integrate DiscountResultCard and wire up UI interactions
    - Connect calculate button to `_calculateDiscount()` method with validation
    - Connect reset button to `_reset()` method
    - Display DiscountResultCard when `_isCalculated` is true with all four values
    - Display error messages when validation fails
    - _Requirements: 2.8, 2.9, 2.10, 2.11, 4.6, 5.6, 5.7_

- [ ]* 5.4 Write property test for Discount Tier Boundary Consistency
  - **Property 3: Discount Tier Boundary Consistency**
  - **Validates: Requirements 2.2, 2.3, 2.4, 6.4**
  - Test boundary values: 500000, 1000000, 1500000
  - Verify higher tier discount is applied at exact boundary values
  - Compare nested IF results with boundary-1 to confirm tier transition
  - _Requirements: 2.2, 2.3, 2.4, 6.4_

- [ ]* 5.5 Write property test for Discount Calculation Accuracy
  - **Property 4: Discount Calculation Accuracy**
  - **Validates: Requirements 2.6, 2.7**
  - Generate 100 random positive purchase amounts
  - Verify discount amount = purchase amount × discount rate (within 0.01 tolerance)
  - Verify final payment = purchase amount - discount amount (within 0.01 tolerance)
  - _Requirements: 2.6, 2.7, 6.2, 6.5_

- [ ]* 5.6 Write unit tests for Nested IF Discount Calculator
  - Test calculation for each tier: < 500k, 500k-999k, 1M-1.49M, >= 1.5M
  - Test exact boundary values: 500000, 1000000, 1500000
  - Test validation with empty input
  - Test validation with non-numeric input
  - Test validation with negative and zero values
  - Test reset functionality
  - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 2.7, 2.12, 5.1, 5.2, 5.4, 6.2, 6.4, 6.5_

- [x] 6. Implement Switch-Case Discount Calculator
  - [x] 6.1 Create SwitchCaseDiscountPage stateful widget
    - Set up state variables: identical to NestedIfDiscountPage
    - Implement `dispose()` method to clean up controller
    - Build UI with AppBar, purchase amount input field, calculate button, reset button, and result display area
    - _Requirements: 3.1, 4.3, 4.7, 4.8_

  - [x] 6.2 Implement tier helper and switch-case calculation logic
    - Implement `_getTier()` helper method to categorize purchase amount into tiers 1-4
    - Implement `_validateInput()` method (identical to nested IF version)
    - Implement `_calculateDiscount()` method using switch-case on tier value
    - Apply discount rates using switch cases: tier 4 → 30%, tier 3 → 20%, tier 2 → 10%, tier 1/default → 0%
    - Calculate discount amount and final payment
    - Implement `_reset()` method to clear all inputs and results
    - _Requirements: 3.1, 3.2, 3.3, 3.4, 3.5, 3.6, 3.7, 3.8, 3.13, 5.1, 5.2, 5.4, 5.5, 5.7, 6.3, 6.4, 6.6_

  - [x] 6.3 Integrate DiscountResultCard and wire up UI interactions
    - Connect calculate button to `_calculateDiscount()` method with validation
    - Connect reset button to `_reset()` method
    - Display DiscountResultCard when `_isCalculated` is true with all four values
    - Display error messages when validation fails
    - _Requirements: 3.9, 3.10, 3.11, 3.12, 4.6, 5.6, 5.7_

- [ ]* 6.4 Write property test for Nested IF and Switch-Case Equivalence
  - **Property 5: Nested IF and Switch-Case Equivalence**
  - **Validates: Requirements 3.14, 6.7**
  - Generate 100 random positive purchase amounts
  - Calculate discount using both nested IF and switch-case methods
  - Verify identical discount rates, discount amounts, and final payments
  - _Requirements: 3.14, 6.7_

- [ ]* 6.5 Write unit tests for Switch-Case Discount Calculator
  - Test calculation for each tier: < 500k, 500k-999k, 1M-1.49M, >= 1.5M
  - Test exact boundary values: 500000, 1000000, 1500000
  - Test validation with empty input
  - Test validation with non-numeric input
  - Test validation with negative and zero values
  - Test reset functionality
  - Test equivalence with nested IF for same inputs
  - _Requirements: 3.1, 3.2, 3.3, 3.4, 3.5, 3.6, 3.7, 3.8, 3.13, 3.14, 5.1, 5.2, 5.4, 6.3, 6.4, 6.6, 6.7_

- [ ] 7. Checkpoint - Verify Discount Calculators
  - Ensure all tests pass, ask the user if questions arise.

- [x] 8. Implement main selection page and navigation
  - [x] 8.1 Create ConditionalBranchingPage stateless widget
    - Define list of ExerciseConfig objects for all three exercises
    - Build UI with AppBar and ListView of ExerciseCard widgets
    - Configure each card with appropriate title, description, icon, color, and target page
    - _Requirements: 4.1, 4.2_

  - [x] 8.2 Implement navigation logic
    - Add onTap handlers to each ExerciseCard to navigate to respective calculator pages
    - Use `Navigator.push()` with MaterialPageRoute for navigation
    - Ensure back navigation works correctly from all calculator pages
    - _Requirements: 4.3, 4.7_

  - [x] 8.3 Integrate ConditionalBranchingPage into ExplorePage
    - Add navigation option in ExplorePage to access ConditionalBranchingPage
    - Create appropriate card or button in ExplorePage with "Latihan Percabangan" title
    - Test navigation flow: ExplorePage → ConditionalBranchingPage → Exercise Pages
    - _Requirements: 4.1, 4.3, 4.7_

- [ ]* 8.4 Write integration tests for navigation flow
  - Test navigation from ExplorePage to ConditionalBranchingPage
  - Test navigation from ConditionalBranchingPage to each exercise
  - Test back navigation from exercises to selection page
  - Test app bar back button functionality
  - _Requirements: 4.1, 4.3, 4.7_

- [ ]* 9. Write property tests for input validation and formatting
  - [ ]* 9.1 Write property test for Input Validation Consistency
    - **Property 6: Input Validation Consistency**
    - **Validates: Requirements 5.1, 5.2, 5.5**
    - Test various invalid inputs: empty strings, non-numeric strings, malformed numbers
    - Verify all invalid inputs are rejected with appropriate error messages
    - _Requirements: 5.1, 5.2, 5.5_

  - [ ]* 9.2 Write property test for Negative Value Handling
    - **Property 7: Negative Value Handling**
    - **Validates: Requirements 5.3, 5.4**
    - Generate 100 random negative numbers
    - Verify Max-Min Calculator accepts negative values
    - Verify Discount Calculators reject negative values with error messages
    - _Requirements: 5.3, 5.4_

  - [ ]* 9.3 Write property test for Currency Formatting Consistency
    - **Property 8: Currency Formatting Consistency**
    - **Validates: Requirements 4.4, 6.8**
    - Generate 100 random positive amounts
    - Verify all formatted strings start with "Rp"
    - Verify no decimal places in final display
    - Verify thousand separators for amounts >= 1000
    - _Requirements: 4.4, 6.8_

  - [ ]* 9.4 Write property test for Percentage Formatting Consistency
    - **Property 9: Percentage Formatting Consistency**
    - **Validates: Requirements 4.5**
    - Test all discount rates: 0.0, 0.10, 0.20, 0.30
    - Verify all formatted strings end with "%"
    - Verify parsed percentage matches original rate × 100 (within 0.01 tolerance)
    - _Requirements: 4.5_

  - [ ]* 9.5 Write property test for Calculation Precision
    - **Property 10: Calculation Precision**
    - **Validates: Requirements 6.1, 6.2, 6.3**
    - Generate 100 random amounts with decimal places
    - Verify intermediate calculations maintain 2 decimal precision
    - Verify final currency display rounds to whole number
    - _Requirements: 6.1, 6.2, 6.3, 6.8_

- [ ]* 10. Write end-to-end integration tests
  - Test complete flow for Max-Min Calculator: input → validate → calculate → display → reset
  - Test complete flow for Nested IF Calculator: input → validate → calculate → display → reset
  - Test complete flow for Switch-Case Calculator: input → validate → calculate → display → reset
  - Test multiple calculations in sequence within same exercise
  - Test switching between exercises maintains independent state
  - Test keyboard input handling and dismissal
  - Test error message display and clearing on valid input
  - _Requirements: 4.6, 4.8, 5.5, 5.6, 5.7_

- [x] 11. Final checkpoint and polish
  - Ensure all tests pass (unit, property-based, integration)
  - Verify visual consistency with existing app design (colors, typography, spacing)
  - Test on multiple screen sizes and orientations
  - Verify accessibility: semantic labels, color contrast, touch target sizes
  - Test with extreme inputs (very large numbers, many decimal places)
  - Verify smooth animations and transitions
  - Ask the user if questions arise or if any refinements are needed.

## Notes

- Tasks marked with `*` are optional and can be skipped for faster MVP delivery
- Each task references specific requirements for traceability
- Property-based tests validate universal correctness properties from the design document
- Unit tests validate specific examples and edge cases
- Integration tests verify end-to-end user flows
- Checkpoints ensure incremental validation and provide opportunities for user feedback
- All currency formatting uses Indonesian Rupiah (Rp) with thousand separators
- All percentage formatting uses % suffix
- The implementation follows Flutter best practices with StatefulWidget for pages with state and StatelessWidget for static components
