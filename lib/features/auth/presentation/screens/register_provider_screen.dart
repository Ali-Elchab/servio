import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '/shared/extensions/context_extensions.dart';
import 'package:phone_form_field/phone_form_field.dart';
import '/core/constants/app_assets.dart';
import '/core/router/app_router_paths.dart';
import '/core/theme/app_text.dart';
import '/features/auth/cubit/auth_cubit.dart';
import '/shared/widgets/app_page_wrapper.dart';
import '/shared/widgets/phone_number_field.dart';
import '/shared/widgets/snackbar.dart';
import '/features/providers/data/repositories/providers_repository.dart';
import '/core/di/locator.dart';

class RegisterProviderScreen extends StatefulWidget {
  const RegisterProviderScreen({super.key});

  @override
  State<RegisterProviderScreen> createState() => _RegisterProviderScreenState();
}

class _RegisterProviderScreenState extends State<RegisterProviderScreen> {
  final _pageController = PageController();
  int _step = 0;

  final _personalFormKey = GlobalKey<FormState>();
  final _portfolioFormKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = PhoneController();
  final passwordController = TextEditingController();

  bool obscureText = true;
  bool portfolioAttached = false;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    phoneController.value = const PhoneNumber(isoCode: IsoCode.LB, nsn: '');
  }

  @override
  void dispose() {
    _pageController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() => setState(() => obscureText = !obscureText);

  void _nextStep() {
    if (_step == 0) {
      if (!(_personalFormKey.currentState?.validate() ?? false)) return;
    }
    setState(() => _step = (_step + 1).clamp(0, 1));
    _pageController.animateToPage(
      _step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _submit() async {
    if (!(_portfolioFormKey.currentState?.validate() ?? false)) return;
    setState(() => isSubmitting = true);
    final repo = getIt<ProvidersRepository>();

    try {
      await repo.registerProvider(
        payload: {
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'phone': phoneController.value.international,
          'password': passwordController.text,
          'business_name': nameController.text.trim(),
          'whatsapp': phoneController.value.international,
        },
      );

      if (!mounted) return;
      showCustomSnackBar(
        context: context,
        message: 'Submitted provider onboarding.',
        backgroundColor: Colors.green,
      );
      context.go(RouterPaths.login);
    } catch (e) {
      if (!mounted) return;
      showCustomSnackBar(
        context: context,
        message: e.toString(),
        backgroundColor: Colors.red,
      );
    } finally {
      if (mounted) setState(() => isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isLoading = context.select((AuthCubit c) => c.state is AuthChecking);

    return AppPageWrapper(
      appBar: AppBar(),
      resizeToAvoidBottomInset: true,
      child: Column(
        children: [
          const SizedBox(height: 12),
          Image.asset(AppAssets.logoNoBg, width: 110),
          const SizedBox(height: 18),
          Text(
            'More about you',
            style: AppText.displaySmall(context).copyWith(
              color: colors.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 18),
          _StepHeader(step: _step),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _PersonalDetailsStep(
                  formKey: _personalFormKey,
                  nameController: nameController,
                  emailController: emailController,
                  phoneController: phoneController,
                  passwordController: passwordController,
                  obscureText: obscureText,
                  onTogglePassword: _togglePasswordVisibility,
                ),
                _PortfolioStep(
                  formKey: _portfolioFormKey,
                  attached: portfolioAttached,
                  onAttach: () => setState(() => portfolioAttached = true),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isLoading
                  ? null
                  : (_step == 0
                      ? _nextStep
                      : isSubmitting
                          ? null
                          : _submit),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.secondary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: isLoading || isSubmitting
                  ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                    )
                  : Text(
                      _step == 0 ? 'Next' : 'Done',
                      style: AppText.titleMedium(context).copyWith(fontWeight: FontWeight.w700, color: Colors.white),
                    ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _StepHeader extends StatelessWidget {
  const _StepHeader({required this.step});
  final int step;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    const total = 3;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            step == 0 ? 'Add your personal details' : 'Add your portfolio',
            style: AppText.bodyLarge(context).copyWith(color: colors.primary, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(total, (i) {
              final active = i <= step;
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: i == total - 1 ? 0 : 8),
                  height: 3,
                  decoration: BoxDecoration(
                    color: active ? colors.secondary : colors.secondary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _PersonalDetailsStep extends StatelessWidget {
  const _PersonalDetailsStep({
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.obscureText,
    required this.onTogglePassword,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final PhoneController phoneController;
  final TextEditingController passwordController;
  final bool obscureText;
  final VoidCallback onTogglePassword;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            _RoundedInput(
              controller: nameController,
              hintText: 'Full name',
              validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 14),
            _RoundedInput(
              controller: emailController,
              hintText: 'Email',
              validator: (v) {
                if (v == null || v.isEmpty) return 'Required';
                final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v);
                return ok ? null : 'Enter a valid email';
              },
            ),
            const SizedBox(height: 14),
            PhoneNumberField(controller: phoneController),
            const SizedBox(height: 14),
            _RoundedInput(
              controller: passwordController,
              hintText: 'Password',
              obscureText: obscureText,
              suffix: IconButton(
                icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: Colors.grey[500]),
                onPressed: onTogglePassword,
              ),
              validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _PortfolioStep extends StatelessWidget {
  const _PortfolioStep({
    required this.formKey,
    required this.attached,
    required this.onAttach,
  });

  final GlobalKey<FormState> formKey;
  final bool attached;
  final VoidCallback onAttach;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colors.secondary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Icon(Icons.cloud_upload, size: 72, color: colors.secondary),
                  const SizedBox(height: 12),
                  Text(
                    'Upload Files/ Images',
                    style: AppText.titleMedium(context).copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Browse and choose the files you want to upload.',
                    textAlign: TextAlign.center,
                    style: AppText.bodyMedium(context).copyWith(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 14),
                  ElevatedButton(
                    onPressed: onAttach,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.secondary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(attached ? 'Files Attached' : 'Browse'),
                  ),
                ],
              ),
            ),
          ],
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
