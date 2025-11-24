import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/shared/widgets/language_drop_down.dart';
import '/shared/widgets/snackbar.dart';
import '/core/theme/app_colors.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '/core/theme/app_text.dart';

import '/features/auth/cubit/auth_cubit.dart';
import '/shared/extensions/context_extensions.dart';
import '/shared/widgets/app_page_wrapper.dart';
import '/shared/widgets/custom_button.dart';
import '/shared/widgets/custom_text_field.dart';
import '/shared/widgets/phone_number_field.dart';

enum LoginMode { email, phone }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final phoneController = PhoneController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late final TabController _tab;
  LoginMode mode = LoginMode.email;

  bool obscureText = true;
  bool remember = true;

  @override
  void initState() {
    super.initState();
    phoneController.value = const PhoneNumber(isoCode: IsoCode.LB, nsn: '');
    _tab = TabController(length: 2, vsync: this)
      ..addListener(() {
        if (_tab.indexIsChanging) return;
        setState(() => mode = _tab.index == 0 ? LoginMode.email : LoginMode.phone);
      });
  }

  @override
  void dispose() {
    _tab.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() => setState(() => obscureText = !obscureText);

  String? _emailValidator(String? v) {
    final s = (v ?? '').trim();
    if (s.isEmpty) return 'Required';
    final ok = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(s);
    return ok ? null : 'Enter a valid email';
  }

  Future<void> _onLoginPressed() async {
    final identifier = mode == LoginMode.phone ? phoneController.value.international : emailController.text.trim();
    await context.read<AuthCubit>().login(identifier, passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select((AuthCubit c) => c.state is AuthChecking);

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          showCustomSnackBar(context: context, message: state.error!.message, backgroundColor: Colors.red);
        }
      },
      child: AppPageWrapper(
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.only(end: 16.w),
              child: const LanguageDropdown(),
            ),
          ],
        ),
        resizeToAvoidBottomInset: true,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Image.asset('assets/logo/logo.png', width: 160.h)),
              SizedBox(height: 20.h),
              Text(context.tr('auth.login.title'),
                  style: AppText.headlineLarge(context).copyWith(color: AppColors.primary)),
              SizedBox(height: 30.h),

              // ---- TAB BAR ----
              Container(
                height: 42.h,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: TabBar(
                  controller: _tab,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4.r)],
                  ),
                  labelColor: AppColors.primary,
                  unselectedLabelColor: const Color(0xFF7A7A7A),
                  tabs: [
                    Tab(text: context.tr('auth.login.emailTab')),
                    Tab(text: context.tr('auth.login.phoneTab')),
                  ],
                ),
              ),
              SizedBox(height: 15.h),

              // ---- SWITCHED INPUT ----
              if (mode == LoginMode.phone)
                PhoneNumberField(
                  controller: phoneController,
                  onCompletePhoneChanged: (full) => debugPrint('Full phone: $full'),
                )
              else
                CustomTextField(
                  controller: emailController,
                  hintText: context.tr('fields.email'),
                  // keyboardType: TextInputType.emailAddress,
                  validator: _emailValidator,
                ),

              SizedBox(height: 15.h),

              CustomTextField(
                controller: passwordController,
                obscureText: obscureText,
                onToggleVisibility: _togglePasswordVisibility,
                hintText: context.tr('fields.password'),
                isPassword: true,
                validator: (v) => (v == null || v.isEmpty) ? context.tr('validation.passwordRequired') : null,
              ),
              SizedBox(height: 5.h),

              _LoginForgotPassword(
                remember: remember,
                press: (v) => setState(() => remember = v ?? remember),
              ),
              SizedBox(height: 50.h),

              CustomButton(
                text: context.tr('auth.buttons.login'),
                isLoading: isLoading,
                onPressed: isLoading ? null : _onLoginPressed,
              ),
              SizedBox(height: 80.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForgotPassword extends StatelessWidget {
  final bool remember;
  final Function(bool? value) press;
  const _LoginForgotPassword({required this.remember, required this.press});

  @override
  Widget build(BuildContext context) {
    final rememberLabel = Text(
      context.tr("auth.labels.rememberMe"),
      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: const Color(0xFF595959)),
      softWrap: true,
    );

    final forgotText = Text(
      context.tr("auth.login.forgotPassword"),
      textAlign: TextAlign.right,
      softWrap: true,
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
            decorationThickness: 1,
            decoration: TextDecoration.underline,
            decorationColor: AppColors.primary,
            color: AppColors.primary,
            fontWeight: FontWeight.w400,
          ),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: remember,
          activeColor: AppColors.primary,
          side: BorderSide(color: AppColors.primary),
          onChanged: press,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: rememberLabel,
          ),
        ),
        const SizedBox(width: 12),
        Flexible(child: Padding(padding: const EdgeInsets.only(top: 12.0), child: forgotText)),
      ],
    );
  }
}
