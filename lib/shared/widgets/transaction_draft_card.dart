import 'package:flutter/material.dart';
import '/shared/extensions/context_extensions.dart';
import '/core/theme/app_colors.dart';

class TransactionDraftCard extends StatelessWidget {
  const TransactionDraftCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.rowsLabel,
    required this.rowsCount,
    required this.onContinue,
    required this.onDelete,
    this.trailingLabel,
    this.accentPalette,
  });

  final String title;
  final String subtitle;
  final String rowsLabel;
  final int rowsCount;
  final VoidCallback onContinue;
  final VoidCallback onDelete;
  final String? trailingLabel;
  final FeaturePalette? accentPalette;

  FeaturePalette get _palette => accentPalette ?? AppColors.brandPalette;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return Material(
      elevation: 2,
      color: colors.surface,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (trailingLabel != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      trailingLabel!,
                      style: textTheme.bodySmall?.copyWith(color: Colors.black54),
                    ),
                  ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: context.tr('actions.delete'),
                  onPressed: onDelete,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: textTheme.bodySmall?.copyWith(color: Colors.black54),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _rowsPill(context),
                const Spacer(),
                TextButton.icon(
                  onPressed: onContinue,
                  icon: Icon(
                    Icons.edit_note,
                    color: _palette.primary,
                  ),
                  label: Text(
                    context.tr('transactions.drafts.continue'),
                    style: TextStyle(color: _palette.primary),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _rowsPill(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: _palette.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$rowsLabel: $rowsCount',
        style: Theme.of(context).textTheme.labelMedium?.copyWith(color: _palette.primary, fontWeight: FontWeight.w600),
      ),
    );
  }
}
