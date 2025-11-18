import 'package:flutter/material.dart';
import 'api_servis.dart';
import 'model_book.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final descriptionController = TextEditingController();
  bool isLoading = false;

  void handleAddBook() async {
  setState(() => isLoading = true);

  try {
    final newBook = await addBook(
      titleController.text,
      authorController.text,
      descriptionController.text,
    );
    setState(() => isLoading = false);
    // Tampilkan SnackBar sukses
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Buku berhasil ditambahkan")),
    );

    // Kembalikan Book ke halaman sebelumnya
    Navigator.pop(context, newBook);
  } catch (e) {
    setState(() => isLoading = false);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Gagal menambahkan buku: $e")));
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Buku")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: "Judul")),
            TextField(controller: authorController, decoration: const InputDecoration(labelText: "Penulis")),
            TextField(controller: descriptionController, decoration: const InputDecoration(labelText: "Deskripsi")),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: handleAddBook,
                    child: const Text("Tambah"),
                  ),
          ],
        ),
      ),
    );
  }
}
