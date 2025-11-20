import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/farm.dart';
import '../../providers/farm_provider.dart';
import '../../providers/crop_provider.dart';

import '../../widgets/plot_card.dart';


import 'add_plot_screen.dart';
import 'add_crop_screen.dart';

class PlotDetailScreen extends StatefulWidget {
  final Farm farm;

  const PlotDetailScreen({required this.farm, super.key});

  @override
  State<PlotDetailScreen> createState() => _PlotDetailScreenState();
}

class _PlotDetailScreenState extends State<PlotDetailScreen> {
  @override
  void initState() {
    super.initState();

    Provider.of<FarmProvider>(context, listen: false)
        .loadPlots(widget.farm.id);
  }

  @override
  Widget build(BuildContext context) {
    final farmProvider = Provider.of<FarmProvider>(context);
    final cropProvider = Provider.of<CropProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.farm.name)),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddPlotScreen(farm: widget.farm),
            ),
          );
        },
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text("Plots",
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 10),

          if (farmProvider.plots.isEmpty)
            const Center(child: Text("No plots found.")),
          ...farmProvider.plots.map(
            (plot) => PlotCard(
              plot: plot,
              onTap: () {
                cropProvider.loadCrops(plot.id);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddCropScreen(plot: plot),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
