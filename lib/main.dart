import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

// ১. ভাষার ডেটা ও অনুবাদের ক্লাস
class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'home_title': 'Home - Main Menu',
      'welcome_msg': 'Welcome to My Khata App!',
      'welcome_desc': 'Keep all your accounts safe in one place. Access any menu below:',
      'daily_ledger': 'Daily Ledger',
      'daily_subtitle': 'Add today\'s expense',
      'weekly_ledger': 'Weekly Ledger',
      'weekly_subtitle': 'View weekly statement',
      'monthly_ledger': 'Monthly Ledger',
      'monthly_subtitle': 'Total monthly account',
      'title_daily': 'Daily Ledger',
      'title_weekly': 'Weekly Ledger',
      'title_monthly': 'Monthly Ledger',
      'label_desc': 'Description',
      'label_amount': 'Amount',
      'label_date': 'Date',
      'btn_save': 'Save',
      'header_list': 'List:',
      'del_title': 'Delete Entry?',
      'del_msg': 'Are you sure you want to delete this entry?',
      'btn_yes': 'Yes',
      'btn_no': 'No',
      'home_nav': 'Home',
      'daily_nav': 'Daily',
      'weekly_nav': 'Weekly',
      'monthly_nav': 'Monthly',
    },
    'bn': {
      'home_title': 'হোম - মেইন মেনু',
      'welcome_msg': 'আমার খাতা - অ্যাপে স্বাগতম!',
      'welcome_desc': 'আপনার সকল হিসাব নিকাশ এখন এক জায়গায় নিরাপদে রাখুন। নিচে থেকে যেকোনো মেনুতে প্রবেশ করুন:',
      'daily_ledger': 'দৈনিক খাতা',
      'daily_subtitle': 'আজকের খরচ যোগ করুন',
      'weekly_ledger': 'সাপ্তাহিক খাতা',
      'weekly_subtitle': 'সাপ্তাহিক হিসাবের বিবরণ দেখুন',
      'monthly_ledger': 'মাসিক খাতা',
      'monthly_subtitle': 'মাসের মোট হিসাব ও বাজেট',
      'title_daily': 'দৈনিক হিসাব',
      'title_weekly': 'সাপ্তাহিক হিসাব',
      'title_monthly': 'মাসিক হিসাব',
      'label_desc': 'নাম',
      'label_amount': 'টাকা',
      'label_date': 'তারিখ',
      'btn_save': 'সেভ করুন',
      'header_list': 'তালিকা:',
      'del_title': 'হিসাব ডিলিট?',
      'del_msg': 'আপনি কি নিশ্চিত যে এই হিসাবটি মুছে ফেলতে চান?',
      'btn_yes': 'হ্যাঁ',
      'btn_no': 'না',
      'home_nav': 'হোম',
      'daily_nav': 'দৈনিক',
      'weekly_nav': 'সাপ্তাহিক',
      'monthly_nav': 'মাসিক',
    },
    'es': {
      'home_title': 'Inicio - Menú Principal',
      'welcome_msg': '¡Bienvenido a Mi Libro de Cuentas!',
      'welcome_desc': 'Mantenga todas sus cuentas seguras en un solo lugar. Acceda a cualquier menú a continuación:',
      'daily_ledger': 'Registro Diario',
      'daily_subtitle': 'Agregar gasto de hoy',
      'weekly_ledger': 'Registro Semanal',
      'weekly_subtitle': 'Ver estado semanal',
      'monthly_ledger': 'Registro Mensual',
      'monthly_subtitle': 'Cuenta mensual total',
      'title_daily': 'Registro Diario',
      'title_weekly': 'Registro Semanal',
      'title_monthly': 'Registro Mensual',
      'label_desc': 'Descripción',
      'label_amount': 'Monto',
      'label_date': 'Fecha',
      'btn_save': 'Guardar',
      'header_list': 'Lista:',
      'del_title': '¿Eliminar Entrada?',
      'del_msg': '¿Está seguro de que desea eliminar esta entrada?',
      'btn_yes': 'Sí',
      'btn_no': 'No',
      'home_nav': 'Inicio',
      'daily_nav': 'Diario',
      'weekly_nav': 'Semanal',
      'monthly_nav': 'Mensual',
    },
  };

  String getTranslatedValue(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) => ['en', 'bn', 'es'].contains(locale.languageCode);
  @override
  Future<AppLocalizations> load(Locale locale) async => AppLocalizations(locale);
  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}

// ২. মেইন অ্যাপ ক্লাস (ভাষা পরিবর্তন হ্যান্ডেল করার জন্য)
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // গ্লোবাল স্টেট অ্যাক্সেস করার জন্য স্ট্যাটিক মেথড
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: AppBarTheme(backgroundColor: Colors.indigo.shade900),
      ),
      locale: _locale, // বর্তমান ভাষা সেট করা
      supportedLocales: const [
        Locale('en', ''), // ইংলিশ
        Locale('bn', ''), // বাংলা
        Locale('es', ''), // হিন্দি
      ],
      localizationsDelegates: const [
        _AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const AmarKhataApp(),
    );
  }
}

// ৩. মূল অ্যাপের পেজ ও উইজেট (অনুবাদ ব্যবহার করে আপডেট করা হয়েছে)
class AmarKhataApp extends StatefulWidget {
  const AmarKhataApp({super.key});

  @override
  State<AmarKhataApp> createState() => _AmarKhataAppState();
}

class _AmarKhataAppState extends State<AmarKhataApp> {
  int _currentIndex = 0;
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final List<Map<String, String>> _dailyTransactions = [];
  final List<Map<String, String>> _weeklyTransactions = [];
  final List<Map<String, String>> _monthlyTransactions = [];
  DateTime _selectedDate = DateTime.now();

  // তারিখ সিলেক্ট করার ফাংশন (Date Format is locale-aware)
  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: Localizations.localeOf(context), // তারিখের ক্যালেন্ডার ভাষা অনুযায়ী দেখাবে
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  // ট্রানজ্যাকশন যোগ করার ফাংশন
  void _addTransaction(List<Map<String, String>> list) {
    if (_descController.text.isNotEmpty && _amountController.text.isNotEmpty) {
      setState(() {
        list.add({
          "desc": _descController.text,
          "amount": _amountController.text,
          "date": DateFormat.yMd(Localizations.localeOf(context).languageCode).format(_selectedDate)
        });
        _descController.clear();
        _amountController.clear();
      });
    }
  }

  // ডিলিট করার ফাংশন (ডায়ালগসহ)
  void _showDeleteDialog(BuildContext context, List<Map<String, String>> list, int index, AppLocalizations loc) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(loc.getTranslatedValue('del_title')),
        content: Text(loc.getTranslatedValue('del_msg')),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: Text(loc.getTranslatedValue('btn_no'))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() => list.removeAt(index));
              Navigator.of(ctx).pop();
            },
            child: Text(loc.getTranslatedValue('btn_yes')),
          ),
        ],
      ),
    );
  }

  // হোম পেজ (কার্ড ডিজাইন)
  Widget _buildHome(AppLocalizations loc) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Text(loc.getTranslatedValue('welcome_msg'), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
          const SizedBox(height: 10),
          Text(loc.getTranslatedValue('welcome_desc'), style: const TextStyle(fontSize: 14, color: Colors.white70)),
          const SizedBox(height: 20),
          _buildMenuCard(loc.getTranslatedValue('daily_ledger'), loc.getTranslatedValue('daily_subtitle'), Icons.today, Colors.indigo, () => setState(() => _currentIndex = 1)),
          _buildMenuCard(loc.getTranslatedValue('weekly_ledger'), loc.getTranslatedValue('weekly_subtitle'), Icons.date_range, Colors.teal, () => setState(() => _currentIndex = 2)),
          _buildMenuCard(loc.getTranslatedValue('monthly_ledger'), loc.getTranslatedValue('monthly_subtitle'), Icons.calendar_month, Colors.deepPurple, () => setState(() => _currentIndex = 3)),
        ],
      ),
    );
  }

  Widget _buildMenuCard(String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      color: color.withOpacity(0.3),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.cyanAccent),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }

  // হিসাব পেজ (Transaction Page)
  Widget _buildTransactionPage(List<Map<String, String>> list, Color btnColor, AppLocalizations loc) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          TextField(controller: _descController, decoration: InputDecoration(labelText: loc.getTranslatedValue('label_desc'), border: const OutlineInputBorder())),
          const SizedBox(height: 10),
          TextField(controller: _amountController, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: loc.getTranslatedValue('label_amount'), border: const OutlineInputBorder())),
          const SizedBox(height: 10),
          ListTile(
            title: Text("${loc.getTranslatedValue('label_date')}: ${DateFormat.yMd(Localizations.localeOf(context).languageCode).format(_selectedDate)}"),
            trailing: const Icon(Icons.calendar_today),
            onTap: () => _pickDate(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: btnColor),
            onPressed: () => _addTransaction(list),
            child: Text(loc.getTranslatedValue('btn_save')),
          ),
          const SizedBox(height: 20),
          Align(alignment: Alignment.centerLeft, child: Text(loc.getTranslatedValue('header_list'), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.cyanAccent))),
          const SizedBox(height: 10),
          // তালিকা
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final item = list[index];
              return Card(
                child: ListTile(
                  title: Text(item['desc']!),
                  subtitle: Text("${loc.getTranslatedValue('label_date')}: ${item['date']}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("৳ ${item['amount']}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.greenAccent)),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _showDeleteDialog(context, list, index, loc),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // বর্তমান পেজের জন্য অনুবাদ লোড করা
    final loc = AppLocalizations.of(context)!;
    final titles = [
      loc.getTranslatedValue('home_title'),
      loc.getTranslatedValue('title_daily'),
      loc.getTranslatedValue('title_weekly'),
      loc.getTranslatedValue('title_monthly')
    ];
    final bottomNavItems = [
      BottomNavigationBarItem(icon: const Icon(Icons.home), label: loc.getTranslatedValue('home_nav')),
      BottomNavigationBarItem(icon: const Icon(Icons.today), label: loc.getTranslatedValue('daily_nav')),
      BottomNavigationBarItem(icon: const Icon(Icons.date_range), label: loc.getTranslatedValue('weekly_nav')),
      BottomNavigationBarItem(icon: const Icon(Icons.calendar_month), label: loc.getTranslatedValue('monthly_nav')),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_currentIndex], style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          // ৩-ডট মেনু (ভাষা পরিবর্তনের জন্য)
          PopupMenuButton<Locale>(
            onSelected: (Locale newLocale) {
              // ভাষা পরিবর্তন করার অ্যাকশন
              MyApp.setLocale(context, newLocale);
            },
            icon: const Icon(Icons.more_vert), // থ্রি-ডট আইকন
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Locale>>[
              const PopupMenuItem<Locale>(
                value: Locale('en', ''),
                child: Text('English'),
              ),
              const PopupMenuItem<Locale>(
                value: Locale('bn', ''),
                child: Text('বাংলা'),
              ),
              const PopupMenuItem<Locale>(
                value: Locale('es', ''),
                child: Text('Español'),
              ),
            ],
          ),
        ],
      ),
      body: _currentIndex == 0 ? _buildHome(loc) : _buildTransactionPage(
        _currentIndex == 1 ? _dailyTransactions : (_currentIndex == 2 ? _weeklyTransactions : _monthlyTransactions),
        _currentIndex == 1 ? Colors.indigo.shade700 : (_currentIndex == 2 ? Colors.teal.shade700 : Colors.deepPurple.shade700),
        loc
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.cyanAccent,
        unselectedItemColor: Colors.white60,
        backgroundColor: Colors.black,
        onTap: (index) => setState(() => _currentIndex = index),
        items: bottomNavItems,
      ),
    );
  }
}
