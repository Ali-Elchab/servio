import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phone_form_field/phone_form_field.dart';
import '/core/constants/app_assets.dart';
import '/core/router/app_router_paths.dart';
import '/core/theme/app_colors.dart';
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
        appBar: AppBar(),
        resizeToAvoidBottomInset: true,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 12),
                Center(child: Image.asset(AppAssets.logoNoBg, width: 110)),
                const SizedBox(height: 20),
                Text(
                  context.tr('auth.login.title'),
                  style: AppText.displaySmall(context).copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 26),

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
                      Tab(text: context.tr('auth.login.emailTab')),
                      Tab(text: context.tr('auth.login.phoneTab')),
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
                  _RoundedInput(
                    controller: emailController,
                    hintText: context.tr('fields.email'),
                    validator: _emailValidator,
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
                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.secondary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: isLoading ? null : _onLoginPressed,
                    child: isLoading
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                          )
                        : Text(
                            context.tr('auth.buttons.login'),
                            style:
                                AppText.titleMedium(context).copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                          ),
                  ),
                ),
                const SizedBox(height: 28),

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
                    _SocialIcon(label: 'G'),
                    SizedBox(width: 18),
                    _SocialIcon(icon: Icons.apple),
                  ],
                ),
                const SizedBox(height: 22),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",
                        style: AppText.bodyMedium(context).copyWith(color: Colors.grey[700])),
                    TextButton(
                      onPressed: () => context.go(RouterPaths.register),
                      child: Text(
                        context.tr('auth.buttons.signUp'),
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

class _SocialIcon extends StatelessWidget {
  const _SocialIcon({this.icon, this.label});

  final IconData? icon;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final border = RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));
    return Material(
      shape: border,
      elevation: 1,
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: icon != null
              ? Icon(icon, size: 26, color: Colors.black)
              : Text(label ?? '',
                  style: AppText.titleMedium(context).copyWith(fontWeight: FontWeight.w700, color: Colors.red)),
        ),
      ),
    );
  }
}
