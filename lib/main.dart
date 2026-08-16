import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

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

  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amar Khata',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: Colors.tealAccent,
        colorScheme: ColorScheme.dark(
          primary: Colors.tealAccent,
          secondary: Colors.teal,
          surface: const Color(0xFF1E1E1E),
        ),
        useMaterial3: true,
      ),
      locale: _locale,
      supportedLocales: const [
        Locale('en', ''),
        Locale('bn', ''),
      ],
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
  final Function(Locale) onLanguageChanged;
  const MainScreen({super.key, required this.onLanguageChanged});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  List<Map<String, String>> _transactions = [];

  final TextEditingController _descController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadDataFromPrefs();
  }

  Future<void> _loadDataFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
  }

  void _addTransaction() {
    if (_descController.text.isNotEmpty && _amountController.text.isNotEmpty) {
      setState(() {
        _transactions.add({
          'desc': _descController.text,
          'amount': _amountController.text,
          'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        });
        _descController.clear();
        _amountController.clear();
      });
      Navigator.pop(context);
    }
  }

  void _showAddTransactionModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E1E1E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add New Transaction',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.tealAccent),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _descController,
                decoration: const InputDecoration(
                  labelText: 'Description (e.g., Lunch, Salary)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.tealAccent, foregroundColor: Colors.black),
                  onPressed: _addTransaction,
                  child: const Text('Save Transaction', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to My Khata!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.tealAccent),
            ),
            const SizedBox(height: 8),
            const Text(
              'Keep all your accounts safe in one place. Access below:',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF004D40), Color(0xFF00796B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total Balance', style: TextStyle(color: Colors.white70, fontSize: 14)),
                      SizedBox(height: 5),
                      Text('\$ 0.00', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Icon(Icons.account_balance_wallet, size: 40, color: Colors.tealAccent),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildMenuCard('Daily Ledger', 'Add today\'s expense', Icons.today, () {
              setState(() {
                _currentIndex = 1;
              });
            }),
            _buildMenuCard('Weekly Ledger', 'View weekly statement', Icons.date_range, () {
              setState(() {
                _currentIndex = 2;
              });
            }),
            _buildMenuCard('Monthly Ledger', 'Total monthly account', Icons.calendar_month, () {
              setState(() {
                _currentIndex = 3;
              });
            }),
          ],
        ),
      ),
      Center(child: Text('Daily Ledger View (${_transactions.length} items)', style: const TextStyle(fontSize: 18))),
      const Center(child: Text('Weekly Ledger View', style: TextStyle(fontSize: 18))),
      const Center(child: Text('Monthly Ledger View', style: TextStyle(fontSize: 18))),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_currentIndex == 0 ? 'Home - Main Menu' : 'Ledger Details'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'bn') {
                widget.onLanguageChanged(const Locale('bn'));
              } else {
                widget.onLanguageChanged(const Locale('en'));
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(value: 'en', child: Text('English')),
              const PopupMenuItem(value: 'bn', child: Text('বাংলা')),
            ],
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: pages[_currentIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.tealAccent,
        foregroundColor: Colors.black,
        onPressed: _showAddTransactionModal,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF1E1E1E),
        selectedItemColor: Colors.tealAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.today), label: 'Daily'),
          BottomNavigationBarItem(icon: Icon(Icons.date_range), label: 'Weekly'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Monthly'),
        ],
      ),
    );
  }

  Widget _buildMenuCard(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Icon(icon, color: Colors.tealAccent, size: 28),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 13)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
