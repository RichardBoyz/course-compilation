import 'course_model.dart';

class Teacher {
  final int id;
  final String name;
  final String email;
  final List<Course> teachCourses;

  Teacher({
    required this.id,
    required this.name,
    required this.email,
    required this.teachCourses,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    var teachCoursesData = json['teach_courses'] as List;
    List<Course> teachCourses = teachCoursesData
        .map((courseJson) => Course.fromJson(courseJson))
        .toList();

    return Teacher(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      teachCourses: teachCourses,
    );
  }
}
