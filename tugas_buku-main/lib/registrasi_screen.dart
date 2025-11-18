import 'package:flutter/material.dart';
import 'api_auth.dart';
import 'login_screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final name = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final phone = TextEditingController();

  bool loading = false;

  void handleRegister() async {
    setState(() => loading = true);

    final result = await registerUser(
      name: name.text,
      username: username.text,
      email: email.text,
      password: password.text,
      phone: phone.text,
    );

    setState(() => loading = false);

    if (result["status"] == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Berhasil Registrasi")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result["body"]["message"].toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registrasi")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextField(controller: name, decoration: const InputDecoration(labelText: "Name")),
            TextField(controller: username, decoration: const InputDecoration(labelText: "Username")),
            TextField(controller: email, decoration: const InputDecoration(labelText: "Email")),
            TextField(controller: phone, decoration: const InputDecoration(labelText: "Phone")),
            TextField(controller: password, decoration: const InputDecoration(labelText: "Password"), obscureText: true),

            const SizedBox(height: 20),
            loading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: handleRegister,
                    child: const Text("Daftar"),
                  ),

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Sudah punya akun? Login"),
            ),
          ],
        ),
      ),
    );
  }
}
