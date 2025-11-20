import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/crop.dart';
import '../../providers/crop_provider.dart';
import '../../widgets/primary_button.dart';

import '../../widgets/crop_health_widget.dart';
import '../../widgets/crop_stage_indicator.dart';

class CropDetailScreen extends StatefulWidget {
  final Crop crop; // Crop passed from navigation

  const CropDetailScreen({super.key, required this.crop});

  @override
  State<CropDetailScreen> createState() => _CropDetailScreenState();
}

class _CropDetailScreenState extends State<CropDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final crop = widget.crop;

    final daysSincePlanting =
        DateTime.now().difference(crop.plantedOn).inDays;

    return Scaffold(
      appBar: AppBar(
        title: Text(crop.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final ok = await showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Delete Crop"),
                  content: const Text(
                      "Are you sure you want to delete this crop?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text("Delete",
                          style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );

              if (ok == true) {
                await Provider.of<CropProvider>(context, listen: false)
                    .deleteCrop(crop.id);

                if (context.mounted) Navigator.pop(context);
              }
            },
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // --- Growth stage UI widget ---
          CropStageIndicator(days: daysSincePlanting),
          const SizedBox(height: 20),

          // --- BASIC DETAILS CARD ---
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Crop Details",
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 10),
                  Text(
                      "Planted On: ${crop.plantedOn.toLocal().toString().split(' ')[0]}"),
                  if (crop.expectedHarvest != null)
                    Text(
                        "Expected Harvest: ${crop.expectedHarvest!.toLocal().toString().split(' ')[0]}"),
                  Text("Watering: ${crop.wateringSchedule ?? "Not set"}"),
                  Text("Fertilizer: ${crop.fertilizerType ?? "Not set"}"),
                  Text("Growth Stage: ${crop.growthStage ?? "Unknown"}"),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // --- HEALTH STATUS ---
          CropHealthWidget(crop: crop),

          const SizedBox(height: 20),

          PrimaryButton(
            label: "Update Crop",
            onPressed: () => _openEditForm(context),
          ),
        ],
      ),
    );
  }

  /// Bottom sheet editing form
  void _openEditForm(BuildContext context) {
    final cropProvider = Provider.of<CropProvider>(context, listen: false);
    final crop = widget.crop;

    final waterCtrl = TextEditingController(text: crop.wateringSchedule);
    final fertCtrl = TextEditingController(text: crop.fertilizerType);
    final diseaseCtrl = TextEditingController(text: crop.diseaseStatus);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16, right: 16, top: 24,
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            const Text("Update Crop Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            TextField(
              controller: waterCtrl,
              decoration: const InputDecoration(labelText: "Watering Schedule"),
            ),
            const SizedBox(height: 14),

            TextField(
              controller: fertCtrl,
              decoration: const InputDecoration(labelText: "Fertilizer Type"),
            ),
            const SizedBox(height: 14),

            TextField(
              controller: diseaseCtrl,
              decoration: const InputDecoration(labelText: "Disease Status"),
            ),
            const SizedBox(height: 20),

            PrimaryButton(
              label: "Save",
              onPressed: () async {
                await cropProvider.updateCrop(crop.id, {
                  'watering_schedule': waterCtrl.text.trim(),
                  'fertilizer_type': fertCtrl.text.trim(),
                  'disease_status': diseaseCtrl.text.trim(),
                });

                if (context.mounted) Navigator.pop(context);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
