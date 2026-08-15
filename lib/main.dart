import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final List<Map<String, String>> _dailyTransactions = [];

  void _addTransaction() {
    if (_titleController.text.isNotEmpty && _amountController.text.isNotEmpty) {
      setState(() {
        _dailyTransactions.add({
          "title": _titleController.text,
          "amount": _amountController.text,
        });
        _titleController.clear();
        _amountController.clear();
      });
    }
  }

  Widget _buildDailyPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: "বিবরণ (যেমন: বাজার খরচ)",
              labelStyle: TextStyle(color: Colors.white70),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.cyanAccent)),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: "টাকার পরিমাণ",
              labelStyle: TextStyle(color: Colors.white70),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.cyanAccent)),
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton.icon(
            onPressed: _addTransaction,
            icon: const Icon(Icons.save),
            label: const Text("সেভ করুন"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyanAccent,
              foregroundColor: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _dailyTransactions.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.indigo.shade800,
                  child: ListTile(
                    title: Text(
                      _dailyTransactions[index]["title"]!,
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing: Text(
                      "৳ ${_dailyTransactions[index]["amount"]!}",
                      style: const TextStyle(
                        color: Colors.cyanAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget currentBody;
    if (_currentIndex == 0) {
      currentBody = const Center(child: Text("হোম পেজ", style: TextStyle(color: Colors.white, fontSize: 20)));
    } else if (_currentIndex == 1) {
      currentBody = _buildDailyPage();
    } else if (_currentIndex == 2) {
      currentBody = const Center(child: Text("মাসিক হিসাব", style: TextStyle(color: Colors.white, fontSize: 20)));
    } else {
      currentBody = const Center(child: Text("বাৎসরিক হিসাব", style: TextStyle(color: Colors.white, fontSize: 20)));
    }

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text("আমার খাতা - Anisur Rahman"),
        backgroundColor: Colors.indigo.shade900,
      ),
      body: currentBody,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.cyanAccent,
        unselectedItemColor: Colors.white60,
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
