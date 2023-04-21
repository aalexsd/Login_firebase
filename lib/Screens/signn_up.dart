import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Utils/utils.dart';
import '../main.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback onClickedSignIn;

  const SignUpScreen({Key? key, required this.onClickedSignIn})
      : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: const Color(0xFFEEEFF5),
        appBar: AppBar(
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 40.0, left: 10),
                child: Text(
                  'Registre-se',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, top: 20),
                child: Text(
                  'Crie sua conta.',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 10, right: 30),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                  email != null && !EmailValidator.validate(email)
                      ? 'Entre com um Email válido'
                      : null,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                        BorderSide(width: 0.2, color: Colors.black87),
                      ),
                      prefixIcon: Icon(Icons.mail),
                      hintText: 'Digite seu Email',
                      labelText: 'Email'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 10, right: 30),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value != null && value.length < 6
                      ? 'Senha com mínimo 6 caracteres'
                      : null,
                  controller: passwordController,
                  decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                        BorderSide(width: 0.2, color: Colors.black87),
                      ),
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Digite sua Senha',
                      labelText: 'Senha'),
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      signUp();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.black87),
                      shape: MaterialStateProperty
                          .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: const BorderSide(color: Colors.black87))),
                    ),
                    child: const Text(
                      'Criar Conta',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: RichText(
                    text: TextSpan(
                        style: const TextStyle(
                            color: Colors.black, fontSize: 20),
                        text: 'Já possui uma conta? ',
                        children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = widget.onClickedSignIn,
                              text: 'Entre',
                              style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blueAccent))
                        ]),
                  )),
            ],
          ),
        ),
      ),
    );
  }
  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
