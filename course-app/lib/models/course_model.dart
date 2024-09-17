class Course {
  final int id;
  final String timeWeek;
  final String name;
  final String timePeriod;
  final int creator;
  final List<int> student;
  final List<int> lecturers;

  Course({
    required this.id,
    required this.timeWeek,
    required this.name,
    required this.timePeriod,
    required this.creator,
    required this.student,
    required this.lecturers,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      timeWeek: json['time_week'].toString(),
      name: json['name'],
      timePeriod: json['time_period'],
      creator: json['creator'],
      student: List<int>.from(json['student']),
      lecturers: List<int>.from(json['lecturers']),
    );
  }

  factory Course.parseToDisplayFormat(Map<String, dynamic> json) {
    Map<String, String> timeWeekDict = {
      '1': '每周一',
      '2': '每周二',
      '3': '每周三',
      '4': '每周四',
      '5': '每周五',
      '6': '每周六',
      '7': '每周日',
    };
    return Course(
      id: json['id'],
      timeWeek: timeWeekDict[json['time_week'].toString()]!,
      name: json['name'],
      timePeriod: json['time_period'],
      creator: json['creator'],
      student: List<int>.from(json['student']),
      lecturers: List<int>.from(json['lecturers']),
    );
  }

  Map<String, String> getTimePeriod() {
    List<String> parts = timePeriod.split('-');
    List<String> startParts = parts[0].split(':');
    List<String> endParts = parts[1].split(':');

    String startHour = startParts[0];
    String startMinute = startParts[1];
    String endHour = endParts[0];
    String endMinute = endParts[1];

    return {
      'startHour': startHour,
      'startMinute': startMinute,
      'endHour': endHour,
      'endMinute': endMinute,
    };
  }

  String getTimeWeek() {
    Map<String, String> timeWeekDict = {
      '每周一': '1',
      '每周二': '2',
      '每周三': '3',
      '每周四': '4',
      '每周五': '5',
      '每周六': '6',
      '每周日': '7',
    };
    return timeWeekDict[timeWeek]!;
  }
}
