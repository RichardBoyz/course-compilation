import 'package:flutter/material.dart';

class CourseForm extends StatelessWidget {
  final TextEditingController nameController;
  final String selectedDay;
  final String selectedStartHour;
  final String selectedStartMinute;
  final String selectedEndHour;
  final String selectedEndMinute;
  final String confirmText;
  final Function() onPressed;
  final bool errorName;
  final Function(String?)? onSelectedDayChanged;
  final Function(String?)? onSelectedStartHourChanged;
  final Function(String?)? onSelectedStartMinuteChanged;
  final Function(String?)? onSelectedEndHourChanged;
  final Function(String?)? onSelectedEndMinuteChanged;

  const CourseForm(
      {required this.nameController,
      required this.selectedDay,
      required this.selectedStartHour,
      required this.selectedStartMinute,
      required this.selectedEndHour,
      required this.selectedEndMinute,
      required this.confirmText,
      required this.onPressed,
      required this.errorName,
      required this.onSelectedDayChanged,
      required this.onSelectedStartHourChanged,
      required this.onSelectedStartMinuteChanged,
      required this.onSelectedEndHourChanged,
      required this.onSelectedEndMinuteChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: '課程名稱',
            border: const OutlineInputBorder(),
            errorText: errorName ? '請輸入課程名稱' : null,
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        const Text('每周'),
        DropdownButtonFormField<String>(
          value: selectedDay,
          decoration: const InputDecoration(labelText: '星期'),
          items: const [
            DropdownMenuItem(value: '1', child: Text('每周一')),
            DropdownMenuItem(value: '2', child: Text('每周二')),
            DropdownMenuItem(value: '3', child: Text('每周三')),
            DropdownMenuItem(value: '4', child: Text('每周四')),
            DropdownMenuItem(value: '5', child: Text('每周五')),
            DropdownMenuItem(value: '6', child: Text('每周六')),
            DropdownMenuItem(value: '7', child: Text('每周日')),
          ],
          onChanged: onSelectedDayChanged,
        ),
        const SizedBox(height: 20.0),
        const Text('開始時間'),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: selectedStartHour,
                decoration: const InputDecoration(labelText: '小時'),
                items: List.generate(24, (index) {
                  return DropdownMenuItem(
                    value: index.toString().padLeft(2, '0'),
                    child: Text(index.toString().padLeft(2, '0')),
                  );
                }),
                onChanged: onSelectedStartHourChanged,
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: selectedStartMinute,
                decoration: const InputDecoration(labelText: '分鐘'),
                items: List.generate(60 ~/ 5, (index) {
                  final minute = index * 5;
                  return DropdownMenuItem(
                    value: minute.toString().padLeft(2, '0'),
                    child: Text(minute.toString().padLeft(2, '0')),
                  );
                }),
                onChanged: onSelectedStartMinuteChanged,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        const Text('結束時間'),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: selectedEndHour,
                decoration: const InputDecoration(labelText: '小時'),
                items: List.generate(24, (index) {
                  return DropdownMenuItem(
                    value: index.toString().padLeft(2, '0'),
                    child: Text(index.toString().padLeft(2, '0')),
                  );
                }),
                onChanged: onSelectedEndHourChanged,
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: selectedEndMinute,
                decoration: const InputDecoration(labelText: '分鐘'),
                items: List.generate(60 ~/ 5, (index) {
                  final minute = index * 5;
                  return DropdownMenuItem(
                    value: minute.toString().padLeft(2, '0'),
                    child: Text(minute.toString().padLeft(2, '0')),
                  );
                }),
                onChanged: onSelectedEndMinuteChanged,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: onPressed,
          child: Text(confirmText),
        ),
      ],
    );
  }
}
