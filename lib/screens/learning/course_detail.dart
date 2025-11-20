import 'package:flutter/material.dart';
import '../../models/training_course.dart';

class CourseDetailScreen extends StatelessWidget {
  final TrainingCourse course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(course.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              course.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 6),

            Text("Category: ${course.category}"),
            const SizedBox(height: 6),

            Text("Level: ${course.level}"),
            const SizedBox(height: 6),

            Text("Estimated Time: ${course.estimatedTime}"),
            const SizedBox(height: 14),

            Text(course.description),
            const SizedBox(height: 20),

            const Text(
              "Lessons",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            ...course.lessons.map((l) => Card(
                  child: ListTile(
                    title: Text(l.title),
                    subtitle: Text("Duration: ${l.duration}"),
                    trailing: const Icon(Icons.play_circle),
                    onTap: () {
                      if (l.videoUrl != null) {
                        // TODO: Video player screen
                      }
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
