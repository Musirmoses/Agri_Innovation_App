import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/plot.dart';
import '../../providers/crop_provider.dart';
import '../../widgets/primary_button.dart';

class AddCropScreen extends StatefulWidget {
  final Plot plot;
  const AddCropScreen({required this.plot, super.key});

  @override
  State<AddCropScreen> createState() => _AddCropScreenState();
}

class _AddCropScreenState extends State<AddCropScreen> {
  final nameCtrl = TextEditingController();
  final harvestCtrl = TextEditingController();
  final waterCtrl = TextEditingController();
  final fertilizerCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cropProvider = Provider.of<CropProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Add Crop")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: "Crop Name")),
            const SizedBox(height: 14),
            TextField(
                controller: harvestCtrl,
                decoration: const InputDecoration(
                    labelText: "Expected Harvest Date (YYYY-MM-DD)")),
            const SizedBox(height: 14),
            TextField(
                controller: waterCtrl,
                decoration:
                    const InputDecoration(labelText: "Watering Schedule")),
            const SizedBox(height: 14),
            TextField(
                controller: fertilizerCtrl,
                decoration:
                    const InputDecoration(labelText: "Fertilizer Type")),
            const SizedBox(height: 20),
            PrimaryButton(
              label: "Save Crop",
              onPressed: () async {
                await cropProvider.addCrop({
                  'plot_id': widget.plot.id,
                  'name': nameCtrl.text.trim(),
                  'planted_on': DateTime.now().toIso8601String(),
                  'expected_harvest': harvestCtrl.text.isEmpty
                      ? null
                      : DateTime.tryParse(harvestCtrl.text)?.toIso8601String(),
                  'watering_schedule': waterCtrl.text.trim(),
                  'fertilizer_type': fertilizerCtrl.text.trim(),
                  'created_at': DateTime.now().toIso8601String(),
                });

                if (context.mounted) Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
