import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// Check if the current user's email is verified
  Future<bool> isEmailVerified() async {
    User? user = _auth.currentUser;
    await user?.reload();
    return user?.emailVerified ?? false;
  }

  Future<void> sendVerificationEmail() async {
    User? user = _auth.currentUser;
    await user?.sendEmailVerification();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEFF5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEEEFF5),
        title: const Text('Verificar Email'),
      ),
      body: FutureBuilder<bool>(
        future: isEmailVerified(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && snapshot.data!) {
            return Center(
              child: Column(
                children: const [
                  Icon(Icons.check, size: 100),
                  Text('Seu Email já está verificado',
                      style: TextStyle(fontSize: 24)),
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  const Icon(Icons.email, size: 40),
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text('Por favor, verifique seu Email.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        sendVerificationEmail();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Email de verificação enviado',),
                          ),
                        );
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.black87),
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: const BorderSide(color: Colors.black87))),
                      ),
                      child: const Text('Enviar Email de verificação'),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
