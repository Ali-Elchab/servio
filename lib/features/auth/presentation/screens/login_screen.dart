import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invygo/shared/widgets/custom_button.dart';
import 'package:invygo/shared/widgets/custom_text_field.dart';
import 'package:phone_form_field/phone_form_field.dart';
import '/core/constants/app_assets.dart';
import '/core/router/app_router_paths.dart';
import '/core/theme/app_text.dart';
import '/shared/extensions/context_extensions.dart';
import '/shared/widgets/app_page_wrapper.dart';
import '/shared/widgets/phone_number_field.dart';
import '/shared/widgets/snackbar.dart';
import '/features/auth/cubit/auth_cubit.dart';

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
    if (!_formKey.currentState!.validate()) return;
    final identifier = mode == LoginMode.phone ? phoneController.value.international : emailController.text.trim();
    await context.read<AuthCubit>().login(identifier, passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select((AuthCubit c) => c.state is AuthChecking);
    final colors = context.colors;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          showCustomSnackBar(context: context, message: state.error!.message, backgroundColor: Colors.red);
        }
      },
      child: AppPageWrapper(
        topPadding: 0,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextButton(
                onPressed: () => context.go(RouterPaths.home),
                child: Text(
                  context.tr('actions.skip'),
                  style: AppText.titleMedium(context).copyWith(
                    decoration: TextDecoration.underline,
                    color: colors.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
        resizeToAvoidBottomInset: true,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(AppAssets.logo, width: 110.w),
                SizedBox(height: 38.h),
                Text(
                  context.tr('auth.login.title'),
                  style: AppText.headlineMedium(context).copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 24),

                // ---- TAB BAR ----
                Container(
                  height: 42,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TabBar(
                    controller: _tab,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                    ),
                    labelColor: colors.primary,
                    unselectedLabelColor: const Color(0xFF7A7A7A),
                    tabs: [
                      Tab(
                          child: Text(
                        context.tr('fields.email'),
                        style: TextStyle(fontSize: 14),
                      )),
                      Tab(
                          child: Text(
                        context.tr('fields.phoneNumber'),
                        style: TextStyle(fontSize: 14),
                      )),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

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
                    validator: _emailValidator,
                  ),

                const SizedBox(height: 14),

                CustomTextField(
                  controller: passwordController,
                  obscureText: obscureText,
                  hintText: context.tr('fields.password'),
                  isPassword: true,
                  // icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: Colors.grey[500]),
                  validator: (v) => (v == null || v.isEmpty) ? context.tr('validation.passwordRequired') : null,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(foregroundColor: colors.primary),
                    child: Text(
                      context.tr("auth.login.forgotPassword"),
                      style: AppText.bodySmall(context).copyWith(
                        decoration: TextDecoration.underline,
                        color: colors.primary,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32.h),

                CustomButton(
                  text: 'Log In',
                  onPressed: _onLoginPressed,
                  isLoading: isLoading,
                ),
                const SizedBox(height: 70),

                Row(
                  children: [
                    Expanded(child: Divider(color: colors.secondary, thickness: 1)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text('OR', style: AppText.bodyMedium(context).copyWith(color: Colors.grey[700])),
                    ),
                    Expanded(child: Divider(color: colors.secondary, thickness: 1)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    _SocialIcon(
                      svgAsset: 'assets/icons/google_logo.svg',
                    ),
                    _SocialIcon(icon: Icons.apple),
                  ],
                ),
                const SizedBox(height: 22),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",
                        style: AppText.labelMedium(context).copyWith(color: Colors.grey[700])),
                    TextButton(
                      onPressed: () => context.go(RouterPaths.register),
                      child: Text(
                        context.tr('auth.buttons.createAccount'),
                        style: AppText.labelMedium(context).copyWith(
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
    );
  }
}

class _SocialIcon extends StatelessWidget {
  const _SocialIcon({Key? key, this.icon, this.svgAsset}) : super(key: key);

  final IconData? icon;
  final String? svgAsset;

  @override
  Widget build(BuildContext context) {
    if (svgAsset != null) {
      return IconButton(
        onPressed: () {},
        icon: SvgPicture.asset(svgAsset!, width: 26, height: 26),
      );
    }
    return IconButton(
      onPressed: () {},
      icon: Icon(icon, size: 38, color: Colors.black),
    );
  }
}
