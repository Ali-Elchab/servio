import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '/core/theme/app_colors.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '/core/errors/user_messages.dart';
import '/core/router/app_router_paths.dart';
import '/core/theme/app_text.dart';

import '/features/auth/cubit/auth_cubit.dart';
import '/features/auth/presentation/widgets/account_action.dart';
import '/shared/extensions/context_extensions.dart';
import '/shared/widgets/app_page_wrapper.dart';
import '/shared/widgets/custom_button.dart';
import '/shared/widgets/custom_text_field.dart';
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Image.asset('assets/logo/logo.png', height: 100.h)),
                SizedBox(height: 70.h),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    context.tr('auth.welcome.createAnAccount'),
                    style: AppText.headlineLarge(context).copyWith(color: AppColors.primary, fontSize: 32.sp),
                  ),
                ),
                SizedBox(height: 60.h),
                PhoneNumberField(controller: phoneController),
                SizedBox(height: 15.h),
                CustomTextField(
                  controller: nameController,
                  hintText: context.tr('fields.name'),
                  validator: (v) => (v == null || v.isEmpty) ? context.tr('validation.nameRequired') : null,
                ),
                SizedBox(height: 15.h),
                CustomTextField(
                    controller: emailController,
                    hintText: context.tr('fields.email'),
                    validator: (v) => _emailValidator(context, v)),
                SizedBox(height: 15.h),
                CustomTextField(
                  controller: passwordController,
                  obscureText: obscureText,
                  onToggleVisibility: _togglePasswordVisibility,
                  hintText: context.tr('fields.password'),
                  isPassword: true,
                  validator: (v) => (v == null || v.isEmpty) ? context.tr('validation.passwordRequired') : null,
                ),
                SizedBox(height: 70.h),
                CustomButton(
                    text: context.tr('auth.buttons.register'),
                    isLoading: isLoading,
                    onPressed: isLoading ? null : _onRegisterPressed),
                SizedBox(height: 40.h),
                FittedBox(
                  child: AccountAction(
                    route: RouterPaths.login,
                    text: context.tr('auth.labels.haveAccount'),
                    action: context.tr('auth.buttons.login'),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
