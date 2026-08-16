import 'package:flutter/material.dart';

void main() {
  runApp(const MyKhataApp());
}

class MyKhataApp extends StatelessWidget {
  const MyKhataApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Amar Khata')),
      body: _currentIndex == 0 ? _buildHome() : const Center(child: Text('Ledger Page')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('Plus button pressed'),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
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
        const Card(child: ListTile(title: Text('Total Balance'), subtitle: Text('\$ 0.00'))),
        const SizedBox(height: 20),
        InkWell(
          onTap: () => print('Daily Ledger clicked'),
          child: const Card(child: ListTile(title: Text('Daily Ledger'), trailing: Icon(Icons.arrow_forward))),
        ),
        InkWell(
          onTap: () => print('Weekly Ledger clicked'),
          child: const Card(child: ListTile(title: Text('Weekly Ledger'), trailing: Icon(Icons.arrow_forward))),
        ),
      ],
    );
  }
}
