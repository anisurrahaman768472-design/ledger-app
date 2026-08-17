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
  int _currentIndex = 0;

  // বাটন এবং কার্ডের ক্লিক হ্যান্ডলার
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

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
        onTap: _onItemTapped,
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
        ListTile(
          tileColor: Colors.grey[200],
          title: const Text('Daily Ledger'),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () => _onItemTapped(1), // Ledger পেজে যাবে
        ),
        const SizedBox(height: 10),
        ListTile(
          tileColor: Colors.grey[200],
          title: const Text('Weekly Ledger'),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () => _onItemTapped(1), // Ledger পেজে যাবে
        ),
      ],
    );
  }

  Widget _buildLedger() {
    return const Center(child: Text('Ledger Page: All transactions will appear here'));
  }
}
