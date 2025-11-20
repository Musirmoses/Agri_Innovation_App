import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/primary_button.dart';
import '../../theme/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../navigation/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.agriculture,
                      size: 60, color: AppColors.primary),
                  const SizedBox(height: 16),
                  const Text(
                    "Serious Farmers",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: emailCtrl,
                    decoration: const InputDecoration(labelText: "Email"),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: passCtrl,
                    decoration: const InputDecoration(labelText: "Password"),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  PrimaryButton(
                    label: "Login",
                    isLoading: auth.isLoading,
                    onPressed: () async {
                      final ok =
                          await auth.login(emailCtrl.text, passCtrl.text);
                      if (ok) {
                        if (context.mounted) {
                          Navigator.pushReplacementNamed(context, Routes.home);
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Invalid login")),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.register);
                    },
                    child: const Text("Create an account"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
