import 'package:flutter/material.dart';
import 'package:course/services/course/course_service.dart';
import 'package:course/widgets/course_form.dart';

class CreateCoursePage extends StatefulWidget {
  final CourseService courseService;

  const CreateCoursePage({super.key, required this.courseService});
  @override
  _CreateCoursePageState createState() => _CreateCoursePageState();
}

class _CreateCoursePageState extends State<CreateCoursePage> {
  String selectedDay = '1';
  String selectedStartHour = '00';
  String selectedStartMinute = '00';
  String selectedEndHour = '00';
  String selectedEndMinute = '00';

  final TextEditingController _nameController = TextEditingController();
  bool _errorName = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('建立課程'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CourseForm(
          nameController: _nameController,
          selectedDay: selectedDay,
          selectedStartHour: selectedStartHour,
          selectedStartMinute: selectedStartMinute,
          selectedEndHour: selectedEndHour,
          selectedEndMinute: selectedEndMinute,
          confirmText: '建立課程',
          onPressed: _createCourse,
          errorName: _errorName,
          onSelectedDayChanged: (p0) => setState(() {
            selectedDay = p0 as String;
          }),
          onSelectedStartHourChanged: (p0) => setState(() {
            selectedStartHour = p0 as String;
          }),
          onSelectedStartMinuteChanged: (p0) => setState(() {
            selectedStartMinute = p0 as String;
          }),
          onSelectedEndHourChanged: (p0) => setState(() {
            selectedEndHour = p0 as String;
          }),
          onSelectedEndMinuteChanged: (p0) => setState(() {
            selectedEndMinute = p0 as String;
          }),
        ),
      ),
    );
  }

  Future<void> _createCourse() async {
    String courseName = _nameController.text;
    setState(() {
      _errorName = courseName.isEmpty;
    });

    if (_errorName) {
      return;
    }
    String timeText =
        '$selectedStartHour:$selectedStartMinute-$selectedEndHour:$selectedEndMinute';
    String message = '建立成功';
    try {
      var isCreateSuccessed = await widget.courseService.createCourse({
        'name': courseName,
        'time_period': timeText,
        'time_week': int.parse(selectedDay),
      });

      if (isCreateSuccessed) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('建立成功'),
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('建立失敗'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      print(error);
    }
  }
}
