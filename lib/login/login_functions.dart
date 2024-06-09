import 'package:animated_login/animated_login.dart';
import 'package:flutter/material.dart';

import 'dialog_builders.dart';

import 'package:wearwizard/services/user_service.dart';

class LoginFunctions {
  /// Collection of functions will be performed on login/signup.
  const LoginFunctions(this.context);
  final BuildContext context;

  Future<String?> onLogin(LoginData data) async {
    try {
      User user = User();
      user = await user.login(data.email, data.password);
      // TODO: process user info to person page
    } catch (e) {
      return 'Login failed';
    }
    return 'Login successful';
  }

  Future<String?> onSignup(SignUpData data) async {
    try {
      User user = await User()
          .signUp(data.name, data.email, data.password, data.confirmPassword);
      // TODO: jump to login page
    } catch (e) {
      return 'Sign up failed';
    }
    return 'Sign up successful';
  }

  /// Action that will be performed on click to "Forgot Password?" text/CTA.
  /// Probably you will navigate user to a page to create a new password after the verification.
  Future<String?> onForgotPassword(String email) async {
    DialogBuilder(context).showLoadingDialog();
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed('/forgotPass');
    return null;
  }
}
