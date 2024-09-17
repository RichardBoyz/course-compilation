import 'package:course/arguments/edit_course_page.dart';
import 'package:flutter/material.dart';
import 'package:course/services/course/course_service.dart';
import 'package:course/widgets/course_form.dart';

import '../models/course_model.dart';

class EditCoursePage extends StatefulWidget {
  final EditCoursePageArguments? args;
  final CourseService courseService;
  const EditCoursePage(
      {super.key, required this.args, required this.courseService});

  @override
  _EditCoursePageState createState() => _EditCoursePageState();
}

class _EditCoursePageState extends State<EditCoursePage> {
  String selectedDay = '1';
  String selectedStartHour = '00';
  String selectedStartMinute = '00';
  String selectedEndHour = '00';
  String selectedEndMinute = '00';

  final TextEditingController _nameController = TextEditingController();
  bool _errorName = false;

  @override
  void initState() {
    super.initState();
    _fetchCourseData();
  }

  Future<void> _fetchCourseData() async {
    final courseId = widget.args!.courseId;
    try {
      Course fetchedCourse = await widget.courseService.getCourse(courseId);
      Map<String, String> courseTime = fetchedCourse.getTimePeriod();
      setState(() {
        _nameController.text = fetchedCourse.name;
        selectedDay = fetchedCourse.getTimeWeek();
        selectedStartHour = courseTime['startHour']!;
        selectedStartMinute = courseTime['startMinute']!;
        selectedEndHour = courseTime['endHour']!;
        selectedEndMinute = courseTime['endMinute']!;
      });
    } catch (error) {
      print('Error fetching course data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('編輯課程'),
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
          confirmText: '更新課程',
          onPressed: _updateCourse,
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

  Future<void> _updateCourse() async {
    String courseName = _nameController.text;
    setState(() {
      _errorName = courseName.isEmpty;
    });

    if (_errorName) {
      return;
    }
    String timeText =
        '$selectedStartHour:$selectedStartMinute-$selectedEndHour:$selectedEndMinute';
    String message = '更新成功';
    try {
      var updatedCourse =
          await widget.courseService.updateCourse(widget.args!.courseId, {
        'name': courseName,
        'time_period': timeText,
        'time_week': int.parse(selectedDay),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('更新成功'),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context, {'isEdited': true, 'course': updatedCourse});
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('建立失敗'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
