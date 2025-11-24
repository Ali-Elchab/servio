enum FilterType { select, text, number, toggle, dateRange }

class FilterOption {
  final String value;
  final String label;
  const FilterOption(this.value, this.label);
}

class FilterField {
  final String key;
  final String label;
  final FilterType type;
  final List<FilterOption> options;
  final String? hint;

  const FilterField({
    required this.key,
    required this.label,
    required this.type,
    this.options = const [],
    this.hint,
  });
}
