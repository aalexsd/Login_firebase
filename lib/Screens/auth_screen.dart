import 'package:flutter/material.dart';
import 'package:login_screen/Screens/login_screen.dart';
import 'package:login_screen/Screens/signn_up.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) =>
      isLogin ? LoginScreen(onClickedSignUp: toggle)
          : SignUpScreen(onClickedSignIn: toggle,);

  void toggle() => setState(() => isLogin = !isLogin);

  }

