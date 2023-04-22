import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfileScreen extends StatefulWidget {
  final Function(String) updateDisplayName;

  const EditProfileScreen({Key? key, required this.updateDisplayName})
      : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late String displayName;
  late String email;

  @override
  void initState() {
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser!;
    displayName = currentUser.displayName ?? '';
    nameController = TextEditingController(text: displayName);
    email = currentUser.email ?? '';
    emailController = TextEditingController(text: email);
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFEEEFF5),
        iconTheme: const IconThemeData(color: Colors.black),
        title:
            const Text('Editar Perfil', style: TextStyle(color: Colors.black)),
        actions: [
          TextButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser!;
              if (email != user.email) {
                await user.updateEmail(email);
              }
              if (passwordController.text.isNotEmpty) {
                await user.updatePassword(passwordController.text);
              }
              if (displayName != user.displayName) {
                await user.updateDisplayName(displayName);
                widget.updateDisplayName(displayName);
              }
              Navigator.pop(context);
            },
            child: const Text(
              'Salvar',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Nome Completo',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Digite o seu nome',
              ),
              onChanged: (value) {
                setState(() {
                  displayName = value.trim();
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Email',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Digite o seu email',
              ),
              onChanged: (value) {
                setState(() {
                  email = value.trim();
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Senha',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: 'Digite a nova senha',
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
