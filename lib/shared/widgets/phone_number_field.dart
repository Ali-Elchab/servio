import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import '/shared/extensions/context_extensions.dart';

class PhoneNumberField extends StatelessWidget {
  final PhoneController controller;
  final String? Function(PhoneNumber?)? validator;
  final ValueChanged<String>? onCompletePhoneChanged;

  const PhoneNumberField({super.key, required this.controller, this.validator, this.onCompletePhoneChanged});

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      child: PhoneFormField(
        controller: controller,
        countrySelectorNavigator: const CountrySelectorNavigator.bottomSheet(),
        isCountryButtonPersistent: true,
        autofillHints: const [AutofillHints.telephoneNumber],
        countryButtonStyle: const CountryButtonStyle(showDialCode: true, showIsoCode: false, showFlag: true, flagSize: 16),
        decoration: InputDecoration(
          hintText: context.tr('fields.phoneNumber'),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator ?? (p) => (p == null || !p.isValid()) ? 'error.invalidPhoneNumber' : null,
        onChanged: (p) {
          if (onCompletePhoneChanged != null) {
            onCompletePhoneChanged!(p.international);
          }
        },
      ),
    );
  }
}
