import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:servio/shared/widgets/custom_text_field.dart';
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
import '/shared/widgets/custom_button.dart';

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
          topPadding: 0,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 12),
                  Center(child: Image.asset(AppAssets.logo, width: 110)),
                  const SizedBox(height: 60),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      context.tr('auth.register.title'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.headlineLarge(context).copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.tr('auth.register.subtitle'),
                    style: AppText.bodyMedium(context).copyWith(color: Colors.grey[700]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 26),
                  CustomTextField(
                    controller: nameController,
                    hintText: context.tr('fields.name'),
                    validator: (v) => (v == null || v.isEmpty) ? context.tr('validation.nameRequired') : null,
                  ),
                  const SizedBox(height: 8),
                  PhoneNumberField(controller: phoneController),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: emailController,
                    hintText: context.tr('fields.email'),
                    validator: (v) => _emailValidator(context, v),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: passwordController,
                    obscureText: obscureText,
                    hintText: context.tr('fields.password'),
                    isPassword: true,
                    validator: (v) => (v == null || v.isEmpty) ? context.tr('validation.passwordRequired') : null,
                  ),
                  const SizedBox(height: 45),
                  CustomButton(
                    text: context.tr('auth.register.asUser'),
                    onPressed: isLoading ? null : _onRegisterPressed,
                    isLoading: isLoading,
                  ),
                  const SizedBox(height: 12),
                  CustomButton(
                    text: context.tr('auth.register.asProvider'),
                    isFill: false,
                    onPressed: isLoading ? null : () => context.go(RouterPaths.registerProvider),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.tr('auth.register.haveAccount'),
                        style: AppText.bodyMedium(context).copyWith(color: Colors.grey[700]),
                      ),
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
                    ],
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
