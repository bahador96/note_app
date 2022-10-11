// import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/data/task_type.dart';
import 'package:flutter_application_1/data/type_enum.dart';

List<TaskType> getTaskTypeList() {
  var list = [
    TaskType(
      image: 'images/meditate.png',
      title: 'تمرکز',
      taskTypeEnum: TaskTypeEnum.focus,
    ),
    TaskType(
      image: 'images/social_frends.png',
      title: 'میتینگ',
      taskTypeEnum: TaskTypeEnum.date,
    ),
    TaskType(
      image: 'images/hard_working.png',
      title: 'کار زیاد',
      taskTypeEnum: TaskTypeEnum.working,
    ),
  ];
  return list;
}
