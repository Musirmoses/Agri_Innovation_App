import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/farm_provider.dart';
import '../../widgets/primary_button.dart';

class AddFarmScreen extends StatefulWidget {
  const AddFarmScreen({super.key});

  @override
  State<AddFarmScreen> createState() => _AddFarmScreenState();
}

class _AddFarmScreenState extends State<AddFarmScreen> {
  final nameCtrl = TextEditingController();
  final locationCtrl = TextEditingController();
  final sizeCtrl = TextEditingController();
  final soilCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final provider = Provider.of<FarmProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Add Farm")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: "Farm Name")),
            const SizedBox(height: 14),
            TextField(
                controller: locationCtrl,
                decoration: const InputDecoration(labelText: "Location")),
            const SizedBox(height: 14),
            TextField(
                controller: sizeCtrl,
                decoration:
                    const InputDecoration(labelText: "Farm Size (acres)")),
            const SizedBox(height: 14),
            TextField(
                controller: soilCtrl,
                decoration: const InputDecoration(labelText: "Soil Type")),
            const SizedBox(height: 20),
            PrimaryButton(
              label: "Save Farm",
              onPressed: () async {
                await provider.addFarm({
                  'user_id': auth.user!.id,
                  'name': nameCtrl.text,
                  'location': locationCtrl.text,
                  'size_acres': double.tryParse(sizeCtrl.text),
                  'soil_type': soilCtrl.text,
                  'created_at': DateTime.now().toIso8601String(),
                });

                if (context.mounted) Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
