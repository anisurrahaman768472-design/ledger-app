import 'package:flutter/material.dart';

void main() {
  runApp(const LedgerApp());
}

class LedgerApp extends StatelessWidget {
  const LedgerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notebook Ledger',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const LedgerHomePage(),
    );
  }
}

class LedgerHomePage extends StatefulWidget {
  const LedgerHomePage({super.key});

  @override
  State<LedgerHomePage> createState() => _LedgerHomePageState();
}

class Transaction {
  final String id;
  final String title;
  final double amount;
  final bool isIncome;
  final DateTime date;

  Transaction({required this.id, required this.title, required this.amount, required this.isIncome, required this.date});
}

class _LedgerHomePageState extends State<LedgerHomePage> {
  // এখানে আপনার নাম এবং নাম্বার পরিবর্তন করে দিন
  final String myName = "Anisur rahman"; 
  final String myNumber = "3102764";

  final List<Transaction> _transactions = [];
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  void _addTransaction(bool isIncome) {
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    if (title.isEmpty || amount <= 0) return;
    setState(() {
      _transactions.insert(0, Transaction(id: DateTime.now().toString(), title: title, amount: amount, isIncome: isIncome, date: DateTime.now()));
    });
    _titleController.clear();
    _amountController.clear();
    Navigator.of(context).pop();
  }

  void _deleteTransaction(String id) {
    setState(() { _transactions.removeWhere((tx) => tx.id == id); });
  }

  double get _totalBalance {
    double total = 0.0;
    for (var tx in _transactions) {
      if (tx.isIncome) total += tx.amount;
      else total -= tx.amount;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(title: const Text('Notebook Ledger'), centerTitle: true, backgroundColor: Colors.indigo, foregroundColor: Colors.white,),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const CircleAvatar(radius: 25, backgroundColor: Colors.indigo, child: Icon(Icons.person, color: Colors.white, size: 30)),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(myName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Text(myNumber, style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.indigo, borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  const Text('বর্তমান ব্যালেন্স', style: TextStyle(color: Colors.white70)),
                  Text('৳ ${_totalBalance.toStringAsFixed(2)}', style: const TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(child: ListView.builder(
            itemCount: _transactions.length,
            itemBuilder: (ctx, index) {
              final tx = _transactions[index];
              return Dismissible(
                key: Key(tx.id),
                direction: DismissDirection.endToStart,
                background: Container(color: Colors.red, alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 20), child: const Icon(Icons.delete, color: Colors.white)),
                onDismissed: (_) => _deleteTransaction(tx.id),
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(backgroundColor: tx.isIncome ? Colors.green[100] : Colors.red[100], child: Icon(tx.isIncome ? Icons.arrow_downward : Icons.arrow_upward, color: tx.isIncome ? Colors.green : Colors.red)),
                    title: Text(tx.title),
                    trailing: Text('${tx.isIncome ? '+' : '-'} ৳${tx.amount.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold, color: tx.isIncome ? Colors.green : Colors.red)),
                  ),
                ),
              );
            },
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(context: context, builder: (ctx) => _buildAddSheet()),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildAddSheet() => Padding(
    padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: MediaQuery.of(context).viewInsets.bottom + 20),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'বিবরণ')),
      TextField(controller: _amountController, decoration: const InputDecoration(labelText: 'টাকা'), keyboardType: TextInputType.number),
      const SizedBox(height: 15),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        ElevatedButton(onPressed: () => _addTransaction(false), child: const Text('খরচ')),
        ElevatedButton(onPressed: () => _addTransaction(true), child: const Text('জমা')),
      ])
    ]),
  );
}
