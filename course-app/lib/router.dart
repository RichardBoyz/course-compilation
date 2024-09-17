import 'package:course/arguments/edit_course_page.dart';
import 'package:course/pages/enrolled_course.dart';
import 'package:course/pages/my_course_page.dart';
import 'package:course/services/course/course_service.dart';
import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/lobby_page.dart';
import 'pages/create_course_page.dart';
import 'pages/search_course_page.dart';
import 'pages/teachers_page.dart';
import 'pages/edit_course_page.dart';
import 'package:course/services/api.dart';

// 定義 router
final Map<String, WidgetBuilder> routes = {
  '/': (context) => HomePage(),
  '/login': (context) => const LoginPage(),
  '/register': (context) => const RegisterPage(),
  '/lobby': (context) => LobbyPage(),
  '/create-course': (context) => CreateCoursePage(
        courseService: CourseService(dio),
      ),
  '/search-course': (context) => SearchCoursePage(
        courseService: CourseService(dio),
      ),
  '/teachers': (context) => const TeacherPage(),
  '/edit-course': (context) => EditCoursePage(
        args: ModalRoute.of(context)!.settings.arguments
            as EditCoursePageArguments?,
        courseService: CourseService(dio),
      ),
  '/enrolled-courses': (context) => EnrolledCoursePage(
        courseService: CourseService(dio),
      ),
  '/my-courses': (context) => MyCoursePage(
        courseService: CourseService(dio),
      )
};
