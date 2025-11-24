import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '/core/theme/app_colors.dart';
import '/shared/cubits/locale/locale_cubit.dart';

import '/core/constants/app_assets.dart';
import '/core/router/app_router_paths.dart';
import '/core/theme/app_text.dart';
import '/shared/extensions/context_extensions.dart';
import '/shared/widgets/custom_button.dart';
import '/shared/services/cache_manager.dart';
import '/core/di/locator.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  Future<void> _completeOnboarding(BuildContext context, String path) async {
    await getIt<CacheManager>().setHasSeenOnboarding(true);
    if (!context.mounted) return;
    context.go(path);
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.select((LocaleCubit c) => c.state);
    final isAr = locale.languageCode == "ar";

    final loginText = context.tr('auth.buttons.login');

    final headline = isAr ? "أدر خدمات منزلك في مكان واحد." : "Run your home services in one place.";
    final subline =
        isAr ? "تصفّح مقدمي الخدمة، احتفظ بهم بدون اتصال، وحدث القائمة مع كل تشغيل للتطبيق." : "Browse providers, keep them offline, and refresh the list on every app launch.";

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 520.w),
              child: Column(
                crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          Center(child: Image.asset(AppAssets.logo, height: 180.h)),
                          const SizedBox(height: 50),
                          Text(
                            headline,
                            textAlign: isAr ? TextAlign.end : TextAlign.start,
                            style: AppText.displaySmall(context).copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            subline,
                            textAlign: isAr ? TextAlign.end : TextAlign.start,
                            style: AppText.bodyLarge(context).copyWith(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomButton(
                    text: loginText,
                    onPressed: () => _completeOnboarding(context, RouterPaths.login),
                    isFill: true,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
