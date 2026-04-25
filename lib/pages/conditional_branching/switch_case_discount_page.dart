import 'package:flutter/material.dart';
import 'widgets/calculator_input_field.dart';
import 'widgets/discount_result_card.dart';
import 'constants/strings.dart';
import 'utils/validation_utils.dart';

/// Page demonstrating Switch-Case through tiered discount calculation
class SwitchCaseDiscountPage extends StatefulWidget {
  const SwitchCaseDiscountPage({super.key});

  @override
  State<SwitchCaseDiscountPage> createState() => _SwitchCaseDiscountPageState();
}

class _SwitchCaseDiscountPageState extends State<SwitchCaseDiscountPage> {
  // Controller
  final TextEditingController _purchaseAmountController =
      TextEditingController();

  // State variables
  double? _originalAmount;
  double? _discountRate;
  double? _discountAmount;
  double? _finalPayment;
  bool _isCalculated = false;
  String? _errorMessage;

  @override
  void dispose() {
    _purchaseAmountController.dispose();
    super.dispose();
  }

  /// Determines discount tier from purchase amount
  /// Returns tier number: 1 (< 500k), 2 (500k-999k), 3 (1M-1.49M), 4 (>= 1.5M)
  int _getTier(double amount) {
    if (amount >= 1500000) return 4;
    if (amount >= 1000000) return 3;
    if (amount >= 500000) return 2;
    return 1;
  }

  /// Validates purchase amount input
  bool _validateInput() {
    final validation = validateNumericInput(
      _purchaseAmountController.text,
      allowNegative: false,
    );

    setState(() {
      _errorMessage = validation.errorMessage;
    });

    return validation.isValid;
  }

  /// Calculates discount using switch-case statements
  void _calculateDiscount() {
    if (!_validateInput()) {
      return;
    }

    final amount = double.parse(_purchaseAmountController.text);
    final tier = _getTier(amount);
    double rate = 0;

    // Switch-case logic for tier-based discount
    switch (tier) {
      case 4:
        rate = 0.30;
        break;
      case 3:
        rate = 0.20;
        break;
      case 2:
        rate = 0.10;
        break;
      case 1:
      default:
        rate = 0.0;
        break;
    }

    setState(() {
      _originalAmount = amount;
      _discountRate = rate;
      _discountAmount = amount * rate;
      _finalPayment = amount - _discountAmount!;
      _isCalculated = true;
    });
  }

  /// Resets all inputs and results
  void _reset() {
    _purchaseAmountController.clear();
    setState(() {
      _originalAmount = null;
      _discountRate = null;
      _discountAmount = null;
      _finalPayment = null;
      _isCalculated = false;
      _errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          ConditionalBranchingStrings.discountTitle,
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
                Icons.discount,
                size: 60,
                color: Color(0xFFFF6F00),
              ),
              const SizedBox(height: 16),
              const Text(
                ConditionalBranchingStrings.switchCaseTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF6F00),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Hitung diskon bertingkat menggunakan Switch-Case',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF757575),
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 24),
              _buildDiscountTierInfo(),
              const SizedBox(height: 24),
              CalculatorInputField(
                controller: _purchaseAmountController,
                label: ConditionalBranchingStrings.purchaseAmountLabel,
                hint: ConditionalBranchingStrings.purchaseAmountHint,
                errorText: _errorMessage,
                onChanged: (_) {
                  if (_errorMessage != null) {
                    setState(() => _errorMessage = null);
                  }
                },
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _calculateDiscount,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6F00),
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
                          color: Color(0xFFFF6F00),
                          width: 2,
                        ),
                      ),
                      child: const Text(
                        ConditionalBranchingStrings.resetButton,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFF6F00),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (_isCalculated) ...[
                const SizedBox(height: 32),
                DiscountResultCard(
                  originalAmount: _originalAmount!,
                  discountRate: _discountRate!,
                  discountAmount: _discountAmount!,
                  finalPayment: _finalPayment!,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiscountTierInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFFF6F00).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tingkat Diskon:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF6F00),
            ),
          ),
          const SizedBox(height: 8),
          _buildTierRow('< Rp500.000', '0%'),
          _buildTierRow('Rp500.000 - Rp999.999', '10%'),
          _buildTierRow('Rp1.000.000 - Rp1.499.999', '20%'),
          _buildTierRow('≥ Rp1.500.000', '30%'),
        ],
      ),
    );
  }

  Widget _buildTierRow(String range, String discount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            range,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF757575),
            ),
          ),
          Text(
            discount,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF6F00),
            ),
          ),
        ],
      ),
    );
  }
}
