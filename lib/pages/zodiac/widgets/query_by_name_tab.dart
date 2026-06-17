import 'package:flutter/material.dart';
import '../../../database/app_database.dart';
import '../../../services/zodiac_service.dart';
import '../../../validators/input_validator.dart';
import '../../../models/zodiac_query_result.dart';
import '../constants/zodiac_constants.dart';
import 'zodiac_result_card.dart';
import 'description_section.dart';

class QueryByNameTab extends StatefulWidget {
  final ZodiacService service;

  const QueryByNameTab({super.key, required this.service});

  @override
  State<QueryByNameTab> createState() => _QueryByNameTabState();
}

class _QueryByNameTabState extends State<QueryByNameTab> with AutomaticKeepAliveClientMixin {
  final TextEditingController _controller = TextEditingController();
  final InputValidator _validator = InputValidator();
  
  bool _isLoading = false;
  String? _errorMessage;
  ZodiacQueryResult? _result;

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    final name = _controller.text;
    final validation = _validator.validateZodiacName(name);

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
      final data = await widget.service.getZodiacByName(name);
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
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: ZodiacConstants.searchHint,
                      prefixIcon: const Icon(Icons.star_outline, color: ZodiacConstants.primaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: ZodiacConstants.primaryColor, width: 2),
                      ),
                    ),
                    onSubmitted: (_) => _search(),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _search,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ZodiacConstants.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.search),
                    label: const Text(
                      ZodiacConstants.searchButtonText,
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
                child: CircularProgressIndicator(color: ZodiacConstants.primaryColor),
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
