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

  // কন্ট্রোলার এবং লিস্ট - দৈনিক
  final TextEditingController _dailyDescController = TextEditingController();
  final TextEditingController _dailyAmountController = TextEditingController();
  final List<Map<String, String>> _dailyTransactions = [];

  // কন্ট্রোলার এবং লিস্ট - সাপ্তাহিক
  final TextEditingController _weeklyDescController = TextEditingController();
  final TextEditingController _weeklyAmountController = TextEditingController();
  final List<Map<String, String>> _weeklyTransactions = [];

  // কন্ট্রোলার এবং লিস্ট - মাসিক
  final TextEditingController _monthlyDescController = TextEditingController();
  final TextEditingController _monthlyAmountController = TextEditingController();
  final List<Map<String, String>> _monthlyTransactions = [];

  void _addTransaction(TextEditingController descCtrl, TextEditingController amountCtrl, List<Map<String, String>> list) {
    if (descCtrl.text.isNotEmpty && amountCtrl.text.isNotEmpty) {
      setState(() {
        list.add({
          "desc": descCtrl.text,
          "amount": amountCtrl.text,
        });
        descCtrl.clear();
        amountCtrl.clear();
      });
    }
  }

  // ১. হোম পেজ (মেইন মেনু ও ড্যাশবোর্ড)
  Widget _buildHome() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const Text(
            "আমার খাতা - অ্যাপে স্বাগতম!",
            style: TextStyle(fontSize: 22, fontWeight: theBold = FontWeight.bold, color: Colors.cyanAccent),
          ),
          const SizedBox(height: 10),
          const Text(
            "আপনার সকল হিসাব নিকাশ এখন এক জায়গায় নিরাপদে রাখুন। নিচে থেকে যেকোনো মেনুতে প্রবেশ করুন:",
            style: TextStyle(fontSize: 14, color: Colors.white70),
          ),
          const SizedBox(height: 20),
          
          // শর্টকাট কার্ডসমূহ
          _buildMenuCard(
            title: "দৈনিক খাতা",
            subtitle: "আজকের খরচ ও আয় যোগ করুন",
            icon: Icons.today,
            color: Colors.indigo,
            onTap: () => setState(() => _currentIndex = 1),
          ),
          _buildMenuCard(
            title: "সাপ্তাহিক খাতা",
            subtitle: "সাপ্তাহিক হিসাবের বিবরণ দেখুন",
            icon: Icons.date_range,
            color: Colors.teal,
            onTap: () => setState(() => _currentIndex = 2),
          ),
          _buildMenuCard(
            title: "মাসিক খাতা",
            subtitle: "মাসের মোট হিসাব ও বাজেট",
            icon: Icons.calendar_month,
            color: Colors.deepPurple,
            onTap: () => setState(() => _currentIndex = 3),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard({required String title, required String subtitle, required IconData icon, required Color color, required VoidCallback onTap}) {
    return Card(
      color: color.withOpacity(0.3),
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, size: 36, color: Colors.cyanAccent),
        title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white60)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
        onTap: onTap,
      ),
    );
  }

  // ২. দৈনিক পেজ
  Widget _buildDailyPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _dailyDescController,
            decoration: const InputDecoration(labelText: "বিবরণ (যেমন: বাজার খরচ)", border: OutlineInputBorder()),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _dailyAmountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "টাকার পরিমাণ", border: OutlineInputBorder()),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo.shade700, minimumSize: const Size.fromHeight(45)),
            onPressed: () => _addTransaction(_dailyDescController, _dailyAmountController, _dailyTransactions),
            child: const Text("হিসাব সেভ করুন", style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("আজকের তালিকা:", style: TextStyle(fontSize: 16, color: Colors.cyanAccent, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _dailyTransactions.length,
              itemBuilder: (context, index) {
                final item = _dailyTransactions[index];
                return Card(
                  color: Colors.grey[850],
                  child: ListTile(
                    title: Text(item['desc'] ?? ''),
                    trailing: Text("৳ ${item['amount']}", style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ৩. সাপ্তাহিক পেজ
  Widget _buildWeeklyPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _weeklyDescController,
            decoration: const InputDecoration(labelText: "সাপ্তাহিক বিবরণ", border: OutlineInputBorder()),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _weeklyAmountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "টাকার পরিমাণ", border: OutlineInputBorder()),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal.shade700, minimumSize: const Size.fromHeight(45)),
            onPressed: () => _addTransaction(_weeklyDescController, _weeklyAmountController, _weeklyTransactions),
            child: const Text("সাপ্তাহিক হিসাব সেভ করুন", style: TextStyle(color: TextStyle(color: Colors.white))),
          ),
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("সাপ্তাহিক তালিকা:", style: TextStyle(fontSize: 16, color: Colors.cyanAccent, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _weeklyTransactions.length,
              itemBuilder: (context, index) {
                final item = _weeklyTransactions[index];
                return Card(
                  color: Colors.grey[850],
                  child: ListTile(
                    title: Text(item['desc'] ?? ''),
                    trailing: Text("৳ ${item['amount']}", style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ৪. মাসিক পেজ
  Widget _buildMonthlyPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _monthlyDescController,
            decoration: const InputDecoration(labelText: "মাসিক বিবরণ (যেমন: বাসা ভাড়া)", border: OutlineInputBorder()),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _monthlyAmountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "টাকার পরিমাণ", border: OutlineInputBorder()),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple.shade700, minimumSize: const Size.fromHeight(45)),
            onPressed: () => _addTransaction(_monthlyDescController, _monthlyAmountController, _monthlyTransactions),
            child: const Text("মাসিক হিসাব সেভ করুন", style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("মাসিক তালিকা:", style: TextStyle(fontSize: 16, color: Colors.cyanAccent, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _monthlyTransactions.length,
              itemBuilder: (context, index) {
                final item = _monthlyTransactions[index];
                return Card(
                  color: Colors.grey[850],
                  child: ListTile(
                    title: Text(item['desc'] ?? ''),
                    trailing: Text("৳ ${item['amount']}", style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHome(),
          _buildDailyPage(),
          _buildWeeklyPage(),
          _buildMonthlyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.cyanAccent,
        unselectedItemColor: Colors.white60,
        backgroundColor: Colors.black,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
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
