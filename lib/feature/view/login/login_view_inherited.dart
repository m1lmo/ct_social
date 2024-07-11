import 'package:ct_social/core/mixin/navigator_manager.dart';
import 'package:ct_social/feature/view/feed/feed_view_inherited.dart';
import 'package:ct_social/feature/view/login/login_view.dart';
import 'package:flutter/material.dart';

final class LoginViewInherited extends InheritedWidget {
  const LoginViewInherited(this.data, {required super.child, super.key});
  final LoginViewProviderState data;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  static LoginViewProviderState of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<LoginViewInherited>();
    if (result != null) {
      return result.data;
    } else {
      throw Exception('Could not find the inherited widget');
    }
  }
}

class LoginViewProvider extends StatefulWidget {
  const LoginViewProvider({super.key});

  @override
  State<LoginViewProvider> createState() => LoginViewProviderState();
}

class LoginViewProviderState extends State<LoginViewProvider> with NavigatorManager {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    formKey.currentState?.dispose();
  }

  /// This method is used for submit the form
  void submitForm() {
    if (formKey.currentState!.validate()) {
      navigateToPageReplaced(context, const FeedViewProvider());
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoginViewInherited(
      this,
      child: const LoginView(),
    );
  }
}
