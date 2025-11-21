import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/supplier.dart';
import '../../theme/app_colors.dart';

class SupplierDetailScreen extends StatelessWidget {
  final Supplier supplier;

  const SupplierDetailScreen({super.key, required this.supplier});

  // ---------------------------------------------------------------------------
  // CALL SUPPLIER
  // ---------------------------------------------------------------------------
  Future<void> _callSupplier(String? phone) async {
    if (phone == null) return;
    final uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  // ---------------------------------------------------------------------------
  // SMS SUPPLIER
  // ---------------------------------------------------------------------------
  Future<void> _smsSupplier(String? phone) async {
    if (phone == null) return;
    final uri = Uri(scheme: 'sms', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  // ---------------------------------------------------------------------------
  // WHATSAPP CHAT
  // ---------------------------------------------------------------------------
  Future<void> _whatsappSupplier(String? phone) async {
    if (phone == null) return;

    final cleaned = phone.replaceAll('+', '').replaceAll(' ', '');
    final uri = Uri.parse("https://wa.me/$cleaned?text=Hello%20I%20am%20interested%20in%20your%20seedlings");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  // ---------------------------------------------------------------------------
  // REQUEST QUOTE (POPUP FORM)
  // ---------------------------------------------------------------------------
  void _requestQuote(BuildContext context) {
    final cropCtrl = TextEditingController();
    final qtyCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Request Quote"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: cropCtrl,
              decoration: const InputDecoration(labelText: "Crop Name"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: qtyCtrl,
              decoration: const InputDecoration(labelText: "Quantity Needed"),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(ctx),
          ),
          ElevatedButton(
            child: const Text("Submit"),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Quote request sent!")),
              );
            },
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // BUY SEEDLING (DEMO — POPUP ONLY)
  // ---------------------------------------------------------------------------
  void _buySeedling(BuildContext context, String crop, String price) {
    final qtyCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Buy $crop"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Price: KES $price each"),
            const SizedBox(height: 12),
            TextField(
              controller: qtyCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Quantity"),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(ctx),
          ),
          ElevatedButton(
            child: const Text("Confirm"),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Purchased ${qtyCtrl.text} x $crop"),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // UI BUILD
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(supplier.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // Supplier Info Card
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      supplier.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    if (supplier.location != null) ...[
                      const SizedBox(height: 8),
                      Text("📍 Location: ${supplier.location}"),
                    ],
                    if (supplier.phone != null) ...[
                      const SizedBox(height: 4),
                      Text("📞 Phone: ${supplier.phone}"),
                    ],
                    if (supplier.rating != null) ...[
                      const SizedBox(height: 4),
                      Text("⭐ Rating: ${supplier.rating} / 5"),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // CONTACT BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.call),
                  label: const Text("Call"),
                  onPressed: () => _callSupplier(supplier.phone),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.sms),
                  label: const Text("SMS"),
                  onPressed: () => _smsSupplier(supplier.phone),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.message),
                  label: const Text("WhatsApp"),
                  onPressed: () => _whatsappSupplier(supplier.phone),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // REQUEST QUOTE
            ElevatedButton.icon(
              icon: const Icon(Icons.request_page),
              label: const Text("Request a Quote"),
              onPressed: () => _requestQuote(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
              ),
            ),

            const SizedBox(height: 25),

            // SEEDLINGS TITLE
            const Text(
              "Available Seedlings",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // SEEDLINGS LIST
            ...supplier.crops.map(
              (crop) {
                final price = supplier.prices?[crop]?.toString() ?? "N/A";

                return Card(
                  elevation: 2,
                  child: ListTile(
                    leading: const Icon(Icons.local_florist,
                        color: AppColors.primary),
                    title: Text(crop),
                    subtitle: Text("KES $price / seedling"),
                    trailing: ElevatedButton(
                      child: const Text("Buy"),
                      onPressed: () =>
                          _buySeedling(context, crop, price.toString()),
                    ),
                  ),
                );
              },
            ).toList(),
          ],
        ),
      ),
    );
  }
}
