import 'package:course/services/user/user_service.dart';
import 'package:flutter/material.dart';

import '../models/teacher_model.dart';

class TeacherPage extends StatefulWidget {
  const TeacherPage({super.key});

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  @override
  void initState() {
    super.initState();
    _getTeachers();
  }

  List<bool> _customTileExpanded = [];

  Future<void> _getTeachers() async {
    var teachers = await getTeachers();
    setState(() {
      teacherList = teachers;
      _customTileExpanded = List.generate(teachers.length, (index) => false);
    });
  }

  List<Teacher> teacherList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('講師'),
      ),
      body: ListView.builder(
        itemCount: teacherList.length,
        itemBuilder: (context, index) {
          var teacher = teacherList[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: const BorderSide(color: Colors.black, width: 2.0),
              ),
              child: ExpansionTile(
                title: Text(teacher.name),
                subtitle: Text('Email: ${teacher.email}'),
                trailing: Icon(
                  _customTileExpanded[index] ? Icons.remove : Icons.add,
                ),
                onExpansionChanged: (value) => setState(() {
                  _customTileExpanded[index] = value;
                }),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: teacher.teachCourses.map((course) {
                      return ListTile(
                        title: Text(course.name),
                        subtitle:
                            Text('${course.timeWeek}, ${course.timePeriod}'),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
