import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../navigation/routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/section_title.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final user = auth.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Farming Hub"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              auth.logout();
              Navigator.pushReplacementNamed(context, Routes.login);
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (user != null)
            Text(
              "Welcome, ${user.name}!",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          const SizedBox(height: 20),

          // FARM SECTION
          const SectionTitle(title: "My Farm"),
          ListTile(
            leading: const Icon(Icons.agriculture, color: AppColors.primary),
            title: const Text("Farm Dashboard"),
            subtitle: const Text("View your farms, plots and crops"),
            onTap: () =>
                Navigator.pushNamed(context, Routes.farmDashboard),
          ),

          const SizedBox(height: 20),

          // TOOLS & INSIGHTS
          const SectionTitle(title: "Tools & Insights"),

          ListTile(
            leading: const Icon(Icons.storefront, color: AppColors.primary),
            title: const Text("Seedling Marketplace"),
            subtitle: const Text("Find suppliers and seedling prices"),
            onTap: () =>
                Navigator.pushNamed(context, Routes.seedlingMarket),
          ),

          ListTile(
            leading: const Icon(Icons.school, color: AppColors.primary),
            title: const Text("Training Hub"),
            subtitle: const Text("Agriculture courses & lessons"),
            onTap: () =>
                Navigator.pushNamed(context, Routes.trainingHub),
          ),

          ListTile(
            leading: const Icon(Icons.cloud, color: AppColors.primary),
            title: const Text("Weather Forecast"),
            subtitle: const Text("Rainfall, temperature, seasons"),
            onTap: () =>
                Navigator.pushNamed(context, Routes.weather),
          ),

          const SizedBox(height: 20),

          // SETTINGS
          const SectionTitle(title: "Settings"),

          ListTile(
            leading: const Icon(Icons.person, color: AppColors.primary),
            title: const Text("Profile"),
            onTap: () =>
                Navigator.pushNamed(context, Routes.profile),
          ),
        ],
      ),
    );
  }
}
