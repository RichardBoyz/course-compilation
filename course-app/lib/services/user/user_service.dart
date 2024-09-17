import 'package:course/models/teacher_model.dart';
import 'package:course/services/api.dart';

Future getUsers() async {
  try {
    var response = await dio.get(
      'users',
    );
  } catch (error) {
    print(error);
  }
}

Future<List<Teacher>> getTeachers() async {
  try {
    var response = await dio.get(
      'users/teachers/',
    );
    List<Teacher> teachers = (response.data as List)
        .map((teacherJson) => Teacher.fromJson(teacherJson))
        .toList();
    return teachers;
  } catch (error) {
    print(error);
    return [];
  }
}
