import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:login_screen/Screens/forgot_password.dart';
import '../Utils/utils.dart';
import '../main.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginScreen({Key? key, required this.onClickedSignUp})
      : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    return Scaffold(
        backgroundColor: const Color(0xFFEEEFF5),
        appBar: AppBar(
          backgroundColor: const Color(0xFFEEEFF5),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFEEEFF5),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 100.0),
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0,
                        right: 20,
                        bottom: 30),
                        child: Text(
                          'Seja Bem-Vindo',
                          style: TextStyle(
                            fontSize: 45.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 30),
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
                        padding:
                            const EdgeInsets.only(top: 20, left: 10, right: 30),
                        child: TextFormField(
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
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              signIn();
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
                              'Entrar',
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: GestureDetector(
                          child: const Text('Esqueceu sua senha?',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                            fontSize: 18
                          ),
                          ),
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ForgotPasswordScreen(), )
                            );
                          },
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: RichText(
                            text: TextSpan(
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                                text: 'Não possui uma conta? ',
                                children: [
                                  TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = widget.onClickedSignUp,
                                      text: 'Registre-se',
                                      style: const TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.blueAccent))
                                ]),
                          )),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
