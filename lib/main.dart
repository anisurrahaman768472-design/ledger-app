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

  final List<Widget> _pages = [
    const Center(child: Text("হোম পেজ", style: TextStyle(color: Colors.white))),
    const Placeholder(),
    const Center(child: Text("মাসিক হিসাব", style: TextStyle(color: Colors.white))),
    const Center(child: Text("বাৎসরিক হিসাব", style: TextStyle(color: Colors.white))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text("আমার খাতা - Anisur Rahman"),
        backgroundColor: Colors.indigo.shade900,
      ),
      body: _currentIndex == 1 
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: "বিবরণ", labelStyle: TextStyle(color: Colors.white70)),
                  ),
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: "টাকার পরিমাণ", labelStyle: TextStyle(color: Colors.white70)),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(onPressed: _addTransaction, child: const Text("সেভ করুন")),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _dailyTransactions.length,
                      itemBuilder: (context, index) => Card(
                        child: ListTile(
                          title: Text(_dailyTransactions[index]["title"]!),
                          trailing: Text("৳ ${_dailyTransactions[index]["amount"]!}"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : _pages[_currentIndex],
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
