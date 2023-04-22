import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback onClickedSignIn;

  const SignUpScreen({Key? key, required this.onClickedSignIn})
      : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  File? _userImageFile;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  bool isLoading = false;

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
        appBar: AppBar(),
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
                  validator: (value) => value != null && value.isEmpty
                      ? 'Digite seu Nome Completo'
                      : null,
                  controller: nameController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Digite seu Nome',
                      labelText: 'Nome Completo',
                      border: OutlineInputBorder()),
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
                      prefixIcon: Icon(Icons.mail),
                      hintText: 'Digite seu Email',
                      labelText: 'Email',
                      border: OutlineInputBorder()),
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
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Digite sua Senha',
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                ),
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Adicione uma foto para completar seu perfil',
                      style: TextStyle(fontSize: 15,
                      fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final pickedFile = await ImagePicker().pickImage(
                        source: ImageSource.camera, // or ImageSource.gallery,
                        maxWidth: 500,
                      );
                      if (pickedFile != null) {
                        setState(() {
                          _userImageFile = File(pickedFile.path);
                        });
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.black87),
                      shape: MaterialStateProperty.all<CircleBorder>(
                          const CircleBorder(
                              side: BorderSide(color: Colors.black87))),
                    ),
                    child: const Icon(Icons.camera_alt),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
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
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
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
  // sign up method
  Future<void> signUp() async {
    setState(() {
      isLoading = true;
    });

    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    // check if the user attach a photo
    if (_userImageFile == null) {
      Utils.showSnackBar('Adicione uma foto para completar seu perfil');
      setState(() {
        isLoading = false;
      });
      return;
    }
    // check the email and password
    try {
      final authResult =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // storage the photo
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child('${authResult.user!.uid}.jpg'); // Unique filename

      await ref.putFile(_userImageFile!);

      final imageUrl = await ref.getDownloadURL();

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updateDisplayName(nameController.text.trim());
        await user.updatePhotoURL(imageUrl);
      }
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    } finally {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

}
