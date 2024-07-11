import 'package:ct_social/core/extension/theme_getter_extension.dart';
import 'package:ct_social/core/mixin/navigator_manager.dart';
import 'package:ct_social/core/widget/custom_divider.dart';
import 'package:ct_social/feature/cubit/user/user_model_cubit.dart';
import 'package:ct_social/feature/model/user_model.dart';
import 'package:ct_social/feature/view/feed/feed_view_inherited.dart';
import 'package:ct_social/feature/view/login/login_view_inherited.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class LoginView extends StatelessWidget with NavigatorManager {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final currentState = LoginViewInherited.of(context);
    return BlocProvider.value(
      value: BlocProvider.of<UserModelCubit>(context),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Form(
            onChanged: () {
              currentState.formKey.currentState?.validate();
            },
            key: currentState.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Center(
                    child: Column(
                      children: [
                        Text('Hello Again!', style: context.theme.textTheme.headlineLarge),
                        Text('Sign in to your account', style: context.theme.textTheme.headlineSmall),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.h),
                  TextFormField(
                    controller: currentState.emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
                    ],
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Username or Email',
                    ),
                  ),
                  SizedBox(height: 2.h),
                  TextFormField(
                    controller: currentState.passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  TextButton(onPressed: () {}, child: const Text('Forgot Your Password?')),
                  SizedBox(height: 2.h),
                  ElevatedButton(
                    onPressed: () {
                      if (currentState.formKey.currentState?.validate() ?? false) {
                        context.read<UserModelCubit>().setUser(
                              UserModel(
                                id: 1,
                                name: currentState.emailController.text,
                                email: currentState.emailController.text,
                                password: currentState.passwordController.text,
                              ),
                            );
                        return navigateToPageReplaced(context, const FeedViewProvider());
                      }
                    },
                    child: const Text('Login', style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomDivider.horizontal(width: 30.w),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.0.w),
                        child: const Text('OR'),
                      ),
                      CustomDivider.horizontal(width: 30.w),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  OutlinedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.g_mobiledata_outlined),
                        Text(
                          'Sign in with Google',
                          style: context.theme.textTheme.bodyMedium?.copyWith(color: Colors.green.shade900),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? Lets"),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
