import 'package:flutter/material.dart';
import 'package:course/models/user_model.dart';

class StudentListDialog extends StatelessWidget {
  final List<User> students;

  const StudentListDialog({required this.students});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('上課的學生'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: students.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 2, // 设置卡片的阴影
              margin: const EdgeInsets.symmetric(
                  vertical: 4, horizontal: 8), // 设置卡片的外边距
              child: ListTile(
                title: Text('姓名: ${students[index].name}'),
                subtitle: Text('信箱: ${students[index].email}'),
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('關閉'),
        ),
      ],
    );
  }
}
