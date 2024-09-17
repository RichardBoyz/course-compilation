import 'package:course/models/course_model.dart';
import 'package:dio/dio.dart';

import '../../models/user_model.dart';

class CourseService {
  late Dio dio;

  CourseService(this.dio);

  Future<List<Course>> getCourses(Map<String, dynamic>? params) async {
    try {
      var response = await dio.get('courses', queryParameters: params);
      List<Course> courses = (response.data as List)
          .map((courseJson) => Course.fromJson(courseJson))
          .toList();
      return courses;
    } catch (error) {
      print(error);
      return [];
    }
  }

  Future createCourse(Map<String, dynamic>? data) async {
    try {
      await dio.post('courses/', data: data);
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future enrollCourse(int courseId, Map<String, dynamic>? data) async {
    try {
      await dio.patch('courses/$courseId/', data: data);
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future deleteCourse(int courseId) async {
    try {
      await dio.delete('courses/$courseId/');
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<Course> getCourse(int courseId) async {
    try {
      var response = await dio.get('courses/$courseId/');
      return Course.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  Future<Course> updateCourse(int courseId, Map<String, dynamic> data) async {
    try {
      var response = await dio.patch('courses/$courseId/', data: data);
      Course course = Course.parseToDisplayFormat(response.data);
      return course;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Course>> getEnrolledCourses() async {
    try {
      var response = await dio.get('courses/enrolled-courses/');
      List<Course> courses = (response.data as List)
          .map((courseJson) => Course.fromJson(courseJson))
          .toList();
      return courses;
    } catch (error) {
      print(error);
      return [];
    }
  }

  Future cancelCourse(int courseId) async {
    try {
      await dio.delete('courses/$courseId/cancel-course');
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<List<Course>> getMyCourses() async {
    try {
      var response = await dio.get('courses/my-courses/');
      List<Course> courses = (response.data as List)
          .map((courseJson) => Course.fromJson(courseJson))
          .toList();
      return courses;
    } catch (error) {
      print(error);
      return [];
    }
  }

  Future<List<User>> getCourseStudents(int courseId) async {
    try {
      var response = await dio.get('courses/$courseId/students');
      List<User> students = (response.data as List)
          .map((studentJson) => User.fromJson(studentJson))
          .toList();
      return students;
    } catch (error) {
      print(error);
      return [];
    }
  }
}
