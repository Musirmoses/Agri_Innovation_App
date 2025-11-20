import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/training_provider.dart';
import '../../widgets/section_title.dart';
import '../../navigation/routes.dart';

class TrainingHubScreen extends StatefulWidget {
  const TrainingHubScreen({super.key});

  @override
  State<TrainingHubScreen> createState() => _TrainingHubScreenState();
}

class _TrainingHubScreenState extends State<TrainingHubScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TrainingProvider>(context, listen: false).loadCourses();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TrainingProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Training Hub")),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SectionTitle(title: "Available Courses"),
                const SizedBox(height: 14),
                ...provider.courses.map(
                  (course) => Card(
                    child: ListTile(
                      title: Text(course.title),
                      subtitle: Text(course.description),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.courseDetail,
                          arguments: course,
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
