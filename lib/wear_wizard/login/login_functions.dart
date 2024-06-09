import 'package:animated_login/animated_login.dart';
import 'package:flutter/material.dart';

import 'dialog_builders.dart';

import 'package:wearwizard/services/user_service.dart';
import 'package:wearwizard/wear_wizard/user/user_page.dart';
import 'package:wearwizard/wear_wizard/login/login_page.dart';
import '../wearwizard_home_screen.dart';

class LoginFunctions {
  /// Collection of functions will be performed on login/signup.
  const LoginFunctions(this.context);
  final BuildContext context;

  Future<String?> onLogin(LoginData data) async {
    try {
      User user = await User().login(data.email, data.password);
      // UserScreen userScreen = UserScreen();
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => userScreen));
      // Navigator.pop(context);
      print(Navigator.canPop(context));
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }else{
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => WearWizardHomeScreen()),
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      return 'Login failed';
    }
    return 'Login successful';
  }

  Future<String?> onSignup(SignUpData data) async {
    try {
      User user = await User()
          .signUp(data.name, data.email, data.password, data.confirmPassword);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
        
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
