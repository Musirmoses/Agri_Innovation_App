import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/farm.dart';
import '../../providers/farm_provider.dart';
import '../../widgets/primary_button.dart';

class AddPlotScreen extends StatefulWidget {
  final Farm farm;

  const AddPlotScreen({required this.farm, super.key});

  @override
  State<AddPlotScreen> createState() => _AddPlotScreenState();
}

class _AddPlotScreenState extends State<AddPlotScreen> {
  final nameCtrl = TextEditingController();
  final sizeCtrl = TextEditingController();
  final cropCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FarmProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Add Plot")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: "Plot Name")),
            const SizedBox(height: 14),
            TextField(
                controller: sizeCtrl,
                decoration: const InputDecoration(labelText: "Size (acres)")),
            const SizedBox(height: 14),
            TextField(
                controller: cropCtrl,
                decoration:
                    const InputDecoration(labelText: "Crop Type (optional)")),
            const SizedBox(height: 20),
            PrimaryButton(
              label: "Save Plot",
              onPressed: () async {
                await provider.addPlot({
                  'farm_id': widget.farm.id,
                  'name': nameCtrl.text,
                  'size': double.tryParse(sizeCtrl.text),
                  'crop_type': cropCtrl.text.isEmpty ? null : cropCtrl.text,
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
