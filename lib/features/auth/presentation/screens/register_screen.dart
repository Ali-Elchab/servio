import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phone_form_field/phone_form_field.dart';
import '/core/constants/app_assets.dart';
import '/core/errors/user_messages.dart';
import '/core/router/app_router_paths.dart';
import '/core/theme/app_text.dart';
import '/features/auth/cubit/auth_cubit.dart';
import '/shared/extensions/context_extensions.dart';
import '/shared/widgets/app_page_wrapper.dart';
import '/shared/widgets/phone_number_field.dart';
import '/shared/widgets/snackbar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = PhoneController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    phoneController.value = const PhoneNumber(isoCode: IsoCode.LB, nsn: '');
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() => setState(() => obscureText = !obscureText);

  Future<void> _onRegisterPressed() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final fullPhone = phoneController.value.international;
    log('Register pressed: $fullPhone');
    await context.read<AuthCubit>().register(
          phone: fullPhone,
          password: passwordController.text,
          name: nameController.text.trim(),
          email: emailController.text.trim(),
        );
  }

  String? _emailValidator(BuildContext context, String? v) {
    if (v == null || v.isEmpty) return context.tr('validation.emailRequired');
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v);
    return ok ? null : context.tr('validation.emailInvalid');
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select((AuthCubit c) => c.state is AuthChecking);
    final colors = context.colors;

    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (prev, next) => prev.runtimeType != next.runtimeType,
      listener: (context, state) {
        switch (state) {
          case Authenticated():
            context.go(RouterPaths.home);
          case Unauthenticated(lastError: final e):
            if (e != null) {
              showCustomSnackBar(context: context, message: userMessage(e));
            }
          default:
            break;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: AppPageWrapper(
          appBar: AppBar(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 12),
                  Center(child: Image.asset(AppAssets.logoNoBg, width: 110)),
                  const SizedBox(height: 24),
                  Text(
                    context.tr('auth.welcome.createAnAccount'),
                    style: AppText.displaySmall(context).copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _RoundedInput(
                    controller: nameController,
                    hintText: context.tr('fields.name'),
                    validator: (v) => (v == null || v.isEmpty) ? context.tr('validation.nameRequired') : null,
                  ),
                  const SizedBox(height: 14),
                  PhoneNumberField(controller: phoneController),
                  const SizedBox(height: 14),
                  _RoundedInput(
                    controller: emailController,
                    hintText: context.tr('fields.email'),
                    validator: (v) => _emailValidator(context, v),
                  ),
                  const SizedBox(height: 14),
                  _RoundedInput(
                    controller: passwordController,
                    obscureText: obscureText,
                    hintText: context.tr('fields.password'),
                    suffix: IconButton(
                      icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: Colors.grey[500]),
                      onPressed: _togglePasswordVisibility,
                    ),
                    validator: (v) => (v == null || v.isEmpty) ? context.tr('validation.passwordRequired') : null,
                  ),
                  const SizedBox(height: 28),
                  _OutlinedActionButton(
                    label: context.tr('auth.register.asUser'),
                    onTap: isLoading ? null : _onRegisterPressed,
                  ),
                  const SizedBox(height: 12),
                  _FilledActionButton(
                    label: context.tr('auth.register.asProvider'),
                    onTap: isLoading ? null : () => context.go(RouterPaths.registerProvider),
                  ),
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: () => context.go(RouterPaths.login),
                    child: Text(
                      context.tr('auth.buttons.login'),
                      style: AppText.bodyMedium(context).copyWith(
                        color: colors.secondary,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                        decorationColor: colors.secondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RoundedInput extends StatelessWidget {
  const _RoundedInput({
    required this.controller,
    required this.hintText,
    this.validator,
    this.obscureText = false,
    this.suffix,
  });

  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colors.secondary.withOpacity(0.6), width: 1.8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.red.shade400),
        ),
        suffixIcon: suffix,
      ),
    );
  }
}

class _OutlinedActionButton extends StatelessWidget {
  const _OutlinedActionButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.primary,
          side: BorderSide(color: colors.secondary, width: 2),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: Text(
          label,
          style: AppText.titleMedium(context).copyWith(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class _FilledActionButton extends StatelessWidget {
  const _FilledActionButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.secondary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: Text(
          label,
          style: AppText.titleMedium(context).copyWith(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
