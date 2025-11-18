import 'package:flutter/material.dart';
import 'api_servis.dart';
import 'model_book.dart';
import 'edit_book.dart';

class BookDetailScreen extends StatefulWidget {
  final Book book;

  const BookDetailScreen({super.key, required this.book});

  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  late Book book;

  @override
  void initState() {
    super.initState();
    book = widget.book;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(book.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("Penulis: ${book.author}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Text(book.description, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final updatedBook = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => EditBookScreen(book: book)),
                    );

                    if (updatedBook != null && updatedBook is Book) {
                      setState(() {
                        book = updatedBook; // update detail secara realtime
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Buku berhasil diperbarui")),
                      );
                    }
                  },
                  child: const Text("Edit"),
                ),
                ElevatedButton.icon(
  onPressed: () async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Konfirmasi Hapus"),
        content: const Text("Apakah Anda yakin ingin menghapus buku ini?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              "Hapus",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await deleteBook(book.id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Buku berhasil dihapus")),
      );
      Navigator.pop(context, true); // refresh list
    } catch (e) {
      // Ambil error dari api_service, misal "Bukan pemilik buku" atau lainnya
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  },
  icon: const Icon(Icons.delete_outline),
  label: const Text("Hapus"),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.red.shade400,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
