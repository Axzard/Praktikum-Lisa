import 'package:flutter/material.dart';
import 'api_servis.dart';
import 'model_book.dart';

class EditBookScreen extends StatefulWidget {
  final Book book;

  const EditBookScreen({super.key, required this.book});

  @override
  _EditBookScreenState createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  late TextEditingController titleController;
  late TextEditingController authorController;
  late TextEditingController descriptionController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.book.title);
    authorController = TextEditingController(text: widget.book.author);
    descriptionController = TextEditingController(text: widget.book.description);
  }

  void handleUpdate() async {
    setState(() => isLoading = true);

    try {
      await updateBook(
        widget.book.id,
        titleController.text,
        authorController.text,
        descriptionController.text,
      );

      // Buat objek Book baru dengan data terbaru
      final updatedBook = Book(
        id: widget.book.id,
        title: titleController.text,
        author: authorController.text,
        description: descriptionController.text,
      );

      Navigator.pop(context, updatedBook); // kembalikan Book terbaru
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal mengedit buku: $e")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Buku")),
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
                : ElevatedButton(onPressed: handleUpdate, child: const Text("Simpan Perubahan")),
          ],
        ),
      ),
    );
  }
}
