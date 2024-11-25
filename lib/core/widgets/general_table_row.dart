import 'package:bais_mobile/core/helpers/utils/color_extensions.dart';
import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:flutter/material.dart';

class GeneralTableRow extends StatelessWidget {
  final String label;
  final String value;

  const GeneralTableRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppTheme.secondary100),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: HexColor("#475467"),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 8,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
