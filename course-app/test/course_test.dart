import 'package:flutter_test/flutter_test.dart';
import 'package:course/services/course/course_service.dart'; // 更換成你的服務文件
import 'package:course/models/course_model.dart';
import 'package:dio/dio.dart';

class User {
  final String email;
  final String password;

  User({required this.email, required this.password});
}

User studentWhoHasEnrolledCourse =
    User(email: 'f@a.com', password: 'f'); // 有課程的學生帳號
User teacherWhoHasCourse = User(email: 'cc@a.com', password: 'c'); // 有課程的老師帳號
User teacherWithoutCourse = User(email: 'g@a.com', password: 'g'); // 沒課程的老師帳號

void main() {
  Dio dio = Dio();

  dio.options.baseUrl = 'http://127.0.0.1:8000/api/';

  CourseService courseService = CourseService(dio);
  group('Teacher usecase Tests', () {
    // 有課程的老師
    test('Test teacher does not have enrolled course', () async {
      await login(dio, teacherWhoHasCourse);
      // 取得該學生加入的課程 list
      List<Course> courses = await courseService.getEnrolledCourses();

      // 驗證
      expect(courses.isEmpty, true);
    });

    // 沒課程的老師
    test('Test teacher without courses', () async {
      await login(dio, teacherWithoutCourse);
      // 取得該學生加入的課程 list
      List<Course> courses = await courseService.getEnrolledCourses();

      // 驗證
      expect(courses.isEmpty, true);
    });
  });

  group('Student usecase Tests', () {
    // 測試有課程的學生
    test('Test student who has enrolled-courses', () async {
      await login(dio, studentWhoHasEnrolledCourse);
      // 取得該學生加入的課程 list
      List<Course> courses = await courseService.getEnrolledCourses();

      // 驗證
      expect(courses.isNotEmpty, true);
    });
  });
}

// 登入函數示例
Future<void> login(Dio dio, User user) async {
  try {
    var response = await dio.post(
      'login',
      data: {'email': user.email, 'password': user.password},
    );
    String token = response.data['token']; // 假設登入成功後返回 token
    dio.options.headers['Authorization'] =
        'Bearer $token'; // 設置 Authorization header
  } catch (error) {
    print(error);
  }
}
