// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/task.dart';
import 'package:flutter_application_1/utility/utility.dart';
import 'package:flutter_application_1/widget/task_type_item.dart';
import 'package:hive/hive.dart';
import 'package:time_pickerr/time_pickerr.dart';

class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({Key? key, required this.task}) : super(key: key);

  Task task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();

  TextEditingController? controllerTaskTitle;
  TextEditingController? controllerTaskSubTitle;

  final box = Hive.box<Task>('taskBox');
  int _selectedTaskTypeItem = 0;

  DateTime? _time;

  @override
  void initState() {
    super.initState();
    controllerTaskTitle = TextEditingController(text: widget.task.title);
    controllerTaskSubTitle = TextEditingController(text: widget.task.subTitle);

    negahban1.addListener(() {
      setState(() {});
    });
    negahban2.addListener(() {
      setState(() {});
    });

    var indext = getTaskTypeList().indexWhere((element) {
      return element.taskTypeEnum == widget.task.taskType.taskTypeEnum;
    });

    _selectedTaskTypeItem = indext;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 44),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      controller: controllerTaskTitle,
                      focusNode: negahban1,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        labelText: 'عنوان تسک',
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: negahban1.hasFocus
                              ? const Color(0xff18DAA3)
                              : const Color(0xffC5C5C5),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide:
                              BorderSide(color: Color(0xffC5C5C5), width: 3.0),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            width: 3,
                            color: Color(0xff18DAA3),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 44),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      controller: controllerTaskSubTitle,
                      maxLines: 2,
                      focusNode: negahban2,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        labelText: 'توضیحات تسک',
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: negahban2.hasFocus
                              ? const Color(0xff18DAA3)
                              : const Color(0xffC5C5C5),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide:
                              BorderSide(color: Color(0xffC5C5C5), width: 3.0),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            width: 3,
                            color: Color(0xff18DAA3),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: CustomHourPicker(
                    title: 'زمان تسک را انتخاب کن',
                    negativeButtonText: 'حذف کن',
                    positiveButtonText: 'انتخاب زمان',
                    titleStyle: const TextStyle(
                      color: Color(0xff18DAA3),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    negativeButtonStyle: const TextStyle(
                      color: Color.fromARGB(255, 218, 92, 24),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    positiveButtonStyle: const TextStyle(
                      color: Color(0xff18DAA3),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    elevation: 2,
                    onPositivePressed: (context, time) {
                      _time = time;
                      // (DateTime == time) ? _time = time : DateTime.now();
                    },
                    onNegativePressed: (context) {},
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: getTaskTypeList().length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedTaskTypeItem = index;
                          });
                        },
                        child: TaskTypeItemList(
                          taskType: getTaskTypeList()[index],
                          index: index,
                          selectedItemList: _selectedTaskTypeItem,
                        ),
                      );
                    },
                  ),
                ),
                // Spacer(),
                ElevatedButton(
                  onPressed: () {
                    String taskTitle = controllerTaskTitle!.text;
                    String taskSubTitle = controllerTaskSubTitle!.text;

                    editTask(taskTitle, taskSubTitle);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff18DAA3),
                    minimumSize: const Size(200, 48),
                  ),
                  child: const Text(
                    'ویرایش کردن تسک',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  editTask(String taskTitle, String taskSubTitle) {
    widget.task.title = taskTitle;
    widget.task.subTitle = taskSubTitle;

    if (_time == null) {
      widget.task.time = DateTime.now();
    } else {
      widget.task.time = _time!;
    }
    widget.task.taskType = getTaskTypeList()[_selectedTaskTypeItem];
    widget.task.save();
  }
}
