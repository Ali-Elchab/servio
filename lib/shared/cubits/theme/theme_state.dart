part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final ThemeMode mode;
  final bool isDark;
  const ThemeState({required this.mode, required this.isDark});

  @override
  List<Object?> get props => [mode, isDark];
}
