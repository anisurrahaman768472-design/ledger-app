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
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Amar Khata'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          Card(
            child: ListTile(
              title: Text('Total Balance', style: TextStyle(fontSize: 16)),
              subtitle: Text('\$ 0.00', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(height: 15),
          Card(
            child: ListTile(
              leading: Icon(Icons.today, color: Colors.tealAccent),
              title: Text('Daily Ledger'),
              subtitle: Text('Add today\'s expense'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.date_range, color: Colors.tealAccent),
              title: Text('Weekly Ledger'),
              subtitle: Text('View weekly statement'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.tealAccent,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
