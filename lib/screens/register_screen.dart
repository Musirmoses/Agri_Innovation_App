import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../navigation/routes.dart';
import '../../theme/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Create Account"),
        backgroundColor: AppColors.primary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 20),
          const Text(
            "Join Smart Farmers",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          const Text(
            "Plan your food bucket • Track yields • Buy seedlings • Learn farming",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),

          TextField(
            controller: nameCtrl,
            decoration: const InputDecoration(
              labelText: "Full Name",
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: emailCtrl,
            decoration: const InputDecoration(
              labelText: "Email",
              prefixIcon: Icon(Icons.email),
            ),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: passCtrl,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Password",
              prefixIcon: Icon(Icons.lock),
            ),
          ),
          const SizedBox(height: 25),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.all(14),
            ),
            onPressed: loading ? null : () => _register(context),
            child: loading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text("Create Account"),
          ),

          const SizedBox(height: 20),

          TextButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, Routes.login),
            child: const Text("Already have an account? Log in"),
          )
        ],
      ),
    );
  }

  Future<void> _register(BuildContext context) async {
    setState(() => loading = true);

    final auth = Provider.of<AuthProvider>(context, listen: false);
    final ok = await (auth as dynamic).signUp(
      nameCtrl.text.trim(),
      emailCtrl.text.trim(),
      passCtrl.text.trim(),
    );

    setState(() => loading = false);

    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account created successfully!")),
      );

      Navigator.pushReplacementNamed(context, Routes.home);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to create account.")),
      );
    }
  }
}
