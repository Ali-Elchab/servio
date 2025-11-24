// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '/core/theme/app_colors.dart';

class RowDisplay {
  final String title;
  final String? subtitle;
  final String uomLabel;
  final String quantityLabel;
  final Widget? actions;

  const RowDisplay({
    required this.title,
    required this.uomLabel,
    required this.quantityLabel,
    this.subtitle,
    this.actions,
  });
}

/// Presents document rows (e.g. transfers, purchase receivables) in a styled table.
class RowsTable extends StatelessWidget {
  const RowsTable({
    Key? key,
    required this.rows,
    required this.numberHeader,
    required this.nameHeader,
    required this.uomHeader,
    required this.qtyHeader,
    required this.actionsHeader,
    required this.emptyMessage,
    this.palette = AppColors.brandPalette,
  }) : super(key: key);

  final List<RowDisplay> rows;
  final String numberHeader;
  final String nameHeader;
  final String uomHeader;
  final String qtyHeader;
  final String actionsHeader;
  final String emptyMessage;
  final FeaturePalette palette;

  @override
  Widget build(BuildContext context) {
    final headerStyle = (Theme.of(context).textTheme.labelMedium ?? const TextStyle()).copyWith(
      fontWeight: FontWeight.w700,
      fontSize: 12,
      color: palette.primary,
    );
    final cellStyle = (Theme.of(context).textTheme.bodySmall ?? const TextStyle()).copyWith(fontSize: 11);
    final dividerColor = Theme.of(context).dividerColor;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
        color: Theme.of(context).colorScheme.surface,
      ),
      clipBehavior: Clip.hardEdge,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Table(
          border: TableBorder(
            horizontalInside: BorderSide(
              color: dividerColor.withValues(alpha: .4),
              width: .7,
            ),
            verticalInside: BorderSide(
              color: dividerColor.withValues(alpha: .3),
              width: .7,
            ),
          ),
          columnWidths: const {
            0: FixedColumnWidth(25),
            1: FlexColumnWidth(3.5),
            2: FlexColumnWidth(1.3),
            3: FlexColumnWidth(1.4),
            4: FixedColumnWidth(30),
          },
          children: [
            TableRow(
              decoration: const BoxDecoration(
                color: Color(0xFFE9EFFD),
              ),
              children: [
                _headerCell(numberHeader, headerStyle, palette),
                _headerCell(nameHeader, headerStyle, palette),
                _headerCell(uomHeader, headerStyle, palette),
                _headerCell(qtyHeader, headerStyle, palette),
                _headerCell(actionsHeader, headerStyle, palette),
              ],
            ),
            ...rows.asMap().entries.map((entry) {
              final index = entry.key;
              final data = entry.value;
              return TableRow(
                children: [
                  _indexCell(index + 1, cellStyle),
                  _nameCell(data.title, data.subtitle, cellStyle),
                  _textCell(data.uomLabel, cellStyle),
                  _qtyCell(data.quantityLabel, cellStyle),
                  data.actions ?? const SizedBox.shrink(),
                ],
              );
            }),
            if (rows.isEmpty)
              TableRow(
                children: [
                  const SizedBox.shrink(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    child: Text(emptyMessage, style: cellStyle),
                  ),
                  const SizedBox.shrink(),
                  const SizedBox.shrink(),
                  const SizedBox.shrink(),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _headerCell(String text, TextStyle? style, FeaturePalette palette) => Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: palette.primary, width: 3),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Text(text, style: style),
      );

  Widget _indexCell(int index, TextStyle? style) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
        child: Center(
          child: Text(
            '$index',
            style: style?.copyWith(fontSize: 9, color: Colors.grey[600]),
          ),
        ),
      );

  Widget _nameCell(String title, String? subtitle, TextStyle? style) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: style?.copyWith(fontSize: 13, height: 1.0),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (subtitle != null && subtitle.isNotEmpty)
              Text(
                subtitle,
                style: style?.copyWith(
                  fontSize: 8,
                  height: 1.0,
                  color: Colors.grey[600],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      );

  Widget _textCell(String text, TextStyle? style) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: style,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );

  Widget _qtyCell(String text, TextStyle? style) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
        child: Center(
          child: Text(text, style: style, textAlign: TextAlign.center),
        ),
      );
}
