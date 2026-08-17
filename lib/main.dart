import 'package:flutter/material.dart';

void main() => runApp(const MyKhataApp());

class MyKhataApp extends StatelessWidget {
  const MyKhataApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0; // এটি সবসময় হোম বাটন দিয়ে শুরু হবে

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Amar Khata')),
      body: _currentIndex == 0 ? _buildHome() : _buildLedger(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('Add clicked'),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Ledger'),
        ],
      ),
    );
  }

  Widget _buildHome() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Card(
          child: ListTile(
            title: Text('Total Balance'),
            subtitle: Text('\$ 0.00'),
          ),
        ),
        const SizedBox(height: 20),
        Card(
          child: ListTile(
            title: const Text('Daily Ledger'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              setState(() => _currentIndex = 1);
            },
          ),
        ),
        Card(
          child: ListTile(
            title: const Text('Weekly Ledger'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              setState(() => _currentIndex = 1);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLedger() {
    return const Center(child: Text('Ledger Page: All transactions here'));
  }
}
