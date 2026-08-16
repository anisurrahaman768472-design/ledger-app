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
  final List<String> _titles = ["হোম - মেইন মেনু", "দৈনিক হিসাব", "সাপ্তাহিক হিসাব", "মাসিক হিসাব"];

  // দৈনিকের কন্ট্রোলার ও লিস্ট
  final TextEditingController _dailyDescController = TextEditingController();
  final TextEditingController _dailyAmountController = TextEditingController();
  final List<Map<String, String>> _dailyTransactions = [];

  // সাপ্তাহিকের কন্ট্রোলার ও লিস্ট
  final TextEditingController _weeklyDescController = TextEditingController();
  final TextEditingController _weeklyAmountController = TextEditingController();
  final List<Map<String, String>> _weeklyTransactions = [];

  // মাসিকের কন্ট্রোলার ও লিস্ট
  final TextEditingController _monthlyDescController = TextEditingController();
  final TextEditingController _monthlyAmountController = TextEditingController();
  final List<Map<String, String>> _monthlyTransactions = [];

  void _addTransaction(TextEditingController descCtrl, TextEditingController amountCtrl, List<Map<String, String>> list) {
    if (descCtrl.text.isNotEmpty && amountCtrl.text.isNotEmpty) {
      setState(() {
        list.add({"desc": descCtrl.text, "amount": amountCtrl.text});
        descCtrl.clear();
        amountCtrl.clear();
      });
    }
  }

  // হোম পেজ
  Widget _buildHome() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const Text("আমার খাতা - অ্যাপে স্বাগতম!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
          const SizedBox(height: 10),
          const Text("আপনার সকল হিসাব নিকাশ এখন এক জায়গায় নিরাপদে রাখুন।", style: TextStyle(fontSize: 14, color: Colors.white70)),
          const SizedBox(height: 20),
          _buildMenuCard("দৈনিক খাতা", "আজকের খরচ যোগ করুন", Icons.today, Colors.indigo, () => setState(() => _currentIndex = 1)),
          _buildMenuCard("সাপ্তাহিক খাতা", "সাপ্তাহিক হিসাব দেখুন", Icons.date_range, Colors.teal, () => setState(() => _currentIndex = 2)),
          _buildMenuCard("মাসিক খাতা", "মাসের মোট হিসাব", Icons.calendar_month, Colors.deepPurple, () => setState(() => _currentIndex = 3)),
        ],
      ),
    );
  }

  Widget _buildMenuCard(String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      color: color.withOpacity(0.3),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.cyanAccent),
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }

  // হিসাব পেজ (ListView ঠিক করা হয়েছে)
  Widget _buildTransactionPage(TextEditingController descCtrl, TextEditingController amountCtrl, List<Map<String, String>> list, Color btnColor) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          TextField(
            controller: descCtrl,
            decoration: const InputDecoration(labelText: "বিবরণ", border: OutlineInputBorder()),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: amountCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "টাকা", border: OutlineInputBorder()),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: btnColor,
              minimumSize: const Size.fromHeight(45),
            ),
            onPressed: () => _addTransaction(descCtrl, amountCtrl, list),
            child: const Text("সেভ করুন", style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("তালিকা:", style: TextStyle(fontSize: 16, color: Colors.cyanAccent, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final item = list[index];
              return Card(
                color: Colors.grey[850],
                child: ListTile(
                  title: Text(item['desc'] ?? ''),
                  trailing: Text("৳ ${item['amount']}", style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_currentIndex]), centerTitle: true),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHome(),
          _buildTransactionPage(_dailyDescController, _dailyAmountController, _dailyTransactions, Colors.indigo.shade700),
          _buildTransactionPage(_weeklyDescController, _weeklyAmountController, _weeklyTransactions, Colors.teal.shade700),
          _buildTransactionPage(_monthlyDescController, _monthlyAmountController, _monthlyTransactions, Colors.deepPurple.shade700),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.cyanAccent,
        unselectedItemColor: Colors.white60,
        backgroundColor: Colors.black,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "হোম"),
          BottomNavigationBarItem(icon: Icon(Icons.today), label: "দৈনিক"),
          BottomNavigationBarItem(icon: Icon(Icons.date_range), label: "সাপ্তাহিক"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: "মাসিক"),
        ],
      ),
    );
  }
}
