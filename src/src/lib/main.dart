import 'package:biotech_assesment/screens/home.dart';
import 'package:biotech_assesment/screens/about.dart';
import 'package:biotech_assesment/screens/contact.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int bigScreen = 0; // Keep track of the selected screen

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Row(
            children: [
              Container(
                width: screenWidth * 0.15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'images/MASSIVE-BIOINFORMATICS-LOGO-VEKTO_REL-beyaz.png',
                      width: screenWidth * 0.1,
                    ),
                    GestureDetector(
                      onTap: () => setState(
                          () => bigScreen = 0), // Navigate to HomeScreen
                      child: const ListTile(
                        title: Text('Home'),
                        leading: Icon(Icons.home),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(
                          () => bigScreen = 1), // Navigate to AboutScreen
                      child: const ListTile(
                        title: Text('About'),
                        leading: Icon(Icons.info),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(
                          () => bigScreen = 2), // Navigate to ContactScreen
                      child: const ListTile(
                        title: Text('Contact'),
                        leading: Icon(Icons.contact_mail),
                      ),
                    ),
                    const Spacer(),
                    const ListTile(
                      title: Text('Logout'),
                      leading: Icon(Icons.logout),
                    ),
                  ],
                ),
              ),
              Container(
                width: screenWidth * 0.85,
                color: Colors.blue,
                child: IndexedStack(
                  // Use IndexedStack for screen switching
                  index: bigScreen,
                  children: const [
                    HomeScreen(),
                    AboutScreen(),
                    ContactScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
