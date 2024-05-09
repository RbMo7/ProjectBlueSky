import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:projectbluesky/challenges/challenges.dart';
import 'package:projectbluesky/forum/forum.dart';
import 'package:projectbluesky/home/home.dart';

void main() {
  runApp(MaterialApp(initialRoute: '/', routes: {
    '/': (context) => const MyApp(),
    '/home': (context) => const Home(),
    '/challenges': (context) => const Challenges(),
    '/forum': (context) => const Forum()
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
    // TODO: implement build
    return MaterialApp(
        title: 'Project Blue Sky',
        theme: ThemeData(
            textTheme: TextTheme(bodyMedium: GoogleFonts.montserrat())),
        home: Scaffold(
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
            )));
  }
}
