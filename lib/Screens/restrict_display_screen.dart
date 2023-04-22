import 'package:flutter/material.dart';
import 'package:login_screen/collection/home.dart';

class RestrictDisplayScreen extends StatefulWidget {
  const RestrictDisplayScreen({super.key});

  @override
  State<RestrictDisplayScreen> createState() => _RestrictDisplayScreenState();
}

class _RestrictDisplayScreenState extends State<RestrictDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return const AboutMe();
  }
}
