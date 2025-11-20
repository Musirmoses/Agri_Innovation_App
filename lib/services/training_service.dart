import '../models/training_course.dart';
import 'supabase_service.dart';

class TrainingService {
  final _db = SupabaseService().client;

  Future<List<TrainingCourse>> fetchCourses() async {
    final res = await _db.from("training_courses").select();
    return res.map<TrainingCourse>((e) => TrainingCourse.fromMap(e)).toList();
  }

  Future<TrainingCourse?> getCourse(String id) async {
    final res =
        await _db.from("training_courses").select().eq("id", id).maybeSingle();
    if (res == null) return null;
    return TrainingCourse.fromMap(res);
  }
}
