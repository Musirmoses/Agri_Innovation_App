import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/farm_provider.dart';
import '../../widgets/farm_card.dart';
import '../../navigation/routes.dart';

import 'add_farm_screen.dart';

class FarmDashboard extends StatefulWidget {
  const FarmDashboard({super.key});

  @override
  State<FarmDashboard> createState() => _FarmDashboardState();
}

class _FarmDashboardState extends State<FarmDashboard> {
  @override
  void initState() {
    super.initState();
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final farmProvider = Provider.of<FarmProvider>(context, listen: false);
    if (auth.user != null) {
      farmProvider.loadFarms(auth.user!.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final farmProvider = Provider.of<FarmProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("My Farms")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddFarmScreen()),
        ),
      ),
      body: farmProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : farmProvider.farms.isEmpty
              ? const Center(child: Text("No farms added yet"))
              : ListView.builder(
                  itemCount: farmProvider.farms.length,
                  itemBuilder: (context, index) {
                    final farm = farmProvider.farms[index];
                    return FarmCard(
                      farm: farm,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.plotDetail,
                          arguments: farm,
                        );
                      },
                    );
                  },
                ),
    );
  }
}
