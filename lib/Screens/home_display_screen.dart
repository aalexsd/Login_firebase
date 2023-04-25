import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:CapybaApp/Screens/verify_email_screen.dart';
import 'package:CapybaApp/widgets/home_display_list_view.dart';
import '../widgets/restricted_display_list_view.dart';

class HomeDisplayScreen extends StatefulWidget {
  const HomeDisplayScreen({Key? key}) : super(key: key);

  @override
  State<HomeDisplayScreen> createState() => _HomeDisplayScreenState();
}

class _HomeDisplayScreenState extends State<HomeDisplayScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int selectedValue = 0;
  int currentIndex = 0;

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
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

@override
void dispose() {
  tabController.dispose();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEFF5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFEEEFF5),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(FontAwesomeIcons.bars),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      //creates a side screen
      drawer: Drawer(
        backgroundColor: const Color(0xFFEEEFF5),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Menu',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(Icons.mail),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Verificar Email'),
                ],
              ),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const VerifyEmailScreen()));

              },
            ),
            GestureDetector(
              onTap: () {
                signOutGoogle().then((value) => Navigator.pop(context));
                FirebaseAuth.instance.signOut();
              },
              child: ListTile(
                title: Row(
                  children: const [
                    Icon(Icons.exit_to_app),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Sair'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(children: [
          // tab bar and tab views
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: TabBar(
              controller: tabController,
              indicatorColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black87,
              indicatorSize: TabBarIndicatorSize.label,
              onTap: (value) {
                setState(() {
                  selectedValue = value;
                });
                tabController.animateTo(value);
              },
              tabs: [
                Container(
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: selectedValue == 0
                        ? Colors.black87
                        : Colors.black87.withOpacity(0.2),
                  ),
                  child: const Text(
                    'Página inicial',
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: selectedValue == 1
                        ? Colors.black87
                        : Colors.black87.withOpacity(0.4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(Icons.lock),
                      Text(
                        'Restrito',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // tab view

          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                // Home tab content
                selectedValue == 0
                // calling AboutUs screen
                    ? const HomeDisplayWidget()
                    : const SizedBox.shrink(),

                // Restricted tab content
                selectedValue == 1
                    ? FutureBuilder<bool>(
                  future: isEmailVerified(),
                  builder: (BuildContext context,
                      AsyncSnapshot<bool> snapshot) {
                    if (snapshot.hasData && snapshot.data!) {
                      return const RestrictedDisplayWidget();
                    } else {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 80,
                          ),
                          const Icon(Icons.email, size: 40),
                          const Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Text(
                                'Para ter acesso a esse conteúdo, por favor verifique seu Email.',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 22)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: ElevatedButton(
                              onPressed: () {
                                sendVerificationEmail();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Email de verificação enviado',
                                    ),
                                  ),
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(
                                    Colors.black87),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(30.0),
                                        side: const BorderSide(
                                            color: Colors.black87))),
                              ),
                              child: const Text(
                                  'Enviar Email de verificação'),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  //method to signout of a google account
  Future<void> signOutGoogle() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logout realizado com sucesso')),
    );
  }
}