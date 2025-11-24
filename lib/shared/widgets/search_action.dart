import 'package:flutter/material.dart';
import '/core/theme/app_colors.dart';

/// A reusable search action button used in app bars.
///
/// - [delegate] is the SearchDelegate used to collect the query.
/// - [onSelected] is called with the trimmed query when the user submits a search.
class SearchAction extends StatelessWidget {
  final SearchDelegate<String?> delegate;
  final void Function(String?)? onSelected;
  final EdgeInsetsGeometry padding;

  /// When true, render a compact circular icon-only button. When false,
  /// render the default pill with icon + label.
  final bool compact;

  const SearchAction({
    super.key,
    required this.delegate,
    this.onSelected,
    this.padding = const EdgeInsets.only(right: 12),
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final bgPrimary = c.buttonBg;
    final fg = c.buttonFg;

    if (compact) {
      // Circular icon-only button
      return Padding(
        padding: padding,
        child: Tooltip(
          message: 'Search',
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(999),
              onTap: () async {
                final res = await showSearch<String?>(context: context, delegate: delegate);
                // Forward the result even when null so the caller can clear search state.
                onSelected?.call(res);
              },
              child: Ink(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [bgPrimary, bgPrimary.withOpacity(0.85)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(color: bgPrimary.withOpacity(0.18), blurRadius: 8, offset: const Offset(0, 3)),
                  ],
                  border: Border.all(color: c.borderIdle.withOpacity(0.12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.search_rounded, color: fg, size: 20),
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Default pill (icon + label)
    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: () async {
          final res = await showSearch<String?>(context: context, delegate: delegate);
          // Forward even null to clear search when delegate closed with empty query
          onSelected?.call(res);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [bgPrimary.withOpacity(0.95), c.surface.withOpacity(0.06)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: bgPrimary.withOpacity(0.18),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(color: c.borderIdle.withOpacity(0.12)),
          ),
          child: Row(
            children: [
              Icon(Icons.search_rounded, color: fg, size: 20),
              const SizedBox(width: 8),
              Text('Search', style: TextStyle(color: fg, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}
