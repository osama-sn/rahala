import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/di/service_locator.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/router/route_names.dart';
import 'package:rahala/core/shared/widgets/app_button.dart';
import 'package:rahala/core/shared/widgets/app_loading.dart';
import 'package:rahala/core/shared/widgets/app_snackbar.dart';
import 'package:rahala/core/shared/widgets/app_text_field.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';
import 'package:rahala/features/user/auth/presentation/cubit/auth_cubit.dart';
import 'package:rahala/features/user/auth/presentation/cubit/auth_states.dart';
import 'package:rahala/features/user/auth/presentation/widgets/profile_avatar_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  File? _selectedImage;
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => getIt<AuthCubit>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.primary,
            ),
            onPressed: () => context.pop(),
          ),
        ),
        body: SafeArea(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                AppSnackbar.showSuccess(
                  context: context,
                  message: AppStrings.success,
                );
                if (state.user.isAdmin) {
                  context.go(RouteNames.adminDashboard);
                } else {
                  context.go(RouteNames.home);
                }
              } else if (state is AuthFailure) {
                AppSnackbar.showError(
                  context: context,
                  message: state.errorMessage,
                );
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.p24,
                      vertical: AppSizes.p16,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            AppStrings.createAccountTitle,
                            style: AppTextStyles.headlineLarge,
                            textAlign: TextAlign.center,
                          ),
                          AppSizes.p8.verticalSpace,
                          Text(
                            AppStrings.createAccountSubtitle,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          32.h.verticalSpace,
                          ProfileAvatarPicker(
                            onImagePicked: (file) {
                              _selectedImage = file;
                            },
                          ),
                          32.h.verticalSpace,
                          AppTextField(
                            hintText: AppStrings.nameHint,
                            labelText: AppStrings.nameLabel,
                            type: AppTextFieldType.text,
                            controller: _nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "الاسم مطلوب";
                              }
                              return null;
                            },
                          ),
                          AppSizes.p16.verticalSpace,
                          AppTextField(
                            hintText: AppStrings.emailHint,
                            labelText: AppStrings.emailLabel,
                            type: AppTextFieldType.email,
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "البريد الإلكتروني مطلوب";
                              }
                              return null;
                            },
                          ),
                          AppSizes.p16.verticalSpace,
                          AppTextField(
                            hintText: AppStrings.phoneHint,
                            labelText: AppStrings.phoneLabel,
                            type: AppTextFieldType.phone,
                            controller: _phoneController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "رقم الهاتف مطلوب";
                              }
                              return null;
                            },
                          ),
                          AppSizes.p16.verticalSpace,
                          AppTextField(
                            hintText: AppStrings.passwordHint,
                            labelText: AppStrings.passwordLabel,
                            type: AppTextFieldType.password,
                            controller: _passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "كلمة المرور مطلوبة";
                              }
                              return null;
                            },
                          ),
                          AppSizes.p16.verticalSpace,
                          AppTextField(
                            hintText: AppStrings.confirmPasswordHint,
                            labelText: AppStrings.confirmPasswordLabel,
                            type: AppTextFieldType.password,
                            controller: _confirmPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "تأكيد كلمة المرور مطلوب";
                              }
                              if (value != _passwordController.text) {
                                return "كلمة المرور غير متطابقة";
                              }
                              return null;
                            },
                          ),
                          AppSizes.p32.verticalSpace,
                          AppButton(
                            text: AppStrings.register,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthCubit>().register(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                  confirmPassword: _confirmPasswordController
                                      .text
                                      .trim(),
                                  name: _nameController.text.trim(),
                                  phone: _phoneController.text.trim(),
                                  profileImage: _selectedImage,
                                );
                              }
                            },
                          ),
                          AppSizes.p32.verticalSpace,
                          RichText(
                            text: TextSpan(
                              text: AppStrings.alreadyHaveAccount,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                              children: [
                                TextSpan(
                                  text: AppStrings.login,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () =>
                                        context.go(RouteNames.login),
                                ),
                              ],
                            ),
                          ).center(),
                          AppSizes.p32.verticalSpace,
                        ],
                      ),
                    ),
                  ),
                  if (state is AuthLoading) const Center(child: AppLoading()),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
