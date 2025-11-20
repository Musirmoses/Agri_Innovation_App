import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    if (auth.user == null) {
      return const Scaffold(body: Center(child: Text("Not logged in")));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text("Name: ${auth.user!.name}"),
            Text("Email: ${auth.user!.email}"),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => auth.logout(),
              child: const Text("Logout"),
            )
          ],
        ),
      ),
    );
  }
}
