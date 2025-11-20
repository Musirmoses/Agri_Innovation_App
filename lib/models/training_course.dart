import 'lesson.dart';

class TrainingCourse {
  final String id;
  final String title;
  final String category;
  final String level;
  final String? videoUrl;
  final String description;
  final String estimatedTime;
  final List<Lesson> lessons; // NEW

  TrainingCourse({
    required this.id,
    required this.title,
    required this.category,
    required this.level,
    this.videoUrl,
    required this.description,
    required this.estimatedTime,
    required this.lessons,
  });

  factory TrainingCourse.fromMap(Map<String, dynamic> map) {
    return TrainingCourse(
      id: map['id'],
      title: map['title'],
      category: map['category'],
      level: map['level'],
      videoUrl: map['video_url'],
      description: map['description'],
      estimatedTime: map['estimated_time'],
      lessons: (map['lessons'] as List<dynamic>?)
              ?.map((l) => Lesson.fromMap(l))
              .toList() 
          ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'level': level,
      'video_url': videoUrl,
      'description': description,
      'estimated_time': estimatedTime,
      'lessons': lessons.map((l) => l.toMap()).toList(), // NEW
    };
  }
}
