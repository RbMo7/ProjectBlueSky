import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:projectbluesky/challenges/challenges.dart';
import 'package:projectbluesky/firebase_options.dart';
import 'package:projectbluesky/forum/forum.dart';
import 'package:projectbluesky/home/home.dart';
import 'package:projectbluesky/signIn/auth_gate.dart';
import 'package:projectbluesky/signIn/signin.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  
  runApp(MaterialApp(initialRoute: '/', routes: {
    '/': (context) => const MyApp(),
    '/home': (context) => const Home(),
    '/challenges': (context) => const Challenges(),
    '/forum': (context) => const Forum(),
    '/signIn': (context) => AuthGate()
  }));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 1;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [Challenges(), Home(), Forum()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
         
          if (snapshot.hasData && snapshot.data != null) {
            
            return Scaffold(
            appBar: AppBar(
              title: Text(
                "PROJECT BLUE SKY",
                style: GoogleFonts.poppins(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600),
              ),
              centerTitle: true,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: RadialGradient(
                        radius: 10, colors: [Colors.white, Colors.blue])),
              ),
            ),
            body: _pages[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _navigateBottomBar,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Iconsax.cloud), label: 'Challenges'),
                BottomNavigationBarItem(
                    icon: Icon(Iconsax.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Iconsax.support), label: 'Forum')
              ],
            ));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          else{
            return AuthGate();
          }
        },
      ),
    );
  }
}
