import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const LedgerApp());

class LedgerApp extends StatelessWidget {
  const LedgerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.account_balance_wallet, size: 80, color: Colors.amberAccent),
            SizedBox(height: 20),
            Text(
              "Notebook Ledger",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.cyanAccent,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "আপনার হিসাব রাখুন সহজে",
              style: TextStyle(fontSize: 16, color: Colors.orangeAccent),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // প্রতিটি ট্যাবের জন্য আলাদা স্ক্রিন কন্টেন্ট
  final List<Widget> _pages = [
    const Center(child: Text("হোম পেজ", style: TextStyle(color: Colors.white, fontSize: 20))),
    const Center(child: Text("দৈনিক হিসাব", style: TextStyle(color: Colors.white, fontSize: 20))),
    const Center(child: Text("মাসিক হিসাব", style: TextStyle(color: Colors.white, fontSize: 20))),
    const Center(child: Text("বাৎসরিক হিসাব", style: TextStyle(color: Colors.white, fontSize: 20))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text("আমার খাতা"),
        backgroundColor: Colors.indigo.shade900,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.cyanAccent,
        unselectedItemColor: Colors.white60,
        backgroundColor: Colors.black87,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "হোম"),
          BottomNavigationBarItem(icon: Icon(Icons.today), label: "দৈনিক"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: "মাসিক"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "বাৎসরিক"),
        ],
      ),
    );
  }
}
