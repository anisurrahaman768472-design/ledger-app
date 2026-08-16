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
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1; // দৈনিক ট্যাব ডিফল্ট

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final List<Map<String, String>> _transactions = [];

  final List<String> _titles = ["হোম", "দৈনিক হিসাব", "মাসিক হিসাব", "বাৎসরিক হিসাব"];

  void _addTransaction() {
    if (_titleController.text.isNotEmpty && _amountController.text.isNotEmpty) {
      setState(() {
        _transactions.add({
          "title": _titleController.text,
          "amount": _amountController.text,
        });
        _titleController.clear();
        _amountController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]), // ট্যাব অনুযায়ী টাইটেল পরিবর্তন হবে
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const Center(child: Text("হোম পেজ")),
          _buildDailyPage(),
          const Center(child: Text("মাসিক হিসাব")),
          const Center(child: Text("বাৎসরিক হিসাব")),
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
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: "মাসিক"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "বাৎসরিক"),
        ],
      ),
    );
  }

  Widget _buildDailyPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(controller: _titleController, decoration: const InputDecoration(labelText: "বিবরণ")),
          TextField(controller: _amountController, decoration: const InputDecoration(labelText: "টাকা"), keyboardType: TextInputType.number),
          const SizedBox(height: 10),
          ElevatedButton(onPressed: _addTransaction, child: const Text("সেভ")),
          Expanded(
            child: ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (ctx, i) => Card(child: ListTile(title: Text(_transactions[i]['title']!), trailing: Text("${_transactions[i]['amount']} টাকা"))),
            ),
          )
        ],
      ),
    );
  }
}
