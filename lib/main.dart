import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const LedgerApp());

class LedgerApp extends StatefulWidget {
  const LedgerApp({super.key});

  @override
  State<LedgerApp> createState() => _LedgerAppState();
}

class _LedgerAppState extends State<LedgerApp> {
  bool isEnglish = false;
  bool isDarkMode = true;
  String userName = "Anisur rahman";
  String userNumber = "3102764"; // আপনার নাম্বারটি এখানে সেট করা হলো

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: const SplashScreen(),
    );
  }
}

// স্প্ল্যাশ স্ক্রিন
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 25),
            Text(
              "আমাদের অ্যাপসে আপনাকে স্বাগতম!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// ডেটা মডেল
class TransactionItem {
  String title;
  double amount;
  String type;
  DateTime date;

  TransactionItem({
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
  });
}

class LedgerFolder {
  String name;
  List<TransactionItem> transactions;

  LedgerFolder({required this.name, required this.transactions});
}

// মূল অ্যাপ স্ক্রিন
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<LedgerFolder> folders = [
    LedgerFolder(name: "মেস খরচ", transactions: []),
  ];

  String t(String bn, String en) {
    final appState = context.findAncestorStateOfType<_LedgerAppState>();
    return (appState?.isEnglish ?? false) ? en : bn;
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.findAncestorStateOfType<_LedgerAppState>();

    return Scaffold(
      appBar: AppBar(
        // অ্যাপবারের টাইটেলে নাম এবং ছোট করে নাম্বার সেট করা হলো
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t("আমার খাতা", "My Notebook"),
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              "${appState?.userName ?? ""} (${appState?.userNumber ?? ""})",
              style: const TextStyle(
                fontSize: 11,
                color: Colors.white70,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'lang') {
                appState?.setState(() {
                  appState.isEnglish = !appState.isEnglish;
                });
              } else if (value == 'dark') {
                appState?.setState(() {
                  appState.isDarkMode = !appState.isDarkMode;
                });
              }
            },
            itemBuilder: (ctx) => [
              PopupMenuItem(
                value: 'lang',
                child: Text(
                  (appState?.isEnglish ?? false)
                      ? "ভাষা: বাংলা করুন"
                      : "Language: Change to English",
                ),
              ),
              PopupMenuItem(
                value: 'dark',
                child: Text(
                  (appState?.isDarkMode ?? false)
                      ? t("লাইট মোড চালু করুন", "Turn on Light Mode")
                      : t("ডার্ক মোড চালু করুন", "Turn on Dark Mode"),
                ),
              ),
            ],
          ),
        ],
      ),
      body: _buildBodyContent(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: t("হোম", "Home"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.today),
            label: t("দৈনিক", "Daily"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_month),
            label: t("মাসিক", "Monthly"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.star),
            label: t("বাৎসরিক", "Yearly"),
          ),
        ],
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: _addFolderDialog,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildBodyContent() {
    if (_selectedIndex == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              t("ফাইল সিলেক্ট করুন:", "Select File:"),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: folders.length,
              itemBuilder: (ctx, i) => Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: const Icon(Icons.folder),
                  title: Text(folders[i].name),
                  subtitle: Text(
                    "${t('মোট এন্ট্রি', 'Entries')}: ${folders[i].transactions.length}",
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(folder: folders[i]),
                      ),
                    ).then((_) => setState(() {}));
                  },
                  onLongPress: () => _confirmDeleteFolder(i),
                ),
              ),
            ),
          ),
        ],
      );
    } else if (_selectedIndex == 1) {
      return Center(
        child: Text(
          t("আজকের দৈনিক হিসাব দেখতে পাচ্ছেন", "Daily Ledger View"),
          style: const TextStyle(fontSize: 16),
        ),
      );
    } else if (_selectedIndex == 2) {
      return Center(
        child: Text(
          t("এই মাসের আয়, ব্যয় ও খরচ দেখতে পাচ্ছেন", "Monthly Ledger View"),
          style: const TextStyle(fontSize: 16),
        ),
      );
    } else {
      return Center(
        child: Text(
          t("এই বছরের সব হিসাব-নিকাশ দেখতে পাচ্ছেন", "Yearly Ledger View"),
          style: const TextStyle(fontSize: 16),
        ),
      );
    }
  }

  void _addFolderDialog() {
    final nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t("নতুন ফাইল তৈরি করুন", "Create New File")),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: t("ফাইলের নাম লিখুন", "Enter File Name"),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(t("বাতিল", "Cancel")),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                setState(() {
                  folders.add(LedgerFolder(
                    name: nameController.text,
                    transactions: [],
                  ));
                });
              }
              Navigator.pop(ctx);
            },
            child: Text(t("সংরক্ষণ", "Save")),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteFolder(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t("ডিলিট করতে চান?", "Delete File?")),
        content: Text(
          t(
            "'${folders[index].name}' ফাইলটি কি মুছে ফেলতে চান?",
            "Do you want to delete '${folders[index].name}'?",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(t("না", "No")),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                folders.removeAt(index);
              });
              Navigator.pop(ctx);
            },
            child: Text(t("হ্যাঁ", "Yes")),
          ),
        ],
      ),
    );
  }
}

// ডিটেইল স্ক্রিন
class DetailScreen extends StatefulWidget {
  final LedgerFolder folder;

  const DetailScreen({super.key, required this.folder});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String t(String bn, String en) {
    final appState = context.findAncestorStateOfType<_LedgerAppState>();
    return (appState?.isEnglish ?? false) ? en : bn;
  }

  @override
  Widget build(BuildContext context) {
    double totalIncome = widget.folder.transactions
        .where((t) => t.type == 'Income')
        .fold(0, (sum, item) => sum + item.amount);

    double totalExpense = widget.folder.transactions
        .where((t) => t.type == 'Expense')
        .fold(0, (sum, item) => sum + item.amount);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.folder.name),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(12.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent, width: 1.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(t("মাসিক আয়:", "Monthly Income:")),
                    Text(
                      "$totalIncome ৳",
                      style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(t("মাসিক ব্যয়:", "Monthly Expense:")),
                    Text(
                      "$totalExpense ৳",
                      style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: widget.folder.transactions.isEmpty
                ? Center(child: Text(t("কোনো হিসাব যোগ করা হয়নি", "No entries added yet")))
                : ListView.builder(
                    itemCount: widget.folder.transactions.length,
                    itemBuilder: (ctx, i) {
                      final item = widget.folder.transactions[i];
                      bool isIncome = item.type == 'Income';
                      return ListTile(
                        title: Text(item.title),
                        subtitle: Text(
                          isIncome ? t("আয়", "Income") : t("ব্যয়/খরচ", "Expense"),
                          style: TextStyle(color: isIncome ? Colors.green : Colors.red),
                        ),
                        trailing: Text(
                          "${item.amount} ৳",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        onLongPress: () => _confirmDeleteTransaction(i),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTransactionDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addTransactionDialog() {
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    String selectedType = 'Expense';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: Text(t("নতুন হিসাব যোগ করুন", "Add New Entry")),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: t("বিবরণ", "Description"),
                  ),
                ),
                TextField(
                  controller: amountController,
                  decoration: InputDecoration(
                    labelText: t("পরিমাণ", "Amount"),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                DropdownButton<String>(
                  isExpanded: true,
                  value: selectedType,
                  onChanged: (val) {
                    setDialogState(() => selectedType = val!);
                  },
                  items: [
                    DropdownMenuItem(
                      value: 'Income',
                      child: Text(t("আয়", "Income")),
                    ),
                    DropdownMenuItem(
                      value: 'Expense',
                      child: Text(t("ব্যয় / খরচ", "Expense")),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text(t("বাতিল", "Cancel")),
              ),
              ElevatedButton(
                onPressed: () {
                  if (amountController.text.isNotEmpty) {
                    setState(() {
                      widget.folder.transactions.add(
                        TransactionItem(
                          title: titleController.text,
                          amount: double.tryParse(amountController.text) ?? 0,
                          type: selectedType,
                          date: DateTime.now(),
                        ),
                      );
                    });
                  }
                  Navigator.pop(ctx);
                },
                child: Text(t("সংরক্ষণ", "Save")),
              ),
            ],
          );
        },
      ),
    );
  }

  void _confirmDeleteTransaction(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t("ডিলিট করতে চান?", "Delete Entry?")),
        content: Text(t("এই এন্ট্রিটি কি মুছে ফেলবেন?", "Do you want to remove this entry?")),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(t("না", "No")),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                widget.folder.transactions.removeAt(index);
              });
              Navigator.pop(ctx);
            },
            child: Text(t("হ্যাঁ", "Yes")),
          ),
        ],
      ),
    );
  }
}
