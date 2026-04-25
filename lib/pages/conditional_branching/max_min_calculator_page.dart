import 'package:flutter/material.dart';
import 'widgets/calculator_input_field.dart';
import 'widgets/result_display_card.dart';
import 'constants/strings.dart';
import 'utils/validation_utils.dart';

/// Page demonstrating IF statement usage through max/min comparison
class MaxMinCalculatorPage extends StatefulWidget {
  const MaxMinCalculatorPage({super.key});

  @override
  State<MaxMinCalculatorPage> createState() => _MaxMinCalculatorPageState();
}

class _MaxMinCalculatorPageState extends State<MaxMinCalculatorPage> {
  // Controllers
  final TextEditingController _number1Controller = TextEditingController();
  final TextEditingController _number2Controller = TextEditingController();

  // State variables
  double? _maxValue;
  double? _minValue;
  bool _isEqual = false;
  bool _isCalculated = false;
  String? _errorMessage1;
  String? _errorMessage2;

  @override
  void dispose() {
    _number1Controller.dispose();
    _number2Controller.dispose();
    super.dispose();
  }

  /// Validates both input fields
  bool _validateInputs() {
    final validation1 = validateNumericInput(
      _number1Controller.text,
      allowNegative: true,
    );
    final validation2 = validateNumericInput(
      _number2Controller.text,
      allowNegative: true,
    );

    setState(() {
      _errorMessage1 = validation1.errorMessage;
      _errorMessage2 = validation2.errorMessage;
    });

    return validation1.isValid && validation2.isValid;
  }

  /// Calculates max and min values using IF statements
  void _calculate() {
    if (!_validateInputs()) {
      return;
    }

    final num1 = double.parse(_number1Controller.text);
    final num2 = double.parse(_number2Controller.text);

    setState(() {
      if (num1 > num2) {
        _maxValue = num1;
        _minValue = num2;
        _isEqual = false;
      } else if (num2 > num1) {
        _maxValue = num2;
        _minValue = num1;
        _isEqual = false;
      } else {
        _maxValue = null;
        _minValue = null;
        _isEqual = true;
      }
      _isCalculated = true;
    });
  }

  /// Resets all inputs and results
  void _reset() {
    _number1Controller.clear();
    _number2Controller.clear();
    setState(() {
      _maxValue = null;
      _minValue = null;
      _isEqual = false;
      _isCalculated = false;
      _errorMessage1 = null;
      _errorMessage2 = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          ConditionalBranchingStrings.maxMinTitle,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF1565C0), Color(0xFF7B1FA2)],
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF5F7FA),
              Color(0xFFE8EAF6),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.compare_arrows,
                size: 60,
                color: Color(0xFF1565C0),
              ),
              const SizedBox(height: 16),
              const Text(
                ConditionalBranchingStrings.ifStatementTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1565C0),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Bandingkan dua bilangan untuk menemukan nilai maksimal dan minimal',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF757575),
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 32),
              CalculatorInputField(
                controller: _number1Controller,
                label: ConditionalBranchingStrings.number1Label,
                hint: ConditionalBranchingStrings.number1Hint,
                errorText: _errorMessage1,
                onChanged: (_) {
                  if (_errorMessage1 != null) {
                    setState(() => _errorMessage1 = null);
                  }
                },
              ),
              const SizedBox(height: 16),
              CalculatorInputField(
                controller: _number2Controller,
                label: ConditionalBranchingStrings.number2Label,
                hint: ConditionalBranchingStrings.number2Hint,
                errorText: _errorMessage2,
                onChanged: (_) {
                  if (_errorMessage2 != null) {
                    setState(() => _errorMessage2 = null);
                  }
                },
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _calculate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1565C0),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        ConditionalBranchingStrings.calculateButton,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _reset,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(
                          color: Color(0xFF1565C0),
                          width: 2,
                        ),
                      ),
                      child: const Text(
                        ConditionalBranchingStrings.resetButton,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF1565C0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (_isCalculated) ...[
                const SizedBox(height: 32),
                ResultDisplayCard(
                  maxValue: _maxValue,
                  minValue: _minValue,
                  isEqual: _isEqual,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
