# Requirements Document

## Introduction

Fitur Conditional Branching Exercises adalah serangkaian latihan interaktif dalam aplikasi Flutter yang dirancang untuk mengajarkan konsep percabangan kondisional (conditional branching) kepada pengguna. Fitur ini mencakup tiga latihan berbeda yang mendemonstrasikan penggunaan IF statement, Nested IF, dan Switch-Case dalam konteks perhitungan praktis.

## Glossary

- **Conditional_Branching_Module**: Modul utama yang mengelola tiga latihan percabangan kondisional
- **Max_Min_Calculator**: Komponen yang menentukan nilai maksimal dan minimal dari dua bilangan menggunakan IF statement
- **Discount_Calculator_Nested**: Komponen yang menghitung diskon berdasarkan jumlah pembelian menggunakan Nested IF
- **Discount_Calculator_Switch**: Komponen yang menghitung diskon berdasarkan jumlah pembelian menggunakan Switch-Case
- **Purchase_Amount**: Jumlah pembelian dalam Rupiah yang diinput oleh pengguna
- **Discount_Rate**: Persentase diskon yang diberikan berdasarkan Purchase_Amount
- **Final_Payment**: Jumlah yang harus dibayar setelah dikurangi diskon
- **Input_Validator**: Komponen yang memvalidasi input pengguna
- **Result_Display**: Komponen yang menampilkan hasil perhitungan kepada pengguna

## Requirements

### Requirement 1: Max-Min Calculator dengan IF Statement

**User Story:** Sebagai pengguna, saya ingin memasukkan dua bilangan dan melihat nilai maksimal dan minimal, sehingga saya dapat memahami cara kerja IF statement dalam perbandingan nilai.

#### Acceptance Criteria

1. THE Max_Min_Calculator SHALL accept two numeric inputs from the user
2. WHEN two numbers are provided, THE Max_Min_Calculator SHALL compare the numbers using IF statement
3. WHEN the first number is greater than the second number, THE Max_Min_Calculator SHALL identify the first number as maximum and the second as minimum
4. WHEN the second number is greater than the first number, THE Max_Min_Calculator SHALL identify the second number as maximum and the first as minimum
5. WHEN both numbers are equal, THE Max_Min_Calculator SHALL display both numbers as equal with no maximum or minimum distinction
6. THE Result_Display SHALL show the maximum value clearly labeled
7. THE Result_Display SHALL show the minimum value clearly labeled
8. WHEN invalid input is provided, THE Input_Validator SHALL display an error message indicating the input must be numeric

### Requirement 2: Discount Calculator dengan Nested IF

**User Story:** Sebagai pengguna, saya ingin memasukkan jumlah pembelian dan melihat perhitungan diskon bertingkat, sehingga saya dapat memahami cara kerja Nested IF dalam menentukan kondisi bertingkat.

#### Acceptance Criteria

1. THE Discount_Calculator_Nested SHALL accept Purchase_Amount as numeric input from the user
2. WHEN Purchase_Amount is greater than or equal to 1500000, THE Discount_Calculator_Nested SHALL apply a Discount_Rate of 30 percent
3. WHEN Purchase_Amount is greater than or equal to 1000000 AND less than 1500000, THE Discount_Calculator_Nested SHALL apply a Discount_Rate of 20 percent
4. WHEN Purchase_Amount is greater than or equal to 500000 AND less than 1000000, THE Discount_Calculator_Nested SHALL apply a Discount_Rate of 10 percent
5. WHEN Purchase_Amount is less than 500000, THE Discount_Calculator_Nested SHALL apply a Discount_Rate of 0 percent
6. THE Discount_Calculator_Nested SHALL calculate the discount amount by multiplying Purchase_Amount by Discount_Rate
7. THE Discount_Calculator_Nested SHALL calculate Final_Payment by subtracting discount amount from Purchase_Amount
8. THE Result_Display SHALL show the original Purchase_Amount before discount
9. THE Result_Display SHALL show the Discount_Rate applied as a percentage
10. THE Result_Display SHALL show the discount amount in Rupiah
11. THE Result_Display SHALL show the Final_Payment amount in Rupiah
12. WHEN Purchase_Amount is negative or zero, THE Input_Validator SHALL display an error message indicating the amount must be positive

### Requirement 3: Discount Calculator dengan Switch-Case

**User Story:** Sebagai pengguna, saya ingin memasukkan jumlah pembelian dan melihat perhitungan diskon menggunakan Switch-Case, sehingga saya dapat memahami perbedaan implementasi antara Nested IF dan Switch-Case untuk logika yang sama.

#### Acceptance Criteria

1. THE Discount_Calculator_Switch SHALL accept Purchase_Amount as numeric input from the user
2. THE Discount_Calculator_Switch SHALL categorize Purchase_Amount into discount tiers using Switch-Case logic
3. WHEN Purchase_Amount falls in tier 4 (greater than or equal to 1500000), THE Discount_Calculator_Switch SHALL apply a Discount_Rate of 30 percent
4. WHEN Purchase_Amount falls in tier 3 (1000000 to less than 1500000), THE Discount_Calculator_Switch SHALL apply a Discount_Rate of 20 percent
5. WHEN Purchase_Amount falls in tier 2 (500000 to less than 1000000), THE Discount_Calculator_Switch SHALL apply a Discount_Rate of 10 percent
6. WHEN Purchase_Amount falls in tier 1 (less than 500000), THE Discount_Calculator_Switch SHALL apply a Discount_Rate of 0 percent
7. THE Discount_Calculator_Switch SHALL calculate the discount amount by multiplying Purchase_Amount by Discount_Rate
8. THE Discount_Calculator_Switch SHALL calculate Final_Payment by subtracting discount amount from Purchase_Amount
9. THE Result_Display SHALL show the original Purchase_Amount before discount
10. THE Result_Display SHALL show the Discount_Rate applied as a percentage
11. THE Result_Display SHALL show the discount amount in Rupiah
12. THE Result_Display SHALL show the Final_Payment amount in Rupiah
13. WHEN Purchase_Amount is negative or zero, THE Input_Validator SHALL display an error message indicating the amount must be positive
14. FOR ALL valid Purchase_Amount values, THE Discount_Calculator_Switch SHALL produce identical results to Discount_Calculator_Nested

### Requirement 4: Navigation and User Interface

**User Story:** Sebagai pengguna, saya ingin mengakses ketiga latihan dengan mudah dan melihat hasil perhitungan dengan jelas, sehingga saya dapat belajar dengan efektif.

#### Acceptance Criteria

1. THE Conditional_Branching_Module SHALL provide a navigation interface to access all three exercises
2. THE Conditional_Branching_Module SHALL display clear titles for each exercise: "IF Statement", "Nested IF", and "Switch-Case"
3. WHEN a user selects an exercise, THE Conditional_Branching_Module SHALL navigate to the corresponding calculator interface
4. THE Result_Display SHALL format all currency values with Rupiah (Rp) prefix and thousand separators
5. THE Result_Display SHALL format all percentage values with percent (%) suffix
6. WHEN calculation is complete, THE Result_Display SHALL show all results simultaneously in a clear, readable format
7. THE Conditional_Branching_Module SHALL provide a way to return to the exercise selection screen from any calculator
8. THE Conditional_Branching_Module SHALL provide a way to reset inputs and perform new calculations within each exercise

### Requirement 5: Input Validation and Error Handling

**User Story:** Sebagai pengguna, saya ingin menerima feedback yang jelas ketika input saya tidak valid, sehingga saya dapat memperbaiki kesalahan dengan mudah.

#### Acceptance Criteria

1. WHEN a user submits empty input fields, THE Input_Validator SHALL display an error message indicating all fields must be filled
2. WHEN a user enters non-numeric characters, THE Input_Validator SHALL display an error message indicating only numbers are allowed
3. WHEN a user enters negative values in Max_Min_Calculator, THE Input_Validator SHALL accept the input as valid numeric values
4. WHEN a user enters negative or zero values in discount calculators, THE Input_Validator SHALL display an error message indicating the amount must be positive
5. THE Input_Validator SHALL prevent calculation execution until all validation rules are satisfied
6. WHEN validation fails, THE Input_Validator SHALL highlight the problematic input field
7. WHEN validation succeeds after a previous error, THE Input_Validator SHALL clear all error messages

### Requirement 6: Calculation Accuracy and Consistency

**User Story:** Sebagai pengguna, saya ingin hasil perhitungan yang akurat dan konsisten, sehingga saya dapat mempercayai output dari latihan ini.

#### Acceptance Criteria

1. THE Max_Min_Calculator SHALL handle integer and decimal numbers with precision up to 2 decimal places
2. THE Discount_Calculator_Nested SHALL calculate discount amounts with precision up to 2 decimal places
3. THE Discount_Calculator_Switch SHALL calculate discount amounts with precision up to 2 decimal places
4. FOR ALL Purchase_Amount values at tier boundaries (500000, 1000000, 1500000), THE discount calculators SHALL apply the higher tier discount rate
5. THE Discount_Calculator_Nested SHALL produce mathematically equivalent results to manual calculation
6. THE Discount_Calculator_Switch SHALL produce mathematically equivalent results to manual calculation
7. WHEN Purchase_Amount is at a tier boundary, THE Discount_Calculator_Switch SHALL produce identical results to Discount_Calculator_Nested
8. THE Result_Display SHALL round all currency values to the nearest Rupiah (no decimal places in final display)
