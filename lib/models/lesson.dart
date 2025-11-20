class Lesson {
  final String title;
  final String? videoUrl;
  final String duration;

  Lesson({
    required this.title,
    this.videoUrl,
    required this.duration,
  });

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      title: map['title'] ?? '',
      videoUrl: map['video_url'],
      duration: map['duration'] ?? 'Unknown',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'video_url': videoUrl,
      'duration': duration,
    };
  }
}
