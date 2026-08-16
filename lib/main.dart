import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

// ==========================================
// ১. বহুভাষী সিস্টেম (Internationalization - i18n)
// ==========================================
class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'home_title': 'Home - Main Menu',
      'welcome_msg': 'Welcome to My Khata!',
      'welcome_desc': 'Keep all your accounts safe in one place. Access below:',
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
      'settings': 'Settings',
      'language': 'Language',
      'dark_mode': 'Dark Mode',
    },
    'bn': {
      'home_title': 'হোম - মেইন মেনু',
      'welcome_msg': 'আমার খাতায় স্বাগতম!',
      'welcome_desc': 'আপনার সকল হিসাব নিকাশ এক জায়গায় নিরাপদে রাখুন:',
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
      'daily_nav': 'প্রতিদিন',
      'weekly_nav': 'সাপ্তাহিক',
      'monthly_nav': 'মাসিক',
      'settings': 'সেটিংস',
      'language': 'ভাষা',
      'dark_mode': 'ডার্ক মোড',
    },
    'es': {
      'home_title': 'Inicio - Menú Principal',
      'welcome_msg': '¡Bienvenido a My Khata!',
      'welcome_desc': 'Mantenga todas sus cuentas seguras en un solo lugar:',
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
      'settings': 'Configuración',
      'language': 'Idioma',
      'dark_mode': 'Modo Oscuro',
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

// ==========================================
// ২. সেটিংস প্রোভাইডার (Theme & Language)
// ==========================================
class SettingsProvider with ChangeNotifier {
  bool _isDarkMode = false;
  Locale _locale = const Locale('bn'); // ডিফল্ট বাংলা

  bool get isDarkMode => _isDarkMode;
  Locale get locale => _locale;

  SettingsProvider() {
    _loadSettingsFromPrefs();
  }

  _loadSettingsFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    String langCode = prefs.getString('languageCode') ?? 'bn';
    _locale = Locale(langCode);
    notifyListeners();
  }

  void toggleTheme(bool value) async {
    _isDarkMode = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', value);
    notifyListeners();
  }

  void setLanguage(Locale locale) async {
    _locale = locale;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('languageCode', locale.languageCode);
    notifyListeners();
  }
}

// ==========================================
// ৩. মেইন অ্যাপ উইজেট
// ==========================================
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // থিম সেটিংস
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: AppBarTheme(backgroundColor: Colors.indigo.shade900),
        cardTheme: CardTheme(color: Colors.grey[850]),
      ),
      themeMode: settingsProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      
      // ভাষা সেটিংস
      locale: settingsProvider.locale,
      supportedLocales: const [
        Locale('en', ''),
        Locale('bn', ''),
        Locale('es', ''),
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

// ==========================================
// ৪. মূল অ্যাপের পেজ ও উইজেট
// ==========================================
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

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: Localizations.localeOf(context),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  void _addTransaction(List<Map<String, String>> list, AppLocalizations loc) {
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

  // সেটিংস পেজ
  Widget _buildSettingsPage(AppLocalizations loc, SettingsProvider settingsProvider) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Text(loc.getTranslatedValue('settings'), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          // ভাষা পরিবর্তন
          ListTile(
            title: Text(loc.getTranslatedValue('language')),
            trailing: DropdownButton<Locale>(
              value: loc.locale,
              onChanged: (Locale? newLocale) {
                if (newLocale != null) {
                  settingsProvider.setLanguage(newLocale);
                }
              },
              items: const [
                DropdownMenuItem(value: Locale('en'), child: Text('English')),
                DropdownMenuItem(value: Locale('bn'), child: Text('বাংলা')),
                DropdownMenuItem(value: Locale('es'), child: Text('Español')),
              ],
            ),
          ),
          const Divider(),
          // ডার্ক মোড টগল
          SwitchListTile(
            title: Text(loc.getTranslatedValue('dark_mode')),
            value: settingsProvider.isDarkMode,
            onChanged: (value) {
              settingsProvider.toggleTheme(value);
            },
          ),
        ],
      ),
    );
  }

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
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.cyanAccent),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }

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
            title: Text("${loc.getTranslatedValue('label_date')}:${DateFormat.yMd(Localizations.localeOf(context).languageCode).format(_selectedDate)}"),
            trailing: const Icon(Icons.calendar_today),
            onTap: () => _pickDate(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: btnColor),
            onPressed: () => _addTransaction(list, loc),
            child: Text(loc.getTranslatedValue('btn_save')),
          ),
          const SizedBox(height: 20),
          Align(alignment: Alignment.centerLeft, child: Text(loc.getTranslatedValue('header_list'), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.cyanAccent))),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final item = list[index];
              return Card(
                child: ListTile(
                  title: Text(item['desc']!),
                  subtitle: Text("${loc.getTranslatedValue('label_date')}:${item['date']}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("৳ ${item['amount']}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.greenAccent)),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed:
