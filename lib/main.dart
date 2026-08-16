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
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final List<Map<String, String>> _dailyTransactions = [];
  final List<Map<String, String>> _weeklyTransactions = [];
  final List<Map<String, String>> _monthlyTransactions = [];
  DateTime _selectedDate = DateTime.now();

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  void _addTransaction(List<Map<String, String>> list) {
    if (_descController.text.isNotEmpty && _amountController.text.isNotEmpty) {
      setState(() {
        list.add({
          "desc": _descController.text,
          "amount": _amountController.text,
          "date": "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}"
        });
        _descController.clear();
        _amountController.clear();
      });
    }
  }

  void _showDeleteDialog(BuildContext context, List<Map<String, String>> list, int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("ডিলিট করতে চান?"),
        content: const Text("আপনি কি নিশ্চিত যে এই হিসাবটি মুছে ফেলতে চান?"),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text("না")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() => list.removeAt(index));
              Navigator.of(ctx).pop();
            },
            child: const Text("হ্যাঁ"),
          ),
        ],
      ),
    );
  }

  // সুন্দর হোম পেজ কার্ড ডিজাইন
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
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }

  Widget _buildTransactionPage(List<Map<String, String>> list, Color btnColor) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          TextField(controller: _descController, decoration: const InputDecoration(labelText: "বিবরণ", border: OutlineInputBorder())),
          const SizedBox(height: 10),
          TextField(controller: _amountController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "টাকা", border: OutlineInputBorder())),
          const SizedBox(height: 10),
          ListTile(
            title: Text("তারিখ: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}"),
            trailing: const Icon(Icons.calendar_today),
            onTap: () => _pickDate(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: btnColor),
            onPressed: () => _addTransaction(list),
            child: const Text("সেভ করুন"),
          ),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final item = list[index];
              return Card(
                child: ListTile(
                  title: Text(item['desc']!),
                  subtitle: Text("তারিখ: ${item['date']}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("৳ ${item['amount']}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.greenAccent)),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _showDeleteDialog(context, list, index),
                      ),
                    ],
                  ),
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
      body: _currentIndex == 0 ? _buildHome() : _buildTransactionPage(
        _currentIndex == 1 ? _dailyTransactions : (_currentIndex == 2 ? _weeklyTransactions : _monthlyTransactions),
        _currentIndex == 1 ? Colors.indigo : (_currentIndex == 2 ? Colors.teal : Colors.deepPurple)
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.cyanAccent,
        unselectedItemColor: Colors.white60,
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
