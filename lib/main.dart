import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: AppBarTheme(backgroundColor: Colors.indigo.shade900),
      ),
      home: const AmarKhataApp(),
    );
  }
}

class AmarKhataApp extends StatefulWidget {
  const AmarKhataApp({super.key});

  @override
  State<AmarKhataApp> createState() => _AmarKhataAppState();
}

class _AmarKhataAppState extends State<AmarKhataApp> {
  int _currentIndex = 0;

  final List<String> _titles = ["হোম", "দৈনিক", "সাপ্তাহিক", "মাসিক"];

  // দৈনিক হিসাবের জন্য কন্ট্রোলার ও লিস্ট
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final List<Map<String, String>> _dailyTransactions = [];

  void _addDailyTransaction() {
    if (_descController.text.isNotEmpty && _amountController.text.isNotEmpty) {
      setState(() {
        _dailyTransactions.add({
          "desc": _descController.text,
          "amount": _amountController.text,
        });
        _descController.clear();
        _amountController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHome(),
          _buildDailyPage(),
          _buildPlaceholderPage("সাপ্তাহিক হিসাবের খাতা"),
          _buildPlaceholderPage("মাসিক হিসাবের খাতা"),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.cyanAccent,
        unselectedItemColor: Colors.white60,
        backgroundColor: Colors.black,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "হোম"),
          BottomNavigationBarItem(icon: Icon(Icons.today), label: "দৈনিক"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_view_week), label: "সাপ্তাহিক"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: "মাসিক"),
        ],
      ),
    );
  }

  Widget _buildHome() {
    return const Center(
      child: Text("হোম পেজ - মূল সারসংক্ষেপ", style: TextStyle(fontSize: 20, color: Colors.white)),
    );
  }

  // দৈনিক হিসাবের পাতা
  Widget _buildDailyPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _descController,
            decoration: const InputDecoration(
              labelText: "বিবরণ (যেমন: বাজার খরচ)",
              labelStyle: TextStyle(color: Colors.white70),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "টাকার পরিমাণ",
              labelStyle: TextStyle(color: Colors.white70),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo.shade700),
            onPressed: _addDailyTransaction,
            child: const Text("হিসাব সেভ করুন", style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("আজকের তালিকা:", style: TextStyle(fontSize: 16, color: Colors.cyanAccent, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _dailyTransactions.length,
              itemBuilder: (context, index) {
                final item = _dailyTransactions[index];
                return Card(
                  color: Colors.grey[850],
                  child: ListTile(
                    title: Text(item["desc"]!, style: const TextStyle(color: Colors.white)),
                    trailing: Text("${item["amount"]} টাকা", style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderPage(String title) {
    return Center(
      child: Text(title, style: const TextStyle(fontSize: 20, color: Colors.white)),
    );
  }
}
