import 'package:flutter/material.dart';

void main() => runApp(const MyKhataApp());

class MyKhataApp extends StatefulWidget {
  const MyKhataApp({super.key});

  @override
  State<MyKhataApp> createState() => _MyKhataAppState();
}

class _MyKhataAppState extends State<MyKhataApp> {
  ThemeMode _themeMode = ThemeMode.dark; // ডার্ক মোড ডিফল্ট
  Locale _locale = const Locale('en'); // ডিফল্ট ভাষা ইংরেজি

  void toggleTheme() => setState(() => _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
  void changeLanguage(String lang) => setState(() => _locale = Locale(lang));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      locale: _locale,
      home: MainScreen(toggleTheme: toggleTheme, changeLanguage: changeLanguage),
    );
  }
}

class MainScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final Function(String) changeLanguage;
  const MainScreen({super.key, required this.toggleTheme, required this.changeLanguage});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double totalBalance = 0.0; // আপনার ব্যালেন্স ভেরিয়েবল

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home - Main Menu'),
        actions: [
          IconButton(on: widget.toggleTheme, icon: const Icon(Icons.brightness_6)),
          PopupMenuButton(
            onSelected: widget.changeLanguage,
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'en', child: Text('English')),
              const PopupMenuItem(value: 'bn', child: Text('বাংলা')),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ব্যালেন্স কার্ড
          Card(
            color: Colors.teal.shade900,
            child: ListTile(
              title: const Text('Total Balance', style: TextStyle(color: Colors.white)),
              subtitle: Text('\$ ${totalBalance.toStringAsFixed(2)}', 
                  style: const TextStyle(fontSize: 24, color: Colors.white)),
              trailing: const Icon(Icons.account_balance_wallet, color: Colors.white),
            ),
          ),
          // অন্যান্য বাটনগুলো...
        ],
      ),
    );
  }
}
