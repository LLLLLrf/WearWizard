import 'package:animated_login/animated_login.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'dialog_builders.dart';
import 'login_functions.dart';

class LoginPage extends StatelessWidget {
  /// Main app widget.
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Login',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 242, 243, 248),
        colorScheme: const ColorScheme.light(
            primary: Color.fromARGB(255, 148, 169, 255)),
        // useMaterial3: true,
        textTheme: Theme.of(context)
            .textTheme
            .apply(decorationColor: Color.fromARGB(255, 148, 169, 255)),
        inputDecorationTheme: const InputDecorationTheme(
          prefixIconColor: Colors.black54,
          suffixIconColor: Colors.black54,
          iconColor: Colors.black54,
          labelStyle: TextStyle(color: Colors.black54),
          hintStyle: TextStyle(color: Colors.black54),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (BuildContext context) => const LoginScreen(),
        '/forgotPass': (BuildContext context) => const ForgotPasswordScreen(),
      },
    );
  }
}

/// Example login screen
class LoginScreen extends StatefulWidget {
  /// with the help of [LoginTexts] class.
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// Current auth mode, default is [AuthMode.login].
  AuthMode currentMode = AuthMode.login;

  CancelableOperation? _operation;

  @override
  Widget build(BuildContext context) {
    return AnimatedLogin(
      onLogin: (LoginData data) async =>
          _authOperation(LoginFunctions(context).onLogin(data)),
      onSignup: (SignUpData data) async =>
          _authOperation(LoginFunctions(context).onSignup(data)),
      onForgotPassword: _onForgotPassword,
      logo: Image.asset('assets/closet/loginimg.png', fit: BoxFit.contain),
      signUpMode: SignUpModes.both,
      loginMobileTheme: _mobileTheme,
      loginTexts: _loginTexts,
      emailValidator:
          ValidatorModel(validatorCallback: (String? email) => '未找到此用户'),
      initialMode: currentMode,
      onAuthModeChange: (AuthMode newMode) async {
        currentMode = newMode;
        await _operation?.cancel();
      },
    );
  }

  Future<String?> _authOperation(Future<String?> func) async {
    await _operation?.cancel();
    _operation = CancelableOperation.fromFuture(func);
    final String? res = await _operation?.valueOrCancellation();
    if (_operation?.isCompleted == true) {
      DialogBuilder(context).showResultDialog(res ?? '成功.');
    }
    return res;
  }

  Future<String?> _onForgotPassword(String email) async {
    await _operation?.cancel();
    return await LoginFunctions(context).onForgotPassword(email);
  }

  /// You can adjust the colors, text styles, button styles, borders
  /// according to your design preferences for *MOBILE* view.
  /// You can also set some additional display options such as [showLabelTexts].
  LoginViewTheme get _mobileTheme => LoginViewTheme(
        // showLabelTexts: false,
        backgroundColor: Color.fromARGB(255, 148, 169, 255),
        formFieldBackgroundColor: Colors.white,
        logoSize: Size(MediaQuery.of(context).size.width * 0.5,
            MediaQuery.of(context).size.height * 0.3),
        formWidthRatio: 60,
        actionButtonStyle: ButtonStyle(
          foregroundColor:
              MaterialStateProperty.all(Color.fromARGB(255, 148, 169, 255)),
          textStyle: MaterialStateProperty.all(const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 148, 169, 255))),
        ),
        changeActionButtonStyle: ButtonStyle(
          textStyle: MaterialStateProperty.all(const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 148, 169, 255))),
        ),
        animatedComponentOrder: const <AnimatedComponent>[
          AnimatedComponent(
            component: LoginComponents.logo,
            animationType: AnimationType.right,
          ),
          AnimatedComponent(component: LoginComponents.title),
          AnimatedComponent(component: LoginComponents.description),
          AnimatedComponent(component: LoginComponents.formTitle),
          AnimatedComponent(component: LoginComponents.useEmail),
          AnimatedComponent(component: LoginComponents.form),
          AnimatedComponent(component: LoginComponents.notHaveAnAccount),
          AnimatedComponent(component: LoginComponents.forgotPassword),
          AnimatedComponent(component: LoginComponents.changeActionButton),
          AnimatedComponent(component: LoginComponents.actionButton),
        ],
        textFormStyle:
            TextStyle(color: Color.fromARGB(255, 39, 39, 39), fontSize: 15),
        welcomeTitleStyle:
            TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 40),
        welcomeDescriptionStyle:
            TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
        forgotPasswordStyle: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            decorationColor: Color.fromARGB(255, 255, 255, 255)),
      );

  LoginTexts get _loginTexts => LoginTexts(
        nameHint: "Name",
        login: "登录",
        signUp: "注册",
        forgotPassword: "忘记密码?",
        welcome: "WearWizard",
        welcomeDescription: "您的服装搭配助手",
        welcomeBack: "WearWizard",
        welcomeBackDescription: "您的服装搭配助手",
        alreadyHaveAnAccount: "已有账号?",
        notHaveAnAccount: "没有账号?",
        passwordMatchingError: "密码不匹配",
      );
}

/// Example forgot password screen
class ForgotPasswordScreen extends StatelessWidget {
  /// Example forgot password screen that user is navigated to
  /// after clicked on "Forgot Password?" text.
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('忘记密码'),
      ),
    );
  }
}
