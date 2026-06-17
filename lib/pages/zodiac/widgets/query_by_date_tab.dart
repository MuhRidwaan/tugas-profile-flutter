import 'package:flutter/material.dart';
import '../../../database/app_database.dart';
import '../../../services/zodiac_service.dart';
import '../../../validators/input_validator.dart';
import '../../../models/zodiac_query_result.dart';
import '../constants/zodiac_constants.dart';
import 'zodiac_result_card.dart';
import 'description_section.dart';

class QueryByDateTab extends StatefulWidget {
  final ZodiacService service;

  const QueryByDateTab({super.key, required this.service});

  @override
  State<QueryByDateTab> createState() => _QueryByDateTabState();
}

class _QueryByDateTabState extends State<QueryByDateTab> with AutomaticKeepAliveClientMixin {
  final InputValidator _validator = InputValidator();

  int? _selectedDay;
  int? _selectedMonth;
  bool _isLoading = false;
  String? _errorMessage;
  ZodiacQueryResult? _result;

  final List<String> _monthsIndo = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];

  @override
  bool get wantKeepAlive => true;

  int _getMaxDays(int? month) {
    if (month == null) return 31;
    switch (month) {
      case 2:
        return 29; // allow 29 for leap year
      case 4:
      case 6:
      case 9:
      case 11:
        return 30;
      default:
        return 31;
    }
  }

  void _onMonthChanged(int? newMonth) {
    if (newMonth == null) return;
    setState(() {
      _selectedMonth = newMonth;
      final maxDays = _getMaxDays(newMonth);
      if (_selectedDay != null && _selectedDay! > maxDays) {
        _selectedDay = maxDays;
      }
      _errorMessage = null;
    });
  }

  Future<void> _search() async {
    final validation = _validator.validateDate(_selectedDay, _selectedMonth);

    if (!validation.isValid) {
      setState(() {
        _errorMessage = validation.errorMessage;
        _result = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final data = await widget.service.getZodiacByDate(_selectedDay!, _selectedMonth!);
      if (data == null) {
        setState(() {
          _errorMessage = ZodiacConstants.notFoundText;
          _result = null;
        });
      } else {
        setState(() {
          _result = ZodiacQueryResult.fromData(data);
          _errorMessage = null;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = ZodiacConstants.connectionErrorText;
        _result = null;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // required by keep-alive

    final maxDays = _getMaxDays(_selectedMonth);
    final daysList = List.generate(maxDays, (index) => index + 1);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(ZodiacConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ZodiacConstants.cardBorderRadius),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          key: const Key('day-dropdown'),
                          value: _selectedDay,
                          hint: const Text('Tanggal'),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          items: daysList
                              .map((day) => DropdownMenuItem<int>(
                                    value: day,
                                    child: Text(day.toString()),
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              _selectedDay = val;
                              _errorMessage = null;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          key: const Key('month-dropdown'),
                          value: _selectedMonth,
                          hint: const Text('Bulan'),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          items: List.generate(12, (index) => index + 1)
                              .map((mIndex) => DropdownMenuItem<int>(
                                    value: mIndex,
                                    child: Text(_monthsIndo[mIndex - 1]),
                                  ))
                              .toList(),
                          onChanged: _onMonthChanged,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _search,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ZodiacConstants.accentColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.calendar_today),
                    label: const Text(
                      ZodiacConstants.dateSearchButtonText,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (_isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: CircularProgressIndicator(color: ZodiacConstants.accentColor),
              ),
            )
          else if (_errorMessage != null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ZodiacConstants.errorColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ZodiacConstants.errorColor.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: ZodiacConstants.errorColor),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: ZodiacConstants.errorColor, fontSize: 15),
                    ),
                  ),
                ],
              ),
            )
          else if (_result != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ZodiacResultCard(
                  namaZodiac: _result!.zodiac.namaZodiac,
                  dateRangeFormatted: _result!.dateRangeFormatted,
                ),
                ..._result!.sections.map(
                  (sec) => DescriptionSection(
                    title: sec.title,
                    content: sec.content,
                    icon: sec.icon,
                  ),
                ),
              ],
            )
          else
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: Text(
                  ZodiacConstants.emptyStateText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
