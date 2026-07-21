import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rahala/core/router/route_names.dart';

import 'package:rahala/core/constants/app_assets.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.go(RouteNames.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(AppAssets.splashBackground, fit: BoxFit.cover),
          ),

          // Bottom Gradient Overlay for readability
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 300.h,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    AppColors.primaryDark.withValues(alpha: 0.9),
                    AppColors.primaryDark.withValues(alpha: 0.4),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const Spacer(flex: 3),

                  // Glassmorphism Logo
                  Container(
                    width: 96.w,
                    height: 96.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.1),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                        width: 1.w,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.25),
                          blurRadius: 50.r,
                          offset: Offset(0, 25.h),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                        child: Center(
                          child: Container(
                            width: 50.w,
                            height: 50.w,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.surface,
                            ),
                            child: Icon(
                              Icons.explore,
                              size: AppSizes.iconLarge,
                              color: AppColors.primaryDark,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: AppSizes.p16),

                  // App Title
                  Text(
                    AppStrings.splashTitle,
                    style: AppTextStyles.headlineLarge.copyWith(
                      color: Colors.white,
                      letterSpacing: 0.7,
                    ),
                  ),

                  SizedBox(height: AppSizes.p16),

                  // Tagline
                  Text(
                    AppStrings.splashTagline,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),

                  const Spacer(flex: 4),

                  // Loading Indicator Area
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.p24),
                    child: Column(
                      children: [
                        Text(
                          AppStrings.splashLoading,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                        SizedBox(height: AppSizes.p8),
                        Text(
                          AppStrings.splashVerifyingLogin,
                          style: AppTextStyles.labelMedium.copyWith(
                            color: Colors.white.withValues(alpha: 0.6),
                          ),
                        ),
                        SizedBox(height: AppSizes.p24),

                        // Progress Bar Container
                        Container(
                          width: double.infinity,
                          height: 6.h,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(AppSizes.r32),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: AppSizes.p32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
