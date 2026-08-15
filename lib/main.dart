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

  void _showProfileDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade900,
          title: const Text(
            "প্রোফাইল বিবরণ",
            style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "নাম: Anisur rahman",
                style: TextStyle(color: Colors.amberAccent, fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                "ফোন: +97431027647",
                style: TextStyle(color: Colors.lightGreenAccent, fontSize: 16),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("বন্ধ করুন", style: TextStyle(color: Colors.pinkAccent)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade800,
        title: const Text(
          "আমার খাতা",
          style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold),
        ),
        actions: [
          InkWell(
            onTap: () => _showProfileDetails(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: const [
                  CircleAvatar(
                    backgroundColor: Colors.amberAccent,
                    radius: 16,
                    child: Icon(Icons.person, size: 18, color: Colors.black87),
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Anisur rahman",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.amberAccent,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "ফাইল সিলেক্ট করুন:",
              style: TextStyle(
                fontSize: 16,
                color: Colors.orangeAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Card(
              color: Colors.grey.shade900,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.folder, color: Colors.amberAccent, size: 36),
                title: const Text(
                  "মেস খরচ",
                  style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  "মোট এন্ট্রি: ০",
                  style: TextStyle(color: Colors.lightGreenAccent),
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amberAccent,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.black87),
      ),
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
