import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyKhataApp());
}

class MyKhataApp extends StatefulWidget {
  const MyKhataApp({super.key});

  @override
  State<MyKhataApp> createState() => _MyKhataAppState();
}

class _MyKhataAppState extends State<MyKhataApp> {
  Locale _locale = const Locale('en');

  void _changeLanguage(String langCode) {
    setState(() {
      _locale = Locale(langCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: const [Locale('en', ''), Locale('bn', '')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: MainScreen(onLanguageChanged: _changeLanguage),
    );
  }
}

class MainScreen extends StatefulWidget {
  final Function(String) onLanguageChanged;
  const MainScreen({super.key, required this.onLanguageChanged});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  List<String> _transactions = [];
  final TextEditingController _textController = TextEditingController();

  void _addTransaction() async {
    if (_textController.text.isNotEmpty) {
      setState(() {
        _transactions.add(_textController.text);
      });
      _textController.clear();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Amar Khata'),
        actions: [
          PopupMenuButton<String>(
            onSelected: widget.onLanguageChanged,
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'en', child: Text('English')),
              const PopupMenuItem(value: 'bn', child: Text('বাংলা')),
            ],
            icon: const Icon(Icons.language),
          ),
        ],
      ),
      body: _currentIndex == 0 ? _buildHome() : _buildLedger(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.tealAccent,
        onPressed: () => _showModal(context),
        child: const Icon(Icons.add, color: Colors.black),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.tealAccent,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Ledger'),
        ],
      ),
    );
  }

  Widget _buildHome() => ListView(
    padding: const EdgeInsets.all(16),
    children: [
      const Card(child: ListTile(title: Text('Total Balance'), subtitle: Text('\$ 0.00'))),
      const SizedBox(height: 20),
      _menuItem('Daily Ledger', Icons.today, () => setState(() => _currentIndex = 1)),
      _menuItem('Weekly Ledger', Icons.date_range, () => setState(() => _currentIndex = 1)),
    ],
  );

  Widget _buildLedger() => ListView.builder(
    itemCount: _transactions.length,
    itemBuilder: (context, index) => ListTile(title: Text(_transactions[index])),
  );

  Widget _menuItem(String title, IconData icon, VoidCallback onTap) => Card(
    child: ListTile(
      leading: Icon(icon, color: Colors.tealAccent),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward),
      onTap: onTap,
    ),
  );

  void _showModal(BuildContext context) {
    showModalBottomSheet(context: context, builder: (_) => Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        TextField(controller: _textController, decoration: const InputDecoration(labelText: 'Expense')),
        ElevatedButton(onPressed: _addTransaction, child: const Text('Save'))
      ]),
    ));
  }
}
