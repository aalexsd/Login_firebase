import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:CapybaApp/Screens/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:CapybaApp/Screens/home_screen2.dart';
import 'Utils/utils.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const appBarTheme = AppBarTheme(
    elevation: 0,
    backgroundColor: Color(0xFFEEEFF5),
    titleTextStyle: TextStyle(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
    actionsIconTheme: IconThemeData(color: Colors.black),
    iconTheme: IconThemeData(color: Colors.black),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Capyba App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: appBarTheme,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //method sets up a stream that listens to changes in the user authentication state and displays the appropriate screen depending on the current state of the stream.
      body: StreamBuilder<User?>(
        stream:
            FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Algo deu errado'),
            );
          } else if (snapshot.hasData) {
            return const HomeScreen2();
          }
          return const AuthScreen();
        },
      ),
    );
  }
}
