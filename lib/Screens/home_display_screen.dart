import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        title: const Text(
          '',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/avatar.png'),
            ),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFFEEEFF5),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('Menu',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),),
            ),
            ListTile(
              title: const Text('Verificar Email'),
              onTap: () {
                Navigator.of(context).pushNamed('about');
              },
            ),
            ListTile(
              title: const Text('Sair'),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          children: [
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
                      'Home',
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
                    child: const Text(
                      'Restricted',
                      textAlign: TextAlign.center,
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
                children: const [],
              ),
            )
          ],
        ),
      ),
    );
  }
}
