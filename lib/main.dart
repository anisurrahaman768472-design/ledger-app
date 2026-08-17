appBar: AppBar(
  title: const Text('Home - Main Menu'),
  actions: [
    // ডার্ক মোড টগল বাটন
    IconButton(
      onPressed: widget.toggleTheme,
      icon: const Icon(Icons.brightness_6),
    ),
    // ল্যাঙ্গুয়েজ মেনু
    PopupMenuButton<String>(
      icon: const Icon(Icons.language), // মেনুটি চিহ্নিত করতে একটি আইকন দিলাম
      onSelected: (String value) {
        widget.changeLanguage(value);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'en',
          child: Text('English'),
        ),
        const PopupMenuItem<String>(
          value: 'bn',
          child: Text('বাংলা'),
        ),
      ],
    ),
  ],
),
