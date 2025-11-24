import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/theme/app_colors.dart';
import '/shared/cubits/locale/locale_cubit.dart';

import '/core/constants/app_constants.dart';

class LanguageDropdown extends StatelessWidget {
  final bool onPrimary;
  const LanguageDropdown({super.key, this.onPrimary = false});

  String _labelForLocale(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'ar':
        return 'العربية';
      case 'fr':
        return 'Français';
      default:
        return locale.languageCode.toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, currentLocale) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: onPrimary ? context.colors.primary : Colors.white,
            border: Border.all(
              color: onPrimary ? Colors.white70 : context.colors.primary,
              width: 1.5,
            ),
            boxShadow: [
              if (!onPrimary)
                BoxShadow(
                  color: context.colors.primary.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Locale>(
              dropdownColor: onPrimary ? context.colors.primary : Colors.white,
              borderRadius: BorderRadius.circular(12),
              alignment: Alignment.center,
              value: AppConstants.supportedLocales.firstWhere(
                (l) => l.languageCode == currentLocale.languageCode,
                orElse: () => Locale(AppConstants.defaultLang),
              ),
              icon: Icon(Icons.language, size: 18, color: onPrimary ? Colors.white : context.colors.primary),
              isDense: true,
              items: AppConstants.supportedLocales
                  .map(
                    (locale) => DropdownMenuItem<Locale>(
                      value: locale,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _labelForLocale(locale),
                            style: TextStyle(
                              color: onPrimary ? Colors.white : context.colors.text,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (locale) {
                if (locale == null) return;
                context.read<LocaleCubit>().changeLocale(locale);
              },
            ),
          ),
        );
      },
    );
  }
}
