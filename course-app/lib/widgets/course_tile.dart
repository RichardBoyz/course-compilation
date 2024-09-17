import 'package:course/arguments/edit_course_page.dart';
import 'package:course/cache/cache.dart';
import 'package:course/models/course_model.dart';
import 'package:course/models/user_model.dart';
import 'package:course/services/course/course_service.dart';
import 'package:course/widgets/student_list_dialog.dart';
import 'package:flutter/material.dart';

class CourseTile extends StatelessWidget {
  final int courseId;
  final String name;
  final String timeWeek;
  final String timePeriod;
  final List<int> student;
  final bool isCreator;
  final bool canEnroll;
  final VoidCallback fatchNewCourses;
  final Function(Course) updateCourse;
  final bool? isCancellable;
  final CourseService courseService;

  const CourseTile(
      {required this.courseId,
      required this.name,
      required this.timeWeek,
      required this.timePeriod,
      required this.isCreator,
      required this.canEnroll,
      required this.student,
      required this.fatchNewCourses,
      required this.updateCourse,
      required this.courseService,
      this.isCancellable});

  @override
  Widget build(BuildContext context) {
    // 檢查是否顯示 PopupMenuButton
    bool shouldShowMenu = canEnroll || isCreator || (isCancellable ?? false);

    return ListTile(
      title: Text(name),
      subtitle: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black87),
                  children: [
                    const TextSpan(text: '每周時間: '),
                    TextSpan(
                      text: timeWeek,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: '\n上課時間: '),
                    TextSpan(
                      text: timePeriod,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            if (shouldShowMenu)
              PopupMenuButton<String>(
                onSelected: (String value) async {
                  // 根據選擇的值執行不同的操作
                  if (value == 'update') {
                    var result = await Navigator.pushNamed(
                        context, '/edit-course',
                        arguments: EditCoursePageArguments(courseId));
                    if (result != null && (result as Map)['isEdited']) {
                      updateCourse(result['course']);
                    }
                  } else if (value == 'addCourse') {
                    var userId = AppCache.userId;
                    var isUpdated = await courseService.enrollCourse(courseId, {
                      'student': [...student, userId]
                    });
                    if (isUpdated) {
                      SnackBar snackBar = _buildSnackBar('選課成功');
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      fatchNewCourses();
                    }
                  } else if (value == 'delete') {
                    var isDeleted = await courseService.deleteCourse(courseId);
                    if (isDeleted) {
                      SnackBar snackBar = _buildSnackBar('刪除成功');
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      fatchNewCourses();
                    }
                  } else if (value == 'cancelCourse') {
                    var isCanceled = await courseService.cancelCourse(courseId);
                    if (isCanceled) {
                      SnackBar snackBar = _buildSnackBar('退課完成');
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      fatchNewCourses();
                    }
                  } else if (value == 'studentList') {
                    List<User> students =
                        await courseService.getCourseStudents(courseId);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return StudentListDialog(students: students);
                      },
                    );
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  if (isCreator)
                    const PopupMenuItem<String>(
                      value: 'update',
                      child: ListTile(
                        leading: Icon(Icons.edit),
                        title: Text('更新'),
                      ),
                    ),
                  if (isCreator)
                    const PopupMenuItem<String>(
                      value: 'delete',
                      child: ListTile(
                        leading: Icon(Icons.delete),
                        title: Text('刪除'),
                      ),
                    ),
                  if (isCreator)
                    const PopupMenuItem<String>(
                      value: 'studentList',
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text('顯示學生'),
                      ),
                    ),
                  if (canEnroll)
                    const PopupMenuItem<String>(
                      value: 'addCourse',
                      child: ListTile(
                        leading: Icon(Icons.add_circle),
                        title: Text('加入選課'),
                      ),
                    ),
                  if ((isCancellable ?? false))
                    const PopupMenuItem<String>(
                      value: 'cancelCourse',
                      child: ListTile(
                        leading: Icon(Icons.cancel),
                        title: Text('取消課程'),
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  SnackBar _buildSnackBar(String text) {
    return SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 2),
    );
  }
}
