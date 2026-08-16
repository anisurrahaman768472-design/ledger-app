// ডিলিট করার ফাংশন (ডায়ালগসহ)
void _showDeleteDialog(BuildContext context, List<Map<String, String>> list, int index) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text("ডিলিট করতে চান?"),
      content: const Text("আপনি কি নিশ্চিত যে এই হিসাবটি মুছে ফেলতে চান?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(), // নো বা বন্ধ করা
          child: const Text("না"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            setState(() {
              list.removeAt(index);
            });
            Navigator.of(ctx).pop(); // ইয়েস এবং মুছে ফেলা
          },
          child: const Text("হ্যাঁ"),
        ),
      ],
    ),
  );
}
