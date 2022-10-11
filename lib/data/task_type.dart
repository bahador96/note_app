import 'package:flutter_application_1/data/type_enum.dart';
import 'package:hive/hive.dart';

part 'task_type.g.dart';

@HiveType(typeId: 4)
class TaskType {
  TaskType({
    required this.image,
    required this.title,
    required this.taskTypeEnum,
  });
  @HiveField(0)
  String image;

  @HiveField(1)
  String title;

  @HiveField(2)
  TaskTypeEnum taskTypeEnum;
}
